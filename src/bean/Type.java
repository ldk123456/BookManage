package bean;

/**
 * 图书分类数据表bean
 */
public class Type {

    private int typeId;//id
    private String typeName;//分类的名称

    public int getTypeId() {
        return typeId;
    }

    public void setTypeId(int typeId) {
        this.typeId = typeId;
    }

    public String getTypeName() {
        return typeName;
    }

    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }
}
