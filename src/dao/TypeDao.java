package dao;

import bean.Type;
import util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 * 有关图书分类的操作类
 */
public class TypeDao {

    /**
     * 获取所有图书类型的信息，返回数组形式
     * @return
     */
    public ArrayList<Type> getTypeInfo(){
        ArrayList<Type> tagArray = new ArrayList<>();
        Connection conn = DBUtil.getConnectDb();
        String sql = "select * from type";
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            stm = conn.prepareStatement(sql);
            rs = stm.executeQuery();
            while(rs.next()){
                Type tag = new Type();
                tag.setTypeId(rs.getInt("id"));
                tag.setTypeName(rs.getString("type_name"));
                tagArray.add(tag);
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
     * 修改图书分类的信息
     * @param typeId
     * @param typeName
     */
    public void updateType(int typeId, String typeName) {
        // TODO Auto-generated method stub
        Connection conn = DBUtil.getConnectDb();
        String sql = "update type set type_name=? where id=?";
        PreparedStatement stm = null;
        try {
            stm = conn.prepareStatement(sql);
            stm.setString(1, typeName);
            stm.setInt(2, typeId);
            stm.executeUpdate();
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

    /**
     * 添加一个图书分类
     * @param typeName
     */
    public void addType(String typeName) {
        // TODO Auto-generated method stub
        Connection conn = DBUtil.getConnectDb();
        String sql = "insert into type(type_name) values(?)";
        int rs = 0;
        PreparedStatement stm = null;
        try {
            stm = conn.prepareStatement(sql);
            stm.setString(1, typeName);
            rs = stm.executeUpdate();
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

    /**
     * 删除一个图书分类
     * @param typeId
     */
    public void deleteType(int typeId) {
        // TODO Auto-generated method stub
        Connection conn = DBUtil.getConnectDb();
        String sql = "delete from type where id=?";
        PreparedStatement stm = null;
        try {
            stm = conn.prepareStatement(sql);
            stm.setInt(1, typeId);
            stm.executeUpdate();
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }
}

