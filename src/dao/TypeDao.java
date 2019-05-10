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
}