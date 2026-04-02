package edu.hniu.filter;


import com.google.gson.Gson;
import edu.hniu.config.PropertiesConfig;
import edu.hniu.model.User;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;


@WebFilter("/*")
public class InterceptorFilter   implements Filter {
    protected  final  Map<String,String> map = new HashMap<>();
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        String[]  split= PropertiesConfig.getProperty("Whitelist").split(",");
        for (String s : split){
            map.put(s,"");
        }
    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) servletRequest;
        HttpServletResponse resp = (HttpServletResponse) servletResponse;
        boolean flag = false;
        //map白名单不拦截直接发行
        for (String uri : map.keySet()){
            if (req.getRequestURI().contains(uri)){
                flag=true;
                break;
            }
        }
        if( flag){//如果路径中访问的是白名单中的路径，则直接发行
            filterChain.doFilter(req,resp);
        }
        else //如果路径中访问的是白名单中的路径，则需要判断session中是否有user对象。
        {

            HttpSession session = req.getSession();
            String userJson = (String) session.getAttribute("User");
            User user = null;
            if (userJson == null) {
                req.setAttribute("error", "请登入后,再访问页面!!");
                req.getRequestDispatcher("/login.jsp").forward(req,resp);
            }else{
                // 使用Gson将JSON字符串转换为User对象
                Gson gson = new Gson();
                user = gson.fromJson(userJson, User.class);
                if (user == null) {
                    //解析失败，跳转到登录页面
                    req.setAttribute("error", "服务器错误!!");
                    req.getRequestDispatcher("/login.jsp").forward(req,resp);
                }else {
                    // 解析成功，放行
                    filterChain.doFilter(req,resp);
                }
            }
        }
    }

    @Override
    public void destroy() {

    }
}
