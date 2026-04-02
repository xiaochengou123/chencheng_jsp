package edu.hniu.dao;

import edu.hniu.model.ArtistsDetail;
import edu.hniu.model.SongSheet;
import edu.hniu.utils.ConnUtils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

public class Playlist_detailsDao {
    /**
     *  查询所有歌单信息
     * @param sheet_id 歌单ID
     * @return 歌单
     * @throws SQLException SQL异常
     */
    public SongSheet getSongSheet(Integer sheet_id) throws SQLException {
        // 转为字符串使用
        StringBuilder sqlBuilder = new StringBuilder();
        sqlBuilder.append("SELECT ss.*, ")
                .append("       CASE ")
                .append("           WHEN sst.type = 1 THEN '抖音热歌' ")
                .append("           WHEN sst.type = 2 THEN '伤感情感' ")
                .append("           WHEN sst.type = 3 THEN '车载/DJ/劲爆舞曲' ")
                .append("           WHEN sst.type = 4 THEN '流行精选' ")
                .append("           WHEN sst.type = 5 THEN '影视原声' ")
                .append("           WHEN sst.type IS NULL THEN '未分类' ")
                .append("           ELSE '其他' ")
                .append("       END AS type_name ")
                .append("FROM songsheet ss ")
                .append("LEFT JOIN songsheettype sst ON ss.id = sst.song_sheet_id ")
                .append("WHERE ss.id = ? ");
        Connection conn = ConnUtils.borrow();
        PreparedStatement prep = conn.prepareStatement(sqlBuilder.toString());
        prep.setInt(1, sheet_id);
        ResultSet result = prep.executeQuery();
        SongSheet songSheets = new SongSheet();
        //去掉重复类别
        Set<String> types = new HashSet<>();

        while (result.next()) {
            songSheets.setId(result.getInt("id"));
            songSheets.setSongSheetName(result.getString("song_sheet_name"));
            songSheets.setSongSheetResume(result.getString("song_sheet_resume"));
            songSheets.setSongSheetAvatar(result.getString("song_sheet_avatar"));
            types.add(result.getString("type_name"));
        }
        songSheets.setType(new ArrayList<>(types));
        result.close();
        prep.close();
        ConnUtils.returnConnection(conn);
        return songSheets;
    }

    /**
     *  查询歌单歌曲信息
     * @param sheet_id 歌单ID
     * @return 歌单歌曲
     * @throws SQLException SQL异常
     */
    public List<ArtistsDetail> getArtists_DetailInfo(Integer sheet_id) throws SQLException {
        StringBuilder sqlBuilder = new StringBuilder();
        sqlBuilder.append("SELECT ")
                .append("si.id AS singer_id, ")
                .append("si.singerName, ")
                .append("si.avatar, ")
                .append("so.type, ")
                .append("so.id AS song_id, ")
                .append("so.album, ")
                .append("so.songName, ")
                .append("so.time ")
                .append("FROM songsheetsong sss ")
                .append("INNER JOIN song so ON sss.song_id = so.id ")
                .append("LEFT JOIN issue iss ON iss.song_id = so.id ")
                .append("LEFT JOIN singer si ON si.id = iss.singer_id ")
                .append("WHERE sss.song_sheet_id = ?");
        Connection conn = ConnUtils.borrow();
        PreparedStatement prep = conn.prepareStatement(sqlBuilder.toString());
        prep.setInt(1, sheet_id);
        ResultSet result = prep.executeQuery();
        List<ArtistsDetail> list = new ArrayList<>();
        traverse(result, list);
        result.close();
        prep.close();
        ConnUtils.returnConnection(conn);
        return list;
    }

    static void traverse(ResultSet result, List<ArtistsDetail> list) throws SQLException {
        while (result.next()) {
            ArtistsDetail row = new ArtistsDetail();
            row.setSingerId(result.getInt("singer_id"));
            row.setSingerName(result.getString("singerName"));
            row.setAvatar(result.getString("avatar"));
            row.setType(result.getString("type"));
            row.setAlbum(result.getString("album"));
            row.setSongName(result.getString("songName"));
            row.setTime(result.getString("time"));
            row.setSongId(result.getInt("song_id"));
            list.add(row);
        }

    }

    public static void main(String[] args) throws SQLException {
        Playlist_detailsDao playlist_detailsDao = new Playlist_detailsDao();
        System.out.println(playlist_detailsDao.getSongSheet(1));
        System.out.println(playlist_detailsDao.getArtists_DetailInfo(1));
    }
}
