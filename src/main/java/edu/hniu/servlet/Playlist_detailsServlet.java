package edu.hniu.servlet;

import edu.hniu.dao.Playlist_detailsDao;
import edu.hniu.model.ArtistsDetail;
import edu.hniu.model.SongSheet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/playlist")
public class Playlist_detailsServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String  sheet_id = req.getParameter("sheet_id");
         Playlist_detailsDao playlist_detailsDao = new Playlist_detailsDao();
        SongSheet songSheet=null;
        List<ArtistsDetail>  artistsDetailInfo = null;
        try {
          songSheet = playlist_detailsDao.getSongSheet(Integer.parseInt(sheet_id));
          artistsDetailInfo = playlist_detailsDao.getArtists_DetailInfo(Integer.parseInt(sheet_id));
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        resp.setCharacterEncoding( "UTF-8");

         req.setAttribute("songSheet",songSheet);
         req.setAttribute("Info",artistsDetailInfo);
        req .getRequestDispatcher("/PlaylistDetails.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doGet(req, resp);
    }
}
