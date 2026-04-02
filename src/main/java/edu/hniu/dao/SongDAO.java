package edu.hniu.dao;

import edu.hniu.model.Song;
import edu.hniu.utils.ConnUtils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class SongDAO {
    // 每页显示9首（匹配你页面的3*3布局）
    private static final int DEFAULT_PAGE_SIZE = 9;

    /**
     * 分页查询歌曲（支持国籍筛选）
     * @param pageNum 当前页码
     * @param nationality 国籍筛选（null/空=全部，"中国"/"日本"）
     * @return 分页歌曲列表
     */
    public List<Song> findSongsByPage(int pageNum, String nationality) {
        List<Song> songs = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        // 关联Issue(发行表)、Singer(歌手表)获取国籍，支持筛选
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT s.id, s.songName, s.time, s.album, s.releaseDate, s.songCover, s.songFile, s.type ");
        sql.append("FROM song s ");
        sql.append("LEFT JOIN issue i ON s.id = i.song_id ");
        sql.append("LEFT JOIN singer sg ON i.singer_id = sg.id ");
        if (nationality != null && !nationality.isEmpty()) {
            sql.append("WHERE sg.nationality = ? ");
        }
        sql.append("ORDER BY s.releaseDate DESC LIMIT ?, ?"); // 按发行日期倒序（最新优先）

        try {
            conn = ConnUtils.borrow();
            pstmt = conn.prepareStatement(sql.toString());
            
            // 设置参数：先筛选条件，再分页
            int paramIndex = 1;
            if (nationality != null && !nationality.isEmpty()) {
                pstmt.setString(paramIndex++, nationality);
            }
            pstmt.setInt(paramIndex++, (pageNum - 1) * DEFAULT_PAGE_SIZE);
            pstmt.setInt(paramIndex, DEFAULT_PAGE_SIZE);

            rs = pstmt.executeQuery();
            while (rs.next()) {
                Song song = new Song();
                song.setId(rs.getInt("id"));
                song.setSongName(rs.getString("songName"));
                song.setTime(rs.getInt("time")); // 时长（秒）
                song.setAlbum(rs.getString("album"));
                song.setReleaseDate(rs.getObject("releaseDate", java.time.LocalDate.class)); // 不转换格式
                song.setSongCover(rs.getString("songCover"));
                song.setSongFile(rs.getString("songFile"));
                song.setType(rs.getString("type"));
                songs.add(song);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("分页查询歌曲失败", e);
        } finally {
            // 关闭资源
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) ConnUtils.returnConnection(conn);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return songs;
    }

    /**
     * 获取符合条件的歌曲总数
     * @param nationality 国籍筛选条件
     * @return 总记录数
     */
    public int getSongTotalCount(String nationality) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int count = 0;

        StringBuilder sql = new StringBuilder();
        sql.append("SELECT COUNT(DISTINCT s.id) "); // 去重（避免同一歌曲关联多个歌手）
        sql.append("FROM song s ");
        sql.append("LEFT JOIN issue i ON s.id = i.song_id ");
        sql.append("LEFT JOIN singer sg ON i.singer_id = sg.id ");
        if (nationality != null && !nationality.isEmpty()) {
            sql.append("WHERE sg.nationality = ? ");
        }

        try {
            conn = ConnUtils.borrow();
            pstmt = conn.prepareStatement(sql.toString());
            
            if (nationality != null && !nationality.isEmpty()) {
                pstmt.setString(1, nationality);
            }

            rs = pstmt.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("查询歌曲总数失败", e);
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) ConnUtils.returnConnection(conn);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return count;
    }

    /**
     * 获取总页数
     * @param nationality 筛选条件
     * @return 总页数
     */
    public int getSongTotalPages(String nationality) {
        int totalCount = getSongTotalCount(nationality);
        return (totalCount + DEFAULT_PAGE_SIZE - 1) / DEFAULT_PAGE_SIZE; // 向上取整
    }

    // 测试方法
    public static void main(String[] args) {
        SongDAO dao = new SongDAO();
        System.out.println("中国歌曲总数：" + dao.getSongTotalCount("中国"));
        System.out.println("中国歌曲总页数：" + dao.getSongTotalPages("中国"));
        System.out.println("第一页中国歌曲：" + dao.findSongsByPage(1, "中国"));
    }
}