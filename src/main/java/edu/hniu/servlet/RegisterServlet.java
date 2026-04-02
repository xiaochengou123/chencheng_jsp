package edu.hniu.servlet;

import edu.hniu.dao.registerDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    this.doPost(req, resp);
    }
    protected  static void setSession(HttpSession req, String email,String username,String nickname,String password,String code){
        //设置utf8
        req.setAttribute("email", email);
        req.setAttribute("username", username);
        req.setAttribute("nickname", nickname);
        req.setAttribute("password", password);
        req.setAttribute("code", code);

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setCharacterEncoding("UTF-8");
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String nickname = req.getParameter("nickname");
        String email = req.getParameter("email");
        String code = req.getParameter("code");
        HttpSession session = req.getSession();
        String sessionCode = (String) session.getAttribute("code");
        String sessionEmail=(String) session.getAttribute("email");

        if(sessionCode==null){
            req.setAttribute("error","验证码过期，请重新在点击!!");
            setSession(session,email,username,nickname,password,code);
            req.getRequestDispatcher("/register.jsp").forward(req, resp);
        }else if(!sessionCode.equals(code)){
            req.setAttribute("error","验证码错误");

            setSession(session,email,username,nickname,password,code);
            req.getRequestDispatcher("/register.jsp").forward(req, resp);

        }else if(!email.equals(sessionEmail)){
            req.setAttribute("error","邮箱错误");
            setSession(session,email,username,nickname,password,code);
            req.getRequestDispatcher("/register.jsp").forward(req, resp);
        }
        else {
            boolean register;
            try {

                register = new registerDao().register(username, password, nickname, email);
                if(register){
                    req.getRequestDispatcher("/login.jsp").forward(req, resp);
                    //清空get
                    req.getSession().invalidate();
                }else{
                    req.setAttribute("error","注册失败,可能用户名存在!!");
                    //设置UTF-8
                    req.setCharacterEncoding("UTF-8");

                    setSession(session,email,username,nickname,password,code);
                    req.getRequestDispatcher("/register.jsp").forward(req, resp);
                }
            } catch (SQLException e) {
                req.setAttribute("error","注册失败,可能用户名存在!!");
                setSession(session,email,username,nickname,password,code);
                req.getRequestDispatcher("/register.jsp").forward(req, resp);
            }
        }
    }
}
