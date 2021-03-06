package servlet;

import dao.BookDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "UpdateBookServlet")
public class UpdateBookServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //修改图书信息
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        String card = request.getParameter("card");
        String type = request.getParameter("type");
        String name = request.getParameter("name");
        String author = request.getParameter("author");
        String time = request.getParameter("time");
        String path = request.getParameter("path");
        int bid = Integer.parseInt(request.getParameter("updatebid"));
        BookDao bookdao = new BookDao();
        bookdao.updateBook(bid,name,card,author,time,type,path);
        String message = "编辑成功";
        request.setAttribute("message",message);
        request.getRequestDispatcher("manage_book.jsp").forward(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
