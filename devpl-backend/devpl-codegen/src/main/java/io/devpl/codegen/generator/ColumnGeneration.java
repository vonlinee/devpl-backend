package io.devpl.codegen.generator;

import io.devpl.codegen.type.CommonJavaType;
import io.devpl.codegen.type.JavaType;
import lombok.Data;
import org.apache.ddlutils.jdbc.meta.ColumnMetadata;
import org.apache.ddlutils.jdbc.meta.PrimaryKeyMetadata;

import java.util.List;
import java.util.Map;

/**
 * 表字段信息
 */
@Data
public class ColumnGeneration {

    /**
     * 字段名称
     */
    private final String name;
    /**
     * 该字段属于哪个表
     */
    private final TableGeneration belongTable;
    /**
     * 是否做注解转换，模板参数
     * 添加@TableName注解
     */
    private boolean convert;
    /**
     * 是否主键
     */
    private boolean keyFlag;
    /**
     * 主键是否为自增类型
     */
    private boolean keyIdentityFlag;
    /**
     * Java字段属性名称
     */
    private String propertyName;

    /**
     * 是否为乐观锁字段
     */
    private boolean isVersionField;
    /**
     * 长度
     */
    private int length;
    /**
     * 精度
     */
    private int scale;
    /**
     * 列的元数据信息
     */
    private final ColumnMetadata metadata;
    /**
     * 字段类型
     */
    private JavaType columnType;
    /**
     * 字段注释
     */
    private String comment;
    /**
     * JDBC类型代码
     */
    private int jdbcType;
    /**
     * 填充
     */
    private String fill;
    /**
     * 是否关键字
     *
     * @since 3.3.2
     */
    private boolean keyWords;
    /**
     * 数据库字段（关键字含转义符号）
     *
     * @since 3.3.2
     */
    private String columnName;
    /**
     * 自定义查询字段列表
     */
    private Map<String, Object> customMap;

    /**
     * 构造方法
     *
     * @param metadata 数据库字段元数据
     * @since 3.5.0
     */
    public ColumnGeneration(TableGeneration table, ColumnMetadata metadata) {
        this.metadata = metadata;
        this.name = metadata.getColumnName();
        this.columnName = name;
        this.belongTable = table;
    }

    /**
     * Java字段类型名称
     *
     * @return 该列的Java字段类型名称
     */
    public String getPropertyType() {
        if (null != columnType) {
            return columnType.getName();
        }
        return null;
    }

    public boolean isBooleanType() {
        return "boolean".equalsIgnoreCase(getPropertyType());
    }

    /**
     * 按 JavaBean 规则来生成 get 和 set 方法后面的属性名称
     * 需要处理一下特殊情况：
     * <p>
     * 1、如果只有一位，转换为大写形式
     * 2、如果多于 1 位，只有在第二位是小写的情况下，才会把第一位转为小写
     * <p>
     * 我们并不建议在数据库对应的对象中使用基本类型，因此这里不会考虑基本类型的情况
     */
    public String getCapitalName() {
        if (propertyName.length() == 1) {
            return propertyName.toUpperCase();
        }
        if (Character.isLowerCase(propertyName.charAt(1))) {
            return Character.toUpperCase(propertyName.charAt(0)) + propertyName.substring(1);
        }
        return propertyName;
    }

    /**
     * 获取注解字段名称
     *
     * @return 字段
     */
    public String getAnnotationColumnName() {
        if (keyWords) {
            if (columnName.startsWith("\"")) {
                return String.format("\\\"%s\\\"", name);
            }
        }
        return columnName;
    }

    public void setVersionField(boolean isVersionField) {
        this.isVersionField = isVersionField;
    }

    /**
     * 是否为乐观锁字段
     *
     * @return 是否为乐观锁字段
     * @since 3.5.0
     */
    public boolean isVersionField() {
        return isVersionField;
    }

    private boolean isLogicDeleteField;

    public void setLogicDeleteField(boolean logicDelete) {
        this.isLogicDeleteField = logicDelete;
    }

    /**
     * 是否为逻辑删除字段
     *
     * @return 是否为逻辑删除字段
     * @since 3.5.0
     */
    public boolean isLogicDeleteField() {
        return isLogicDeleteField;
    }

    /**
     * 设置主键
     *
     * @param autoIncrement 自增标识
     * @return this
     * @since 3.5.0
     */
    public ColumnGeneration setPrimaryKeyFlag(boolean autoIncrement) {
        this.keyFlag = true;
        this.keyIdentityFlag = autoIncrement;
        return this;
    }

    public ColumnGeneration setCustomMap(Map<String, Object> customMap) {
        this.customMap = customMap;
        return this;
    }

    /**
     * 设置属性名称
     *
     * @param propertyName 属性名
     * @return this
     * @since 3.5.0
     */
    public ColumnGeneration setPropertyName(String propertyName) {
        this.propertyName = propertyName;
        return this;
    }

    public ColumnGeneration setComment(String comment) {
        this.comment = comment;
        return this;
    }

    public ColumnGeneration setColumnName(String columnName) {
        this.columnName = columnName;
        return this;
    }

    /**
     * 该列是否为主键
     *
     * @return 该列是否为主键
     */
    public boolean isPrimaryKey() {
        List<PrimaryKeyMetadata> primaryKeys = belongTable.getPrimaryKeys();
        for (PrimaryKeyMetadata primaryKey : primaryKeys) {
            if (this.metadata.getColumnName().equals(primaryKey.getColumnName())) {
                return true;
            }
        }
        return false;
    }

    public ColumnMetadata getColumnMetadata() {
        return metadata;
    }

    public ColumnGeneration setType(String type) {
        this.columnType = CommonJavaType.valueOf(type);
        return this;
    }
}
