package edu.hniu.dao;

import edu.hniu.model.Player;
import edu.hniu.utils.ConnUtils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class PlayerDao {

    public List<Player> getPlayerInfo(int... songId) throws SQLException {
        // 初始化StringBuilder，预估初始容量
        StringBuilder sqlBuilder = new StringBuilder(256);

        // 拼接查询字段和关联表
        sqlBuilder.append("SELECT ")
                .append("song.id AS id, ")
                .append("song.songCover AS bg, ")
                .append("song.songFile AS audio, ")
                .append("song.songCover AS record, ")
                .append("song.songName AS name, ")
                .append("singer.singerName AS singer, ")
                .append("song.time AS time ")
                .append("FROM song ")
                .append("INNER JOIN issue ON song.id = issue.song_id ")
                .append("INNER JOIN singer ON issue.singer_id = singer.id ");

        // 仅当传入songId时拼接IN条件（保证只查指定ID）
        if (songId != null && songId.length > 0) {
            sqlBuilder.append("WHERE song.id IN (");
            for (int i = 0; i < songId.length; i++) {
                if (i > 0) {
                    sqlBuilder.append(", ");
                }
                sqlBuilder.append("?");
            }
            sqlBuilder.append(")");
        }
        System.out.println(songId.length);

        Connection conn = null;
        PreparedStatement prep = null;
        ResultSet result = null;
        List<Player> list = new ArrayList<>();

        try {
            conn = ConnUtils.borrow();
            prep = conn.prepareStatement(sqlBuilder.toString());

            // 设置IN条件的参数
            if (songId != null && songId.length > 0) {
                for (int i = 0; i < songId.length; i++) {
                    prep.setInt(i + 1, songId[i]);
                }
            }

            // 执行查询并封装结果
            result = prep.executeQuery();
            while (result.next()) {
                Player player = new Player();
                player.setId(result.getInt("id"));
                player.setAudio(result.getString("audio"));
                player.setRecord(result.getString("record"));
                player.setName(result.getString("name"));
                player.setSinger(result.getString("singer"));
                player.setBg(result.getString("bg"));
                player.setTime(result.getString("time"));
                list.add(player);
            }
        } finally {
            // 关闭资源（避免内存泄漏）
            if (result != null) result.close();
            if (prep != null) prep.close();
            if (conn != null) ConnUtils.returnConnection(conn);
        }
        return list;
    }

    public static void main(String[] args) throws SQLException {
        System.out.println(new PlayerDao().getPlayerInfo(1));
    }
}