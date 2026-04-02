package edu.hniu.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

// 定义退出接口的访问路径
@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 1. 获取session并移除用户信息
        HttpSession session = req.getSession();
        session.removeAttribute("User");
        // 2. 可选：销毁整个session（更彻底）
        session.invalidate();
        // 3. 重定向到登录页
        resp.sendRedirect(req.getContextPath() + "/login.jsp");
    }
}