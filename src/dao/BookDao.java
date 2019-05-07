package dao;

import bean.Book;
import bean.History;
import util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;

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
     * @param press
     */
    public void addBook(String card, String name, String type, String author, String press) {
        // TODO Auto-generated method stub
        Connection conn = DBUtil.getConnectDb();
        String sql = "insert into book(name,card,author,press,type) values(?,?,?,?,?)";
        int rs = 0;
        PreparedStatement stm = null;
        try {
            stm = conn.prepareStatement(sql);
            stm.setString(1, name);
            stm.setString(2, card);
            stm.setString(3, author);
            stm.setString(4, press);
            stm.setString(5, type);
            rs = stm.executeUpdate();
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

    /**
     * 修改图书的信息，id作为条件，
     */
    public void updateBook(int bookId, String name, String card, String author, String press, String type) {
        // TODO Auto-generated method stub
        Connection conn = DBUtil.getConnectDb();
        String sql = "update book set book_name=?,card=?,author=?,press=?,type=? where id=?";
        PreparedStatement stm = null;
        try {
            stm = conn.prepareStatement(sql);
            stm.setString(1, name);
            stm.setString(2, card);
            stm.setString(3, author);
            stm.setString(4, press);
            stm.setString(5, type);
            stm.setInt(6, bookId);
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
        //System.out.println(uid);

    }

    /**
     * 获取所有的图书信息，返回的是ArrayList数组形式
     * @return
     */
    public ArrayList<Book> getBookInfo(){
        ArrayList<Book> tag_Array = new ArrayList<>();
        Connection conn = DBUtil.getConnectDb();
        String sql = "select * from book";
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
                tag.setPress(rs.getString("press"));
                tag.setType(rs.getString("type"));
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
     * 获取单个图书的信息，根据传入的id来查找，返回一个Book数据类型
     * @param bookId
     * @return
     */
    public Book getBook(int bookId){
        Book tag = new Book();
        Connection conn = DBUtil.getConnectDb();
        String sql = "select * from book where id="+bookId;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            stm = conn.prepareStatement(sql);
            rs = stm.executeQuery();
            while(rs.next()){
                tag.setBookId(rs.getInt("id"));
                tag.setBookName(rs.getString("book_name"));
                tag.setCard(rs.getString("card"));
                tag.setAuthor(rs.getString("author"));
                tag.setPress(rs.getString("press"));
                tag.setType(rs.getString("type"));
            }
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }finally{
            DBUtil.closeDB(rs, stm, conn);
        }
        return tag;
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
                tag.setPress(rs.getString("press"));
                tag.setType(rs.getString("type"));
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
}

