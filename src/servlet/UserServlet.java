package servlet;

import bean.User;
import dao.BookDao;
import dao.UserDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "UserServlet")
public class UserServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //设置编码类型
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        BookDao bookdao = new BookDao();
        //这里为了简单，设置了tip，用来区分是修改密码功能，还是修改个人资料的功能，tip=1为修改密码
        int tip = Integer.parseInt(request.getParameter("tip"));
        //获取发起请求页面的文件名称，这个在对应的jsp里面的表单填写，修改完成后就可以直接返回对应的页面
        String url = request.getParameter("url");
        HttpSession session = request.getSession();
        User user = new User();
        //获取存到session的aid
        String userId = (String) session.getAttribute("user_id");
        UserDao userDao = new UserDao();
        //通过aid获取到读者的信息
        user = userDao.getUserById(userId);
        //修改密码
        if(tip==1){
            //获取到输入的旧密码，新密码
            String password = request.getParameter("password");
            String password2 = request.getParameter("password2");
            //获取读者数据表中的密码
            String oldPassword = user.getPassword();
            //对旧密码进行比较，如果相同就修改，不相同就直接退出
            if(oldPassword.equals(password)){
                userDao.updateUser(user.getUserId(), user.getAdminName(), user.getUserName(), password2, user.getPhone());
                out.write("<script type='text/javascript'>alert('修改成功，请重新登录');location.href='index.jsp';  </script>");
            }else{
                out.write("<script type='text/javascript'>alert('原密码错误！请重新输入');location.href='"+url+".jsp';</script>");
            }
        }else{
            //修改个人资料
            //获取输入的信息
            String name = request.getParameter("name");
            String phone = request.getParameter("phone");
            //修改输入的信息到数据表中
            userDao.updateUser(user.getUserId(), user.getAdminName(), name, user.getPassword(), phone);
            out.write("<script type='text/javascript'>alert('修改成功');location.href='"+url+".jsp';</script>");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
