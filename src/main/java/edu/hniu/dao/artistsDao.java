package edu.hniu.dao;

import edu.hniu.model.Singer;
import edu.hniu.utils.ConnUtils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class artistsDao {
    // 查询所有歌手的方法
    public List<Singer> getArtistsInfo() throws SQLException {
        String sql = "select id,singerName,avatar,type,nationality from singer";
        Connection con = ConnUtils.borrow();
        PreparedStatement prep = con.prepareStatement(sql);
        ResultSet result = prep.executeQuery();
        List<Singer> singerlist = new ArrayList<>();
        Singer singer = null;
        while (result.next()) {
            singer = new Singer();
            singer.setId(result.getInt("id"));
            singer.setSingerName(result.getString("singerName"));
            singer.setAvatar(result.getString("avatar"));
            singer.setType(result.getInt("type"));
            singerlist.add(singer);
        }

        result.close();
        prep.close();
        ConnUtils.returnConnection(con);
        return singerlist;
    }

    // 带条件查询的方法
    public List<Singer> getArtistsInfo(String singerName, String nationality, Integer type) throws SQLException {
        StringBuilder sql = new StringBuilder("SELECT id,singerName,avatar,type,nationality FROM singer where 1=1  ");

        if(singerName != null && !singerName.trim().isEmpty()){
            sql.append(" AND singerName LIKE ?");
        }
        if(nationality != null && !nationality.trim().isEmpty()){
            sql.append(" AND nationality = ?");
        }
        if(type != null){
            sql.append(" AND type = ?");
        }

        Connection con = ConnUtils.borrow();
        PreparedStatement prep = con.prepareStatement(sql.toString());
        int index = 1;

        if(singerName != null && !singerName.trim().isEmpty()){
            prep.setString(index, "%" + singerName.trim() + "%");
            index++;
        }
        if(nationality != null && !nationality.trim().isEmpty()){
            prep.setString(index, nationality);
            index++;
        }
        if(type != null){
            prep.setInt(index, type);
        }

        List<Singer> singerlist = new ArrayList<>();
        ResultSet result = prep.executeQuery();
        while (result.next()) {
            Singer singer = new Singer();
            singer.setId(result.getInt("id"));
            singer.setSingerName(result.getString("singerName"));
            singer.setAvatar(result.getString("avatar"));
            singer.setType(result.getInt("type"));
            singer.setNationality(result.getString("nationality"));
            singerlist.add(singer);
        }

        result.close();
        prep.close();
        ConnUtils.returnConnection(con);
        return singerlist;
    }

    // ========== 查询所有不重复的地区 ==========
    public List<String> getAllDistinctNationalities() throws SQLException {
        // 去重查询地区，排除空值，按地区名称排序
        String sql = "SELECT DISTINCT nationality FROM singer WHERE nationality IS NOT NULL AND nationality != '' ORDER BY nationality";
        Connection con = ConnUtils.borrow();
        PreparedStatement prep = con.prepareStatement(sql);
        ResultSet result = prep.executeQuery();

        List<String> nationalities = new ArrayList<>();
        while (result.next()) {
            nationalities.add(result.getString("nationality"));
        }

        // 关闭资源
        result.close();
        prep.close();
        ConnUtils.returnConnection(con);
        return nationalities;
    }

    public static void main(String[] args) throws SQLException {
//        System.out.println("数据库中的歌手：" + new artistsDao().getArtistsInfo());
        try {
            // 测试新增方法
//            System.out.println("数据库中的去重地区：" + new artistsDao().getAllDistinctNationalities());
            System.out.println(new artistsDao().getArtistsInfo());
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}