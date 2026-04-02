package edu.hniu.servlet;

import edu.hniu.dao.artistsDao;
import edu.hniu.model.Singer;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

// 映射路径，前端请求这个地址
@WebServlet("/artists")
public class ArtistsServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1. 设置请求编码，避免中文乱码
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        // 2. 获取前端参数
        String singerName = request.getParameter("singerName"); // 搜索关键词
        String region = request.getParameter("region"); // 地区（all/china/europe/japan/korea）
        String gender = request.getParameter("gender"); // 类型（all/male/female/group）
        // 3. 参数处理：映射前端值到数据库字段值
        String nationality = null;
        Integer type = null;
        if (region != null && !"all".equals(region)) {
            nationality = region;
        }

        // 类型映射（前端male → 数据库1，female→2，group→3）
        if (gender != null && !"all".equals(gender)) {
            switch (gender) {
                case "male":
                    type = 1;
                    break;
                case "female":
                    type = 2;
                    break;
                case "group":
                    type = 3;
                    break;
            }
        }

        // 4. 处理搜索关键词（为空则传null）
        if (singerName != null && singerName.trim().isEmpty()) {
            singerName = null;
        }

        // 5. 调用DAO查询
        artistsDao dao = new artistsDao();
        List<Singer> singerList = null;
        List<String> nationalities = null;
        try {
            nationalities = dao.getAllDistinctNationalities();
            if (singerName == null && nationality == null && type == null) {
                // 无筛选条件，查询所有
                singerList = dao.getArtistsInfo();
            } else {
                // 有筛选条件，带参数查询
                singerList = dao.getArtistsInfo(singerName, nationality, type);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new ServletException("查询歌手数据失败");
        }
        // 6. 把结果放到request域，转发回artists.jsp
        request.setAttribute("SingerList", singerList);
        request.setAttribute("singerName", singerName == null ? "" : singerName);
        request.setAttribute("region", region == null ? "all" : region);
        request.setAttribute("gender", gender == null ? "all" : gender);
        request.setAttribute("nationalities", nationalities);
        request.getRequestDispatcher("/artists.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
     this.doGet(request, response);
    }
}