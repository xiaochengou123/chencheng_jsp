package edu.hniu.servlet;

import edu.hniu.dao.Artists_DetailDao;
import edu.hniu.model.ArtistsDetail;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/artists_detail")
public class Artists_DetailServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html;charset=UTF-8");

        String singerIdStr = req.getParameter("singer_id");
        String songName = req.getParameter("song_name");
        Integer singerId = Integer.parseInt(singerIdStr);

        Artists_DetailDao dao = new Artists_DetailDao();
        try {
            // 1. 单独查询歌手基础信息（不受歌曲搜索影响）
            ArtistsDetail singerBaseInfo = dao.getSingerBaseInfo(singerId);
            // 2. 查询歌曲列表（支持模糊搜索）
            List<ArtistsDetail> songList = dao.getArtists_DetailInfo(singerId, songName);

            // 传递数据到页面（分开传递）
            req.setAttribute("SingerBaseInfo", singerBaseInfo); // 歌手基础信息
            req.setAttribute("SongList", songList);             // 歌曲列表
            req.setAttribute("song_name", songName);            // 搜索关键词回显

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        req.getRequestDispatcher("/Artist_Detail.jsp").forward(req, resp);
    }
}