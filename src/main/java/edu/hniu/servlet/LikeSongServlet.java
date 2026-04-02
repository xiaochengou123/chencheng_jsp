package edu.hniu.servlet;

import edu.hniu.dao.LikeDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/likeSong")
public class LikeSongServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 设置编码
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/plain;charset=UTF-8");

        // 1. 获取参数（统一用targetId，兼容歌曲/歌单ID）
        String userIdStr = req.getParameter("userId");
        String targetIdStr = req.getParameter("targetId"); // 可能为空（查询操作）
        String action = req.getParameter("action");

        // 2. 基础校验
        if (userIdStr == null || userIdStr.trim().isEmpty()) {
            resp.getWriter().write("用户ID不能为空");
            return;
        }
        if (action == null || action.trim().isEmpty()) {
            resp.getWriter().write("操作类型不能为空");
            return;
        }

        // 3. 转换用户ID为数字
        Integer userId = null;
        try {
            userId = Integer.parseInt(userIdStr.trim());
        } catch (NumberFormatException e) {
            resp.getWriter().write("用户ID必须是数字！当前值：" + userIdStr);
            return;
        }

        // 4. 操作数据库
        LikeDao dao = new LikeDao();
        try {
            // ========== 歌曲相关操作 ==========
            if ("querySong".equals(action)) {
                // 查询操作：不需要targetId，直接查用户所有已收藏歌曲
                List<Integer> likedIds = dao.getLikedSongIds(userId);
                StringBuilder sb = new StringBuilder();
                for (int id : likedIds) {
                    sb.append(id).append(",");
                }
                String result = sb.length() > 0 ? sb.substring(0, sb.length() - 1) : "";
//                System.out.println("用户" + userId + "已收藏歌曲ID：" + result); // 后端调试日志
                resp.getWriter().write(result);
            } else if ("addSong".equals(action)) {
                // 增删操作：必须校验targetId
                if (targetIdStr == null || targetIdStr.trim().isEmpty()) {
                    resp.getWriter().write("歌曲ID不能为空");
                    return;
                }
                Integer songId = Integer.parseInt(targetIdStr.trim());
                boolean success = dao.addMyLike(userId, songId);
                resp.getWriter().write(success ? "点赞成功" : "已点赞过该歌曲");
            } else if ("deleteSong".equals(action)) {
                if (targetIdStr == null || targetIdStr.trim().isEmpty()) {
                    resp.getWriter().write("歌曲ID不能为空");
                    return;
                }
                Integer songId = Integer.parseInt(targetIdStr.trim());
                boolean success = dao.deleteMyLike(userId, songId);
                resp.getWriter().write(success ? "取消点赞成功" : "未找到点赞记录");
            }
            // ========== 歌单相关操作 ==========
            else if ("querySheet".equals(action)) {
                // 查询操作：不需要targetId，直接查用户所有已收藏歌单
                List<Integer> likedSheetIds = dao.getLikedSongSheetIds(userId);
                StringBuilder sb = new StringBuilder();
                for (int id : likedSheetIds) {
                    sb.append(id).append(",");
                }
                String result = sb.length() > 0 ? sb.substring(0, sb.length() - 1) : "";
//                System.out.println("用户" + userId + "已收藏歌单ID：" + result); // 后端调试日志
                resp.getWriter().write(result);
            } else if ("addSheet".equals(action)) {
                if (targetIdStr == null || targetIdStr.trim().isEmpty()) {
                    resp.getWriter().write("歌单ID不能为空");
                    return;
                }
                Integer sheetId = Integer.parseInt(targetIdStr.trim());
                boolean success = dao.addSheetLike(userId, sheetId);
                resp.getWriter().write(success ? "收藏歌单成功" : "已收藏过该歌单");
            } else if ("deleteSheet".equals(action)) {
                if (targetIdStr == null || targetIdStr.trim().isEmpty()) {
                    resp.getWriter().write("歌单ID不能为空");
                    return;
                }
                Integer sheetId = Integer.parseInt(targetIdStr.trim());
                boolean success = dao.deleteSheetLike(userId, sheetId);
                resp.getWriter().write(success ? "取消收藏歌单成功" : "未找到收藏记录");
            } else {
                resp.getWriter().write("不支持的操作类型！仅支持querySong/querySheet/addSong/addSheet/deleteSong/deleteSheet");
            }
        } catch (NumberFormatException e) {
            resp.getWriter().write("目标ID必须是数字！当前值：" + targetIdStr);
        } catch (SQLException e) {
            e.printStackTrace();
            resp.getWriter().write("数据库操作失败：" + e.getMessage());
        }
    }

    // 允许GET请求（方便测试）
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doPost(req, resp);
    }
}