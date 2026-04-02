package edu.hniu.dao;

import edu.hniu.utils.ConnUtils;
import edu.hniu.utils.Md5Util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class registerDao {
//    注册功能
    public boolean register(String username, String password, String nickname, String email) throws SQLException {
        Connection conn= ConnUtils.borrow();

        String sql="insert into user(username,password,nickname,email,avatar,resume,`Key`,`Position`) values(?,?,?,?,?,?,?,?)";
         PreparedStatement prep = null;
         boolean flag=false;
        try {
            char Key=( char) (Math.random()*26+'a');
            int Position=(int)(Math.random()*password.length()-1);
            String MDPassword;
            MDPassword=password.substring(0,Position)+Key+password.substring(Position);

            prep= conn.prepareStatement(sql);
            prep.setString(1,username);
            prep.setString(2, Md5Util.getMD5String(MDPassword));
            prep.setString(3,nickname);
            prep.setString(4,email);
            prep.setString(5,"https://movie-db-ai.oss-cn-beijing.aliyuncs.com/image/2026/01/1370f50a-5ee9-43c6-8092-3c44ca549bd6.png");
            prep.setString(6,"这个人很懒");
            prep.setString(7,Key+"");
            prep.setString(8,Position+"");
            flag=prep.executeUpdate()>0;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        prep.close();
        ConnUtils.returnConnection(conn);
        return flag;
    }

    public static void main(String[] args) {
        try {
            boolean flag = new registerDao().register("OOO","1423456","WWW","205614780@qq.com");
            System.out.println(flag);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
