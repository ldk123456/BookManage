package dao;

import bean.Book;
import util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 * 关于图书连接数据库的所有操作的类
 */
public class BookDao {

    /**
     * 添加图书信息，传入所有的信息
     * @param card
     * @param name
     * @param type
     * @param author
     * @param time
     * @param path
     */
    public void addBook(String card, String name, String type, String author, String time, String path) {
        // TODO Auto-generated method stub
        Connection conn = DBUtil.getConnectDb();
        String sql = "insert into book(book_name,card,author,time,type,path) values(?,?,?,?,?,?)";
        int rs = 0;
        PreparedStatement stm = null;
        try {
            stm = conn.prepareStatement(sql);
            stm.setString(1, name);
            stm.setString(2, card);
            stm.setString(3, author);
            stm.setString(4, time);
            stm.setString(5, type);
            stm.setString(6, path);
            rs = stm.executeUpdate();
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

    /**
     * 修改图书的信息，id作为条件
     * @param bookId
     * @param name
     * @param card
     * @param author
     * @param time
     * @param type
     * @param path
     */
    public void updateBook(int bookId, String name, String card, String author, String time, String type, String path) {
        // TODO Auto-generated method stub
        Connection conn = DBUtil.getConnectDb();
        String sql = "update book set book_name=?,card=?,author=?,press=?,type=?,path=? where id=?";
        PreparedStatement stm = null;
        try {
            stm = conn.prepareStatement(sql);
            stm.setString(1, name);
            stm.setString(2, card);
            stm.setString(3, author);
            stm.setString(4, time);
            stm.setString(5, type);
            stm.setString(6, time);
            stm.setInt(7, bookId);
            stm.executeUpdate();
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

    /**
     * 删除图书信息，根据传入的id作为条件
     * @param bookId
     */
    public void deleteBook(int bookId) {
        // TODO Auto-generated method stub
        Connection conn = DBUtil.getConnectDb();
        String sql = "delete from book where id=?";
        PreparedStatement stm = null;
        try {
            stm = conn.prepareStatement(sql);
            stm.setInt(1, bookId);
            stm.executeUpdate();
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

    /**
     * 用户查找图书，根据输入的名称，使用like进行模糊查询，然后返回一个ArrayList数组类型
     * @param name
     * @return
     */
    public ArrayList<Book> getLikeList(String name) {
        // TODO Auto-generated method stub
        ArrayList<Book> tag_Array = new ArrayList<>();
        Connection conn = DBUtil.getConnectDb();
        String sql = "select * from book where book_name like '%"+name+"%'";
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            stm = conn.prepareStatement(sql);
            rs = stm.executeQuery();
            while(rs.next()){
                Book tag = new Book();
                tag.setBookId(rs.getInt("id"));
                tag.setBookName(rs.getString("book_name"));
                tag.setCard(rs.getString("card"));
                tag.setAuthor(rs.getString("author"));
                tag.setTime(rs.getString("time"));
                tag.setType(rs.getString("type"));
                tag.setPath(rs.getString("path"));
                tag_Array.add(tag);
            }
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }finally{
            DBUtil.closeDB(rs, stm, conn);
        }
        return tag_Array;
    }

    /**
     * 通过id找到文件路径
     * @param id
     * @return
     */
    public String findPath(int id) {
        String path = "";
        Connection conn = DBUtil.getConnectDb();
        String sql = "select path from book where id="+id;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            stm = conn.prepareStatement(sql);
            rs = stm.executeQuery();
            while(rs.next()){
                path = rs.getString("path");
            }
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }finally{
            DBUtil.closeDB(rs, stm, conn);
        }
        return path;
    }

    /**
     * 统计不同分类的图书数量
     * @param type
     * @return
     */
    public int findBookByType(String type) {
        int num = 0;
        Connection conn = DBUtil.getConnectDb();
        String sql = "select count(type=? or null) as num from book";
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            stm = conn.prepareStatement(sql);
            stm.setString(1, type);
            rs = stm.executeQuery();
            while(rs.next()){
                num = rs.getInt("num");
            }
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }finally{
            DBUtil.closeDB(rs, stm, conn);
        }
        return num;
    }
}

