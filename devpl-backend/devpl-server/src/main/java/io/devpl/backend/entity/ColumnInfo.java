package io.devpl.backend.entity;

import lombok.Data;

/**
 * 列信息
 */
@Data
public class ColumnInfo {

    /**
     * TABLE_CAT String => table catalog (maybe null)
     */
    private String tableCatalog;

    /**
     * TABLE_SCHEM String => table schema (maybe null)
     */
    private String tableSchema;

    /**
     * TABLE_NAME String => table name
     */
    private String tableName;

    /**
     * COLUMN_NAME String => column name
     */
    private String columnName;

    /**
     * DATA_TYPE int => SQL type from java.sql.Type
     */
    private Integer dataType;

    /**
     * TYPE_NAME String => Data source dependent type name, for a UDT the type name is fully qualified
     */
    private String typeName;

    /**
     * 有符号数长度会减少1，比如bigint(20)，此时columnSize=19
     * COLUMN_SIZE int => column size.
     *
     * @see java.sql.DatabaseMetaData#getColumns(String, String, String, String)
     */
    private Integer columnSize;

    /**
     * BUFFER_LENGTH is not used.
     */
    private Integer bufferLength;

    /**
     * DECIMAL_DIGITS int => the number of fractional digits(小数位数). Null is returned for data
     * types where DECIMAL_DIGITS is not applicable, such as the {@code java.sql.Typse#INT}.
     */
    private Integer decimalDigits;

    /**
     * Numeric Precision Radix.
     * radix means binary, decimal, hexidecimal, etc.
     * Numeric Precision means how many digits are in the representation of the number
     * Scale: how many digits are after the radix point
     * <p>
     * NUM_PREC_RADIX int => Radix (typically either 10 or 2) (基数,即十进制或者二进制)
     * <p>
     * <a href="https://stackoverflow.com/questions/28835640/what-does-numeric-precision-radix-mean-in-the-sql-server-metadata">what-does-numeric-precision-radix-mean-in-the-sql-server-metadata</a>
     */
    private Integer numericPrecisionRadix;

    /**
     * NULLABLE int => is NULL allowed.
     * 0 - Indicates that the column definitely allows NULL values.
     * 1 - Indicates that the column definitely allows NULL values.
     * 2 - Indicates that the nullability of columns is unknown.
     * <p>
     * <p>
     * -- SETTER --
     * JDBC使用 setter/getter 方法来确定字段
     *
     * @see java.sql.DatabaseMetaData#columnNoNulls
     * @see java.sql.DatabaseMetaData#columnNullable
     * @see java.sql.DatabaseMetaData#columnNullableUnknown
     */
    private Integer nullable;

    /**
     * 字段注释信息
     * REMARKS String => comment describing column (may be null)
     */
    private String remarks;

    /**
     * COLUMN_DEF String => default value for the column, which
     * should be interpreted as a string when the value is enclosed in single quotes (maybe null)
     */
    private String columnDef;

    /**
     * SQL_DATA_TYPE int => unused
     */
    private Integer sqlDataType;

    /**
     * SQL_DATETIME_SUB int => unused
     */
    private Integer sqlDatetimeSub;

    /**
     * 字符类型的最大字节数
     * CHAR_OCTET_LENGTH int => for char types the maximum number of bytes in the column
     */
    private Integer charOctetLength;

    /**
     * 在表中的位置
     * ORDINAL_POSITION int => index of column in table (starting at 1)
     */
    private Integer ordinalPosition;

    /**
     * IS_NULLABLE String => ISO rules are used to determine the nullability for a column.
     * YES --- if the column can include NULLs
     * NO --- if the column cannot include NULLs
     * empty string --- if the nullability for the column is unknown
     *
     * @see <a href="https://stackoverflow.com/questions/26490427/jdbc-getcolumns-differences-between-is-nullable-and-nullable">JDBC getColumns differences between "IS_NULLABLE" and "NULLABLE"</a>
     */
    private String nullableDescription;

    /**
     * SCOPE_CATALOG String => catalog of table that is the scope
     * of a reference attribute (null if DATA_TYPE isn't REF)
     */
    private String scopeCatalog;

    /**
     * SCOPE_SCHEMA String => schema of table that is the scope of a
     * reference attribute (null if the DATA_TYPE isn't REF)
     */
    private String scopeSchema;

    /**
     * SCOPE_TABLE String => table name that this the scope of a reference
     * attribute (null if the DATA_TYPE isn't REF)
     */
    private String scopeTable;

    /**
     * SOURCE_DATA_TYPE short => source type of distinct type or user-generated Ref type,
     * SQL type from java.sql.Types (null if DATA_TYPE isn't DISTINCT or user-generated REF)
     */
    private Short sourceDataType;

    /**
     * IS_AUTOINCREMENT String => Indicates whether this column is auto incremented
     * YES --- if the column is auto incremented
     * NO --- if the column is not auto incremented
     * empty string --- if it cannot be determined whether the column is auto incremented
     */
    private String autoIncrement;

    /**
     * IS_GENERATEDCOLUMN String => Indicates whether this is a generated column
     * YES --- if this a generated column
     * NO --- if this not a generated column
     * empty string --- if it cannot be determined whether this is a generated column
     */
    private String generatedColumn;

    // =========================================== 非JDBC获取的元数据信息 ===============================

    /**
     * 此字段并不是jdbc元数据中可获取的值
     * 数据类型，平台独立的数据类型，比如MySQL bigint(19) unsigned
     */
    private String dataTypeDescriptor;

    /**
     * 不同数据库平台的数据类型名称
     * 比如mysql里的varchar, oracle的varchar2等等
     * 此字段并不是jdbc元数据中可获取的值
     *
     * @see java.sql.DatabaseMetaData#getColumns(String, String, String, String)
     */
    private String platformDataType;

    /**
     * 编码名称，一般字符类型才有值
     */
    private String charsetName;

    /**
     * 排序规则名称
     */
    private String collationName;

    /**
     * 列的索引类型
     */
    private String columnKey;

    /**
     * 是否是主键
     */
    private Boolean primaryKey;

    public boolean isPrimaryKey() {
        return Boolean.TRUE.equals(primaryKey);
    }
}
