package servlet;

import dao.BookDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "AddBookServlet")
public class AddBookServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //设置编码类型
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        //获取要添加图书的信息
        String card = request.getParameter("card");
        String name = request.getParameter("name");
        String type = request.getParameter("type");
        String author = request.getParameter("author");
        String press = request.getParameter("press");
        BookDao bookdao = new BookDao();
        //调用函数，存入图书
        bookdao.addBook(card,name,type,author,press);
        response.sendRedirect("/BookManage/manage_book.jsp");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
