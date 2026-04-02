package edu.hniu.dao;

import edu.hniu.model.User;
import edu.hniu.utils.ConnUtils;
import edu.hniu.utils.Md5Util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class LoginDao {
    /**
     * 登录功能
     * @param username 用户名
     * @param password 密码
     * @return true：登录成功  false：登录失败
     * @throws SQLException 抛出数据库异常
     */

    public boolean login(String username, String password) throws SQLException {
        Connection con= ConnUtils.borrow();
        //加密
        String sql="select * from user where username=?";
        PreparedStatement prep = con.prepareStatement(sql);
        prep.setString(1,username);
        ResultSet resultSet = prep.executeQuery();
        boolean flag=false;
        if(resultSet.next()){
            String key=resultSet.getString("Key");
            int Position=Integer.parseInt(resultSet.getString("Position"));
            String MDPassword;

            MDPassword=password.substring(0,Position)+key+password.substring(Position);
            MDPassword=Md5Util.getMD5String(MDPassword);
//            System.out.println("MDPassword"+MDPassword);
            if(MDPassword.equals(resultSet.getString("password"))){
                flag=true;
            }
        }
        resultSet.close();
        prep.close();
        ConnUtils.returnConnection(con);
        return  flag;
    }
    /**
     * 查询用户信息
     * @param username 用户名
     * @return 用户信息
     */
    public User  user(String username) throws SQLException {
        Connection con= ConnUtils.borrow();
        String sql="select * from user where username=?";
        PreparedStatement prep = con.prepareStatement(sql);
        prep.setString(1,username);
        ResultSet resultSet = prep.executeQuery();
        User user=null;
        if(resultSet.next()){
            user=new User(resultSet.getInt("id"),resultSet.getString("username"),resultSet.getString("password"),resultSet.getString("nickname"),resultSet.getString("email"),resultSet.getString("avatar"),resultSet.getString("resume"),resultSet.getTimestamp("createtime").toLocalDateTime(),resultSet.getTimestamp("updatetime").toLocalDateTime());
        }
        resultSet.close();
        prep.close();
        ConnUtils.returnConnection(con);
        return user;
    }

    public static void main(String[] args) {
        try {
            User user = new LoginDao().user("WWW");
            System.out.println(user);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
