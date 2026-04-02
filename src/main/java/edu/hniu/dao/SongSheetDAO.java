package edu.hniu.dao;

import edu.hniu.model.SongSheet;
import edu.hniu.utils.ConnUtils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * 歌单数据访问层
 * 严格适配实体类属性名：songSheetName/songSheetAvatar/songSheetResume
 */
public class SongSheetDAO {
    
    /**
     * 分页查询歌单
     * @param pageNum 当前页码
     * @param pageSize 每页数量
     * @return 歌单列表
     */
    public List<SongSheet> findSongSheetsByPage(int pageNum, int pageSize) {
        List<SongSheet> songSheets = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        // 修改SQL：直接查询歌曲数，无需子查询后再调用方法
        String sql = "SELECT ss.id, ss.song_sheet_name, ss.song_sheet_resume, ss.song_sheet_avatar, " +
                "(SELECT COUNT(*) FROM songsheetsong sss WHERE sss.song_sheet_id = ss.id) as song_count " +
                "FROM songsheet ss LIMIT ?, ?";

        try {
            conn = ConnUtils.borrow();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, (pageNum - 1) * pageSize);
            pstmt.setInt(2, pageSize);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                SongSheet sheet = new SongSheet();
                sheet.setId(rs.getInt("id"));
                sheet.setSongSheetName(rs.getString("song_sheet_name"));
                sheet.setSongSheetResume(rs.getString("song_sheet_resume"));
                sheet.setSongSheetAvatar(rs.getString("song_sheet_avatar"));
                sheet.setSongCount(rs.getInt("song_count")); // 封装歌曲数
                songSheets.add(sheet);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("分页查询歌单失败", e);
        } finally {
            // 关闭资源（略）
        }
        return songSheets;
    }
    /**
     * 获取歌单总数
     * @return 总数量
     */
    public int getTotalCount() throws SQLException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int count = 0;
        
        String sql = "SELECT COUNT(*) FROM songsheet";
        
        try {
            conn = ConnUtils.borrow();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("查询歌单总数失败", e);
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) ConnUtils.returnConnection(conn);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        rs.close();
        pstmt.close();
        ConnUtils.returnConnection(conn);
        return count;
    }
    
    /**
     * 获取总页数
     * @param pageSize 每页数量
     * @return 总页数
     */
    public int getTotalPages(int pageSize) throws SQLException {
        int totalCount = getTotalCount();
        // 向上取整计算总页数
        return (totalCount + pageSize - 1) / pageSize;
    }
    
    /**
     * 根据歌单ID查询歌曲数量
     * @param songSheetId 歌单ID
     * @return 歌曲数量
     */
    public int getSongCountBySheetId(Integer songSheetId) throws SQLException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int count = 0;
        
        String sql = "SELECT COUNT(*) FROM songsheetsong WHERE song_sheet_id = ?";
        
        try {
            conn = ConnUtils.borrow();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, songSheetId);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        if (rs != null) {
            rs.close();
        }
        if (pstmt != null) {
            pstmt.close();
        }
        ConnUtils.returnConnection(conn);

        
        return count;
    }

    public static void main(String[] args) throws SQLException {
        SongSheetDAO songSheetDAO = new SongSheetDAO();
        System.out.println(songSheetDAO.getSongCountBySheetId(1));
        System.out.println(songSheetDAO.getTotalCount());
        System.out.println(songSheetDAO.getTotalPages(5));
        System.out.println(songSheetDAO.findSongSheetsByPage(3, 5));
    }

    public List<SongSheet> findAllSongSheets() throws SQLException {
        List<SongSheet> songSheets = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM songsheet";
        conn=ConnUtils.borrow();
        pstmt=conn.prepareStatement(sql);
        rs=pstmt.executeQuery();
        while (rs.next()) {
            SongSheet songSheet = new SongSheet();
            songSheet.setId(rs.getInt("id"));
            songSheet.setSongSheetName(rs.getString("song_sheet_name"));
            songSheet.setSongSheetResume(rs.getString("song_sheet_resume"));
            songSheet.setSongSheetAvatar(rs.getString("song_sheet_avatar"));
            songSheets.add(songSheet);
        }
        rs.close();
        pstmt.close();
        ConnUtils.returnConnection(conn);
        return songSheets;
    }
}