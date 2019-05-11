package servlet;

import bean.Type;
import dao.BookDao;
import dao.TypeDao;
import dao.UserDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

@WebServlet(name = "AnalysisServlet")
public class AnalysisServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        Map<String, Integer> userMap = new HashMap<>();
        UserDao userDao = new UserDao();
        userMap.put("管理员", userDao.findUserByStatus("管理员"));
        userMap.put("普通用户", userDao.findUserByStatus("普通用户"));
        TypeDao typeDao = new TypeDao();
        BookDao bookDao = new BookDao();
        ArrayList<Type> types = typeDao.getTypeInfo();
        Map<String, Integer> bookMap = new HashMap<>();
        for (int i = 0; i < types.size(); i++) {
            String type = types.get(i).getTypeName();
            bookMap.put(type, bookDao.findBookByType(type));
        }
        //将获取的结果存入请求中
        request.setAttribute("user_map", userMap);
        request.setAttribute("types", types);
        request.setAttribute("book_map", bookMap);
        //将请求转发
        request.getRequestDispatcher("analysis.jsp").forward(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
