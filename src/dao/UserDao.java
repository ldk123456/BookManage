package dao;

import bean.User;
import util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 * 有关读者账号的连接数据库操作，登录验证，注册，修改账号，修改密码
 */
public class UserDao {

    /**
     * 登录验证功能，传入账号和密码，在数据库中查找，如果找到了，返回true，没找到则返回false
     * @param admin_name
     * @param password
     * @return
     */
    public boolean login(String admin_name, String password){
        Connection conn = DBUtil.getConnectDb();
        String sql = "select * from user where admin_name="+admin_name+" and password="+password;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            stm = conn.prepareStatement(sql);
            rs = stm.executeQuery();
            if(rs.next()){
                return true;
            }
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }finally{
            DBUtil.closeDB(rs, stm, conn);
        }
        return false;
    }

    /**
     * 添加用户的函数，传入账号，密码，姓名，手机号
     * @param adminName
     * @param password
     * @param userName
     * @param phone
     */
    public void addUser(String adminName, String userName, String password, String phone) {
        // TODO Auto-generated method stub
        Connection conn = DBUtil.getConnectDb();
        String sql = "insert into user(status,admin_name,user_name,password,phone) values(?,?,?,?,?,?)";
        int rs = 0;
        PreparedStatement stm = null;
        try {
            stm = conn.prepareStatement(sql);
            stm.setInt(1, 1);
            stm.setString(2, adminName);
            stm.setString(3, userName);
            stm.setString(4, password);
            stm.setString(5, phone);
            rs = stm.executeUpdate();
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

    /**
     * 根据传入的账号，来查找对应的读者信息，返回一个User类型，
     * @param adminName
     * @return
     */
    public User getUserByName(String adminName) {
        // TODO Auto-generated method stub
        User user = new User();
        Connection conn = DBUtil.getConnectDb();
        String sql = "select * from user where admin_name="+adminName;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            stm = conn.prepareStatement(sql);
            rs = stm.executeQuery();
            if(rs.next()){
                user.setUserId(rs.getInt("id"));
                user.setStatus(rs.getInt("status"));
                user.setAdminName(rs.getString("admin_name"));
                user.setUserName(rs.getString("user_name"));
                user.setPassword(rs.getString("password"));
                user.setPhone(rs.getString("phone"));
            }
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }finally{
            DBUtil.closeDB(rs, stm, conn);
        }
        return user;
    }

    /**
     * 获取全部用户的信息，其中sql语句中的status=0，表示只查找读者，不显示管理员的
     * @return
     */
    public ArrayList<User> getUserInfo(){
        ArrayList<User> tagArray = new ArrayList<>();
        Connection conn = DBUtil.getConnectDb();
        String sql = "select * from user where status=0";
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            stm = conn.prepareStatement(sql);
            rs = stm.executeQuery();
            while(rs.next()){
                User user = new User();
                user.setUserId(rs.getInt("id"));
                user.setStatus(rs.getInt("status"));
                user.setAdminName(rs.getString("admin_name"));
                user.setUserName(rs.getString("user_name"));
                user.setPassword(rs.getString("password"));
                user.setPhone(rs.getString("phone"));
                tagArray.add(user);
            }

        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }finally{
            DBUtil.closeDB(rs, stm, conn);
        }
        return tagArray;
    }

    /**
     * 根据传入的id，查找到对应的读者的全部信息，返回一个AdminBean类型的数据
     * @param userId
     * @return
     */
    public User getUserById(int userId){
        User user = new User();
        Connection conn = DBUtil.getConnectDb();
        String sql = "select * from user where id="+userId;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            stm = conn.prepareStatement(sql);
            rs = stm.executeQuery();
            if(rs.next()){
                user.setUserId(rs.getInt("id"));
                user.setStatus(rs.getInt("status"));
                user.setAdminName(rs.getString("admin_name"));
                user.setUserName(rs.getString("user_name"));
                user.setPassword(rs.getString("password"));
                user.setPhone(rs.getString("phone"));
            }
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }finally{
            DBUtil.closeDB(rs, stm, conn);
        }
        return user;
    }

    /**
     * 根据传入的id，查找到对应的读者的全部信息，返回一个User类型的数据，与上一个相似，只是id的类型为String，
     * @param userId
     * @return
     */
    public User getUserById(String userId){
        User user = new User();
        user=getUserById(Integer.parseInt(userId));
        return user;
    }

    /**
     * 修改读者的信息
     * @param userId
     * @param adminName
     * @param userName
     * @param password
     * @param phone
     */
    public void updateUser(int userId, String adminName, String userName, String password, String phone) {
        // TODO Auto-generated method stub
        Connection conn = DBUtil.getConnectDb();
        String sql = "update user set admin_name=?,user_name=?,password=?,phone=? where id=?";
        PreparedStatement stm = null;
        try {
            stm = conn.prepareStatement(sql);
            stm.setString(1, adminName);
            stm.setString(2, userName);
            stm.setString(3, password);
            stm.setString(4, phone);
            stm.setInt(5, userId);
            stm.executeUpdate();
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

    /**
     * 删除用户的信息，根据传入的id作为条件
     * @param userId
     */
    public void deleteUser(int userId) {
        // TODO Auto-generated method stub
        Connection conn = DBUtil.getConnectDb();
        String sql = "delete from user where id=?";
        PreparedStatement stm = null;
        try {
            stm = conn.prepareStatement(sql);
            stm.setInt(1, userId);
            stm.executeUpdate();
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }
}

