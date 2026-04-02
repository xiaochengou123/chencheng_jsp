package edu.hniu.servlet;



import edu.hniu.utils.EmailUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.security.GeneralSecurityException;
import java.util.concurrent.CompletableFuture;


@WebServlet("/EmailServlet")
public class EmailServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        // 1. 获取session（建议提前获取，避免异步线程操作）
        HttpSession session = req.getSession();

        // 2. 执行异步任务并发送完成
        CompletableFuture.runAsync(() -> {
            try {
               String code = EmailUtils.sendVerificationCode(email);

                // 更安全的做法：用 synchronized 或避免依赖 session 存验证码（见下方建议）
                synchronized (session) {
                    session.setAttribute("code", code);
                    session.setAttribute("email", email);
                }
            } catch (Exception e) {
                e.printStackTrace();
                // 可记录日志、发送失败通知等
            }
        });

        // 立即响应！不等邮件发送完成
        req.setAttribute("message", "验证码已发送，请查收邮箱（可能在垃圾箱）");
        req.getRequestDispatcher("/register.jsp").forward(req, resp);

    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doPost(req, resp);
    }


}
