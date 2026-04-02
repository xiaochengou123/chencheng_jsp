package edu.hniu.dao;

import edu.hniu.model.ArtistsDetail;
import edu.hniu.utils.ConnUtils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class Artists_DetailDao {

    // 查询歌手详情和歌曲列表（保留）
    public List<ArtistsDetail> getArtists_DetailInfo(Integer singerId, String songName) throws SQLException {
        String sql = "SELECT si.id as singer_id, si.singerName, si.avatar, so.type, " +
                "so.id as song_id, so.album, so.songName, so.time " +
                "FROM issue i " +
                "LEFT JOIN singer si ON i.singer_id = si.id " +
                "LEFT JOIN song so ON i.song_id = so.id " +
                "WHERE si.id = ?";
        Connection conn = ConnUtils.borrow();
        PreparedStatement prep = null;
        if (songName != null && !songName.trim().isEmpty()) {
            sql += " and so.songName like ?";
            prep = conn.prepareStatement(sql);
            prep.setInt(1, singerId);
            prep.setString(2, "%" + songName + "%");
        } else {
            prep = conn.prepareStatement(sql);
            prep.setInt(1, singerId);
        }
        List<ArtistsDetail> list = new ArrayList<>();
        ResultSet result = prep.executeQuery();
        Playlist_detailsDao.traverse(result, list);
        result.close();
        prep.close();
        ConnUtils.returnConnection(conn);
        return list;
    }

    //查询歌手基础信息
    public ArtistsDetail getSingerBaseInfo(Integer singerId) throws SQLException {
        String sql = "SELECT id as singer_id, singerName, avatar, type FROM singer WHERE id = ?";
        Connection conn = ConnUtils.borrow();
        PreparedStatement prep = conn.prepareStatement(sql);
        prep.setInt(1, singerId);
        ResultSet result = prep.executeQuery();

        ArtistsDetail singer = null;
        if (result.next()) {
            singer = new ArtistsDetail();
            singer.setSingerId(result.getInt("singer_id"));
            singer.setSingerName(result.getString("singerName"));
            singer.setAvatar(result.getString("avatar"));
            singer.setType(result.getString("type"));
        }

        result.close();
        prep.close();
        ConnUtils.returnConnection(conn);
        return singer;
    }


}