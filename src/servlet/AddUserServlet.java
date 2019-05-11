package servlet;

import dao.UserDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "AddUserServlet")
public class AddUserServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //设置编码类型
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        //获取要添加的读者的信息
        String adminName = request.getParameter("adminName");
        String password = request.getParameter("password");
        String userName = request.getParameter("userName");
        String phone = request.getParameter("phone");
        UserDao userdao = new UserDao();
        //调用函数添加读者信息
        userdao.addUser(adminName,userName,password,phone);
        String message = "添加成功";
        request.setAttribute("message",message);
        request.getRequestDispatcher("manage_user.jsp").forward(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
