package edu.hniu.servlet;

import com.fasterxml.jackson.databind.ObjectMapper;
import edu.hniu.dao.SongSheetDAO;
import edu.hniu.model.SongSheet;
import edu.hniu.utils.Page;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/songSheetPage")
public class SongSheetServlet extends HttpServlet {
    // 初始化JSON转换器
    private static final ObjectMapper OBJECT_MAPPER = new ObjectMapper();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1. 处理页码参数
        String pageNumStr = request.getParameter("pageNum");
        int pageNum = 1;
        try {
            if (pageNumStr != null && !pageNumStr.trim().isEmpty()) {
                pageNum = Integer.parseInt(pageNumStr.trim());
            }
        } catch (NumberFormatException e) {
            pageNum = 1;
        }

        // 2. 分页核心配置
        SongSheetDAO songSheetDAO = new SongSheetDAO();
        final int PAGE_SIZE = 5; // 每页显示5个歌单（你可以根据需要调整）
        int totalCount = 0;
        try {
            totalCount = songSheetDAO.getTotalCount();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        int totalPage = 0;
        try {
            totalPage = songSheetDAO.getTotalPages(PAGE_SIZE);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        if (pageNum < 1) pageNum = 1;
        if (pageNum > totalPage) pageNum = totalPage;

        // 3. 关键修改：查询所有歌单数据（一次性加载）
        List<SongSheet> allSongSheets = null; // 新增：查询所有歌单
        try {
            allSongSheets = songSheetDAO.findAllSongSheets();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        if (allSongSheets == null) {
            allSongSheets = new ArrayList<>();
        }

        // 4. 保留原当前页数据查询（兼容原有逻辑）
        List<SongSheet> currentPageData = songSheetDAO.findSongSheetsByPage(pageNum, PAGE_SIZE);
        if (currentPageData == null) {
            currentPageData = new ArrayList<>();
        }

        // 5. 封装分页对象
        Page<SongSheet> page = new Page<>();
        page.setCurrentPage(pageNum);
        page.setPageSize(PAGE_SIZE);
        page.setTotalCount(totalCount);
        page.setTotalPage(totalPage);
        page.setData(currentPageData);

        // 6. 判断是否为AJAX请求（通过参数标识）
        String isAjax = request.getParameter("isAjax");
        if ("true".equals(isAjax)) {
            // AJAX请求：返回JSON数据
            response.setContentType("application/json;charset=UTF-8");
            OBJECT_MAPPER.writeValue(response.getWriter(), page);
        } else {
            // 普通请求：转发到index.jsp，新增传递所有歌单数据
            request.setAttribute("songSheetPage", page);
            request.setAttribute("allSongSheets", allSongSheets); // 新增：所有歌单数据
            request.setAttribute("pageSize", PAGE_SIZE); // 新增：每页数量
            request.getRequestDispatcher("/index.jsp").forward(request, response);
        }
    }
}