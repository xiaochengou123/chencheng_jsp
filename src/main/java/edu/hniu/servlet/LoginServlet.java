package edu.hniu.servlet;

import com.google.gson.Gson;
import edu.hniu.dao.LoginDao;
import edu.hniu.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //        req.getRequestDispatcher("/index.jsp").forward(req, resp);
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html;charset=UTF-8");
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        boolean login;
        try {
            login = new LoginDao().login(username, password);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        if (login) {
            req.setAttribute("username",username);
            try {
//                System.out.println("User"+new LoginDao().user(username));
                User user = new LoginDao().user(username);
                Gson gson = new Gson();
                String userJson=gson.toJson(user);
                HttpSession session = req.getSession();
                session.setAttribute("User", userJson); // 存JSON字符串，属性名区分开
            
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
            resp.sendRedirect(req.getContextPath() + "/songSheetPage");
            //清除get
            req.getSession().removeAttribute("username");
            req.getSession().removeAttribute("password");
            return;

        } else {

            req.setAttribute("error", "用户名或密码错误");
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
            return;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
       this.doGet(req, resp);
    }
}
