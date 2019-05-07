package servlet;


import bean.User;
import dao.UserDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "LoginServlet")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //登录的判断
        PrintWriter out = response.getWriter();
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        //获取账号和密码
        String userName = request.getParameter("username");
        String password = request.getParameter("password");
        UserDao userdao = new UserDao();
        //对账号和密码进行判断
        boolean result = userdao.login(userName, password);
        HttpSession session = request.getSession();
        //判断输入正确
        if(result){
            User user = null;
            UserDao userDao = new UserDao();
            //根据账号查找出读者的信息
            user = userDao.getUserByName(userName);
            //将id存入session中
            session.setAttribute("user_id", ""+user.getUserId());
            //设置session的失效时间
            session.setMaxInactiveInterval(6000);
            //根据status的值来判断是管理员，还是读者，status=0为读者
            if(user.getStatus().equals("管理员")){
                response.sendRedirect("/BookManage/manager.jsp");
            }else{
                response.sendRedirect("/BookManage/admin.jsp");
            }
        }else{
            //没有找到对应的账号和密码，返回重新登录
            session.setAttribute("state", "密码错误");
            response.sendRedirect("/BookManage/index.jsp");
        }
    }
}
