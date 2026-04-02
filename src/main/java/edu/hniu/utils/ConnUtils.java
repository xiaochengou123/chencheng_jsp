package edu.hniu.utils;

/**
 *  数据库借中
 */

import edu.hniu.config.PropertiesConfig;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public  class ConnUtils {
    static List<Connection> pool=null;
    //初始化数据库连接池
    public static void    init() throws Exception {
        //加载数据库驱动
        Class.forName(PropertiesConfig.getProperty("driverClassName"));

        Long startTime=System.currentTimeMillis();
        //创建连接池
        pool=new ArrayList<>();
        for (int i = 0; i <5; i++) {
            Connection conn= DriverManager.getConnection(
                    PropertiesConfig.getProperty("url"), PropertiesConfig.getProperty("username"),
                    PropertiesConfig.getProperty("password")
            );
            pool.add(conn);
        }
        Long endTime=System.currentTimeMillis();
//        System.out.println("初始化数据库连接池耗时："+(endTime-startTime)+"毫秒");
    }
    //借
    public static Connection  borrow(){
        if(pool==null) {
            try {
                init();
            } catch (Exception e) {
                throw new RuntimeException(e);

            }
        }
        return pool.remove(0);
    }
    //还
    public static  void returnConnection(Connection connection){
        pool.add(connection);
    }

    public static void main(String[] args) throws SQLException {
        //连接
        Connection conn= ConnUtils.borrow();
        PreparedStatement  prep= conn.prepareStatement("select  * from  user");
        ResultSet resultSet = prep.executeQuery();
        System.out.println(resultSet);
        resultSet.close();
        prep.close();
        ConnUtils.returnConnection(conn);
    }

    public static void close(ResultSet rs, PreparedStatement ps, Connection conn) {
    }

    public static Connection getConnection() {
        return null;
    }
}
