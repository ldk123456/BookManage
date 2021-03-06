package servlet;

import dao.UserDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "UpdateUserServlet")
public class UpdateUserServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //修改读者的信息
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        String adminName = request.getParameter("adminName");
        String password = request.getParameter("password");
        String userName = request.getParameter("userName");
        String phone = request.getParameter("phone");
        int aid = Integer.parseInt(request.getParameter("aid"));
        UserDao userdao = new UserDao();
        userdao.updateUser(aid,adminName,userName,password,phone);
        String message = "编辑成功";
        request.setAttribute("message",message);
        request.getRequestDispatcher("manage_user.jsp").forward(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
