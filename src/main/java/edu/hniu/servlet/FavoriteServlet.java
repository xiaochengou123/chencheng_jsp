package edu.hniu.servlet;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.google.gson.Gson;
import edu.hniu.dao.LikeDao;
import edu.hniu.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/FavoriteServlet")
public class FavoriteServlet extends HttpServlet {
    // 配置ObjectMapper，增加序列化健壮性
    private static final ObjectMapper objectMapper = new ObjectMapper()
            .disable(SerializationFeature.FAIL_ON_EMPTY_BEANS)
            .disable(SerializationFeature.FAIL_ON_UNWRAPPED_TYPE_IDENTIFIERS);
    private final LikeDao likeDao = new LikeDao();
    private final Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");

        Integer userId = null;
        String userIdParam = request.getParameter("userId");

        // 1. 优先从参数获取userId
        if (userIdParam != null && !userIdParam.trim().isEmpty()) {
            try {
                userId = Integer.parseInt(userIdParam.trim());
            } catch (NumberFormatException e) {
                handleError(response, "用户ID格式错误（必须是数字）", isAjax(request));
                return;
            }
        }

        // 2. 参数无userId则从Session获取
        if (userId == null) {
            HttpSession session = request.getSession(false);
            if (session != null) {
                String userJson = (String) session.getAttribute("User");
                if (userJson != null && !userJson.isEmpty()) {
                    try {
                        User sessionUser = gson.fromJson(userJson, User.class);
                        userId = sessionUser.getId();
                    } catch (Exception e) {
//                        System.out.println("解析Session用户信息失败：" + e.getMessage());
                    }
                }
            }
        }

        // 3. 仍无userId则返回错误
        if (userId == null) {
            handleError(response, "未获取到有效用户ID，请先登录", isAjax(request));
            return;
        }

        // 4. 获取请求类型（1=歌曲，2=歌单）
        int type = 1;
        String typeStr = request.getParameter("type");
        if (typeStr != null && !typeStr.trim().isEmpty()) {
            try {
                type = Integer.parseInt(typeStr.trim());
            } catch (NumberFormatException e) {
                handleError(response, "类型参数错误（必须是1或2）", isAjax(request));
                return;
            }
        }

        // 5. 处理请求
        try (PrintWriter writer = response.getWriter()) {
            List<Object> dataList = likeDao.getAllLikedInfo(userId, type);

            if (isAjax(request)) {
                // AJAX请求：返回JSON数据
                objectMapper.writeValue(writer, dataList);
                writer.flush();
            } else {
                // 普通请求：转发到JSP
                int songCount = likeDao.getLikedSongIds(userId).size();
                int sheetCount = likeDao.getLikedSongSheetIds(userId).size();

                request.setAttribute("currentType", type);
                request.setAttribute("songCount", songCount);
                request.setAttribute("sheetCount", sheetCount);
                request.setAttribute("list", dataList);
                request.getRequestDispatcher("/favorite.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            handleError(response, "数据库查询失败：" + e.getMessage(), isAjax(request));
        } catch (Exception e) {
            handleError(response, "服务器内部错误：" + e.getMessage(), isAjax(request));
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    // 辅助方法：判断是否为AJAX请求
    private boolean isAjax(HttpServletRequest request) {
        return "true".equals(request.getParameter("ajax"));
    }

    // 统一错误处理
    private void handleError(HttpServletResponse response, String message, boolean isAjax) throws IOException {
        response.resetBuffer();
        if (isAjax) {
            response.setContentType("application/json;charset=UTF-8");
            Map<String, String> error = new HashMap<>();
            error.put("error", message);
            try (PrintWriter writer = response.getWriter()) {
                objectMapper.writeValue(writer, error);
                writer.flush();
            }
        } else {
            response.setContentType("text/html;charset=UTF-8");
            try (PrintWriter writer = response.getWriter()) {
                writer.write("<h1>错误：</h1><p>" + message + "</p><a href='login.jsp'>返回登录</a>");
                writer.flush();
            }
        }
    }
}