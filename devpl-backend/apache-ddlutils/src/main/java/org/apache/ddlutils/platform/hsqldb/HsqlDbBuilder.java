package org.apache.ddlutils.platform.hsqldb;

import org.apache.ddlutils.Platform;
import org.apache.ddlutils.alteration.ColumnDefinitionChange;
import org.apache.ddlutils.model.Column;
import org.apache.ddlutils.model.ModelException;
import org.apache.ddlutils.model.Table;
import org.apache.ddlutils.model.TypeMap;
import org.apache.ddlutils.platform.SqlBuilder;

import java.io.IOException;

/**
 * The SQL Builder for the HsqlDb database.
 */
public class HsqlDbBuilder extends SqlBuilder {
    /**
     * Creates a new builder instance.
     *
     * @param platform The platform this builder belongs to
     */
    public HsqlDbBuilder(Platform platform) {
        super(platform);
        addEscapedCharSequence("'", "''");
    }

    @Override
    public void dropTable(Table table) throws IOException {
        print("DROP TABLE ");
        printIdentifier(getTableName(table));
        print(" IF EXISTS");
        printEndOfStatement();
    }

    @Override
    public String getSelectLastIdentityValues(Table table) {
        return "CALL IDENTITY()";
    }

    /**
     * Writes the SQL to add/insert a column.
     *
     * @param table      The table
     * @param newColumn  The new column
     * @param nextColumn The column before which the new column shall be added; <code>null</code>
     *                   if the new column is to be added instead of inserted
     */
    public void insertColumn(Table table, Column newColumn, Column nextColumn) throws IOException {
        print("ALTER TABLE ");
        printlnIdentifier(getTableName(table));
        printIndent();
        print("ADD COLUMN ");
        writeColumn(table, newColumn);
        if (nextColumn != null) {
            print(" BEFORE ");
            printIdentifier(getColumnName(nextColumn));
        }
        printEndOfStatement();
    }

    /**
     * Writes the SQL to drop a column.
     *
     * @param table  The table
     * @param column The column to drop
     */
    public void dropColumn(Table table, Column column) throws IOException {
        print("ALTER TABLE ");
        printlnIdentifier(getTableName(table));
        printIndent();
        print("DROP COLUMN ");
        printIdentifier(getColumnName(column));
        printEndOfStatement();
    }

    @Override
    protected void writeColumn(Table table, Column column) throws IOException {
        //see comments in columnsDiffer about null/"" defaults
        printIdentifier(getColumnName(column));
        print(" ");
        print(getSqlType(column));
        if (column.isAutoIncrement()) {
            if (!column.isPrimaryKey()) {
                throw new ModelException("Column " + column.getName() + " in table " + table.getName() + " is auto-incrementing but not a primary key column, which is not supported by the platform");
            }
            print(" ");
            writeColumnAutoIncrementStmt(table, column);
        } else {
            writeColumnDefaultValueStmt(table, column);
        }
        if (column.isRequired()) {
            print(" ");
            writeColumnNotNullableStmt();
        } else if (getPlatformInfo().isNullAsDefaultValueRequired() && getPlatformInfo().hasNullDefault(column.getTypeCode())) {
            print(" ");
            writeColumnNullableStmt();
        }
    }

    @Override
    protected void writeColumnAutoIncrementStmt(Table table, Column column) throws IOException {
        print("GENERATED BY DEFAULT AS IDENTITY(START WITH 1)");
    }

    @Override
    protected void writeCastExpression(Column sourceColumn, Column targetColumn) throws IOException {
        boolean sizeChanged = ColumnDefinitionChange.isSizeChanged(getPlatformInfo(), sourceColumn, targetColumn);
        boolean typeChanged = ColumnDefinitionChange.isTypeChanged(getPlatformInfo(), sourceColumn, targetColumn);

        if (sizeChanged || typeChanged) {
            boolean needSubstr = TypeMap.isTextType(targetColumn.getTypeCode()) && sizeChanged && (sourceColumn.getSizeAsInt() > targetColumn.getSizeAsInt());

            if (needSubstr) {
                print("SUBSTR(");
            }
            print("CAST(");
            printIdentifier(getColumnName(sourceColumn));
            print(" AS ");
            if (needSubstr) {
                print(getNativeType(targetColumn));
            } else {
                print(getSqlType(targetColumn));
            }
            print(")");
            if (needSubstr) {
                print(",1,");
                print(targetColumn.getSize());
                print(")");
            }
        } else {
            super.writeCastExpression(sourceColumn, targetColumn);
        }
    }
}