package servlet;

import dao.BookDao;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLEncoder;

@WebServlet(name = "DownloadServlet")
public class DownloadServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //下载图书
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        int id = Integer.parseInt(request.getParameter("id"));
        BookDao bookdao = new BookDao();
        //文件路径
        String path = bookdao.findPath(id);
        //得到要下载的文件名
        String fileName = path.substring(path.lastIndexOf("\\")+1);
        System.out.println(fileName);
        response.setHeader("Content-Disposition", "attachment;filename="+ URLEncoder.encode(fileName, "UTF-8"));
        //得到要下载的文件
        File file = new File(path);
        //如果文件不存在
        if(!file.exists()){
            request.setAttribute("message", "下载失败");
            request.getRequestDispatcher("/manage_book.jsp").forward(request, response);
            return;
        }
        //读取要下载的文件，保存到文件输入流
        FileInputStream in = new FileInputStream(path);
        //创建输出流
        OutputStream out = response.getOutputStream();
        //创建缓冲区
        byte buffer[] = new byte[1024];
        int len = 0;
        //循环将输入流中的内容读取到缓冲区当中
        while((len=in.read(buffer))>0){
            //输出缓冲区的内容到浏览器，实现文件下载
            out.write(buffer, 0, len);
        }
        //关闭文件输入流
        in.close();
        //关闭输出流
        out.close();
        String message = "下载成功";
        request.setAttribute("message",message);
        request.getRequestDispatcher("manage_book.jsp").forward(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
