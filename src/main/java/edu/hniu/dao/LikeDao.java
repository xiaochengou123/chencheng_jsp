package edu.hniu.dao;

import edu.hniu.model.ArtistsDetail;
import edu.hniu.model.SongSheet;
import edu.hniu.utils.ConnUtils;
import lombok.var;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class LikeDao {
    // ==================== 新增歌曲（type=1） ====================
    // 新增核心方法：查询用户已点赞的所有歌曲ID
    public List<Integer> getLikedSongIds(Integer userId) throws SQLException {
        String sql = "SELECT target_id FROM MyLike WHERE user_id = ? AND type = 1";
        return Borrow(userId, sql);
    }

    public boolean addMyLike(Integer userId, Integer songId) throws SQLException {
        if (isMyLike(userId, songId)) {
            return false;
        }
        String sql = "INSERT INTO MyLike (user_id, type, target_id) VALUES (?, 1, ?)";
        return executeUpdate(userId, songId, sql);
    }

    public boolean deleteMyLike(Integer userId, Integer songId) throws SQLException {
        String sql = "DELETE FROM MyLike WHERE user_id = ? AND type = 1 AND target_id = ?";
        return executeUpdate(userId, songId, sql);
    }

    public boolean isMyLike(Integer userId, Integer songId) throws SQLException {
        String sql = "SELECT 1 FROM MyLike WHERE user_id = ? AND type = 1 AND target_id = ? LIMIT 1";
        return exists(userId, songId, sql);
    }

    // ==================== 新增歌单（type=2） ====================
    /**
     * 查询用户已喜欢的所有歌单ID
     */
    public List<Integer> getLikedSongSheetIds(Integer userId) throws SQLException {
        String sql = "SELECT target_id FROM MyLike WHERE user_id = ? AND type = 2";
        return Borrow(userId, sql);
    }

    private List<Integer> Borrow(Integer userId, String sql) throws SQLException {
        Connection conn = ConnUtils.borrow();
        PreparedStatement prep = conn.prepareStatement(sql);
        prep.setInt(1, userId);
        ResultSet rs = prep.executeQuery();

        List<Integer> likedSheetIds = new ArrayList<>();
        while (rs.next()) {
            likedSheetIds.add(rs.getInt("target_id"));
        }
        rs.close();
        prep.close();
        ConnUtils.returnConnection(conn);
        return likedSheetIds;
    }

    /**
     * 添加歌单喜欢（type=2）
     */
    public boolean addSheetLike(Integer userId, Integer sheetId) throws SQLException {
        // 先判断是否已喜欢
        if (isSheetLiked(userId, sheetId)) {
            return false;
        }
        String sql = "INSERT INTO MyLike (user_id, type, target_id) VALUES (?, 2, ?)";
        return executeUpdate(userId, sheetId, sql);
    }

    /**
     * 取消歌单喜欢（删除记录）
     */
    public boolean deleteSheetLike(Integer userId, Integer sheetId) throws SQLException {
        String sql = "DELETE FROM MyLike WHERE user_id = ? AND type = 2 AND target_id = ?";
        return executeUpdate(userId, sheetId, sql);
    }

    /**
     * 判断用户是否喜欢该歌单
     */
    public boolean isSheetLiked(Integer userId, Integer sheetId) throws SQLException {
        String sql = "SELECT 1 FROM MyLike WHERE user_id = ? AND type = 2 AND target_id = ? LIMIT 1";
        return exists(userId, sheetId, sql);
    }

    // ==================== 通用工具方法（优化原有ConnUtils方法命名） ====================
    private boolean executeUpdate(Integer userId, Integer targetId, String sql) throws SQLException {
        Connection conn = ConnUtils.borrow();
        PreparedStatement prep = conn.prepareStatement(sql);
        prep.setInt(1, userId);
        prep.setInt(2, targetId);
        int rows = prep.executeUpdate();
        prep.close();
        ConnUtils.returnConnection(conn);
        return rows > 0;
    }

    private boolean exists(Integer userId, Integer targetId, String sql) throws SQLException {
        Connection conn = ConnUtils.borrow();
        PreparedStatement prep = conn.prepareStatement(sql);
        prep.setInt(1, userId);
        prep.setInt(2, targetId);
        ResultSet rs = prep.executeQuery();
        boolean exists = rs.next();
        rs.close();
        prep.close();
        ConnUtils.returnConnection(conn);
        return exists;
    }
    /**
     * 查询用户的所有喜欢的歌曲信息/歌单信息
     * @param userId 用户的ID
     * @param type 1:歌曲, 2:歌单
     */
    public List<Object> getAllLikedInfo(Integer userId,Integer type) throws SQLException {
        //初始化StringBuilder，指定初始容量512（适配SQL长度）
        StringBuilder songSqlBuilder = new StringBuilder(512);

        if(type==1){
            songSqlBuilder.append("SELECT ")
                    .append("si.id AS singer_id, ")
                    .append("si.singerName as singerName, ")
                    .append("so.songCover as songCover, ")
                    .append("so.type, ")
                    .append("so.id AS song_id, ")
                    .append("so.album, ")
                    .append("so.songName as songName, ")
                    .append("so.time ")
                    .append("FROM issue iss ")
                    .append("LEFT JOIN singer si ON si.id = iss.singer_id ")
                    .append("LEFT JOIN song so ON so.id = iss.song_id ")
                    .append("WHERE so.id IN ( ")
                    .append("    SELECT m1.target_id AS so_id ")
                    .append("    FROM mylike m1 ")
                    .append("    LEFT JOIN user u1 ON m1.user_id = u1.id ")
                    .append("    WHERE m1.type = 1 AND u1.id = ? ") // 替换14为占位符?
                    .append(") ")
                    .append("ORDER BY si.id");
        }else if(type==2){
            songSqlBuilder.append("SELECT ")
                    .append("ss.id AS song_sheet_id, ")        // 歌单ID
                    .append("ss.song_sheet_name, ")           // 歌单名称
                    .append("ss.song_sheet_resume, ")         // 歌单简介
                    .append("ss.song_sheet_avatar, ")         // 歌单封面
                    .append("COUNT(DISTINCT so.id) AS song_count ")  // 歌曲数量（去重）
                    .append("FROM songSheet ss ")
                    .append("LEFT JOIN songSheetSong sss ON ss.id = sss.song_sheet_id ")
                    .append("LEFT JOIN song so ON sss.song_id = so.id ")
                    .append("LEFT JOIN mylike ml ON ml.type = 2 AND ml.target_id = ss.id ")
                    .append("LEFT JOIN user u1 ON ml.user_id = u1.id ")
                    .append("WHERE u1.id = ? ") // 替换14为占位符?
                    .append("GROUP BY ss.id, ss.song_sheet_name, ss.song_sheet_resume, ss.song_sheet_avatar ")
                    .append("ORDER BY song_count DESC");
        }else{
            throw new RuntimeException("参数错误! 类型->只能1:歌曲 2:歌单!!!!");
        }
        Connection conn = ConnUtils.borrow();
        PreparedStatement prep = conn.prepareStatement(songSqlBuilder.toString());
        prep.setInt(1, userId);
        ResultSet rs = prep.executeQuery();
        List<Object> list =new ArrayList<>();
        while (rs.next()) {
            if(type==1){
                var artistsDetail = new ArtistsDetail();
                artistsDetail.setSingerId(rs.getInt("singer_id"));
                artistsDetail.setSingerName(rs.getString("singerName"));
                artistsDetail.setAvatar(rs.getString("songCover"));
                artistsDetail.setAlbum(rs.getString("album"));
                artistsDetail.setTime(rs.getString("time"));
                artistsDetail.setSongId(rs.getInt("song_id"));
                artistsDetail.setSongName(rs.getString("songName"));
                list.add(artistsDetail);
            }
            else {
                SongSheet songSheet = new SongSheet();
                songSheet.setId(rs.getInt("song_sheet_id"));
                songSheet.setSongSheetName(rs.getString("song_sheet_name"));
                songSheet.setSongSheetResume(rs.getString("song_sheet_resume"));
                songSheet.setSongCount(rs.getInt("song_count"));
                songSheet.setSongSheetAvatar(rs.getString("song_sheet_avatar"));
                list.add(songSheet);
            }
        }
        rs.close();
        prep.close();
        ConnUtils.returnConnection(conn);


        return list;
    }
    public static void main(String[] args) throws SQLException {
        LikeDao likeDao = new LikeDao();
        System.out.println(likeDao.getAllLikedInfo(14,2));
    }
}
