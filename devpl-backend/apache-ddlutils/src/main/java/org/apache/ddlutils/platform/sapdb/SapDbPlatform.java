package org.apache.ddlutils.platform.sapdb;


import org.apache.ddlutils.PlatformInfo;
import org.apache.ddlutils.alteration.*;
import org.apache.ddlutils.model.CascadeActionEnum;
import org.apache.ddlutils.model.Column;
import org.apache.ddlutils.model.Database;
import org.apache.ddlutils.model.Table;
import org.apache.ddlutils.platform.*;
import org.apache.ddlutils.util.StringUtils;

import java.io.IOException;
import java.sql.Types;

/**
 * The SapDB platform implementation.
 */
public class SapDbPlatform extends PlatformImplBase {

    /**
     * Creates a new platform instance.
     */
    public SapDbPlatform() {
        PlatformInfo info = getPlatformInfo();

        info.setMaxIdentifierLength(32);
        info.setPrimaryKeyColumnAutomaticallyRequired(true);
        info.setMultipleIdentityColumnsSupported(false);
        info.setCommentPrefix("/*");
        info.setCommentSuffix("*/");
        info.setSupportedOnDeleteActions(new CascadeActionEnum[]{CascadeActionEnum.CASCADE, CascadeActionEnum.RESTRICT, CascadeActionEnum.SET_DEFAULT, CascadeActionEnum.SET_NULL, CascadeActionEnum.NONE});
        info.addEquivalentOnDeleteActions(CascadeActionEnum.NONE, CascadeActionEnum.RESTRICT);
        info.setSupportedOnUpdateActions(new CascadeActionEnum[]{CascadeActionEnum.NONE});
        info.addEquivalentOnUpdateActions(CascadeActionEnum.NONE, CascadeActionEnum.RESTRICT);

        // BIGINT is also handled by the model reader
        // Unfortunately there is no way to distinguish between REAL, and FLOAT/DOUBLE when
        // reading back via JDBC, because they all have the same size of 8
        info.addNativeTypeMapping(Types.ARRAY, "LONG BYTE", Types.LONGVARBINARY);
        info.addNativeTypeMapping(Types.BIGINT, "FIXED(38,0)");
        info.addNativeTypeMapping(Types.BINARY, "CHAR{0} BYTE");
        info.addNativeTypeMapping(Types.BIT, "BOOLEAN");
        info.addNativeTypeMapping(Types.BLOB, "LONG BYTE", Types.LONGVARBINARY);
        info.addNativeTypeMapping(Types.BOOLEAN, "BOOLEAN", Types.BIT);
        info.addNativeTypeMapping(Types.CLOB, "LONG", Types.LONGVARCHAR);
        info.addNativeTypeMapping(Types.DATALINK, "LONG BYTE", Types.LONGVARBINARY);
        info.addNativeTypeMapping(Types.DECIMAL, "FIXED");
        info.addNativeTypeMapping(Types.DISTINCT, "LONG BYTE", Types.LONGVARBINARY);
        info.addNativeTypeMapping(Types.DOUBLE, "FLOAT(38)", Types.FLOAT);
        info.addNativeTypeMapping(Types.FLOAT, "FLOAT(38)");
        info.addNativeTypeMapping(Types.JAVA_OBJECT, "LONG BYTE", Types.LONGVARBINARY);
        info.addNativeTypeMapping(Types.LONGVARBINARY, "LONG BYTE");
        info.addNativeTypeMapping(Types.LONGVARCHAR, "LONG");
        info.addNativeTypeMapping(Types.NULL, "LONG BYTE", Types.LONGVARBINARY);
        info.addNativeTypeMapping(Types.NUMERIC, "FIXED", Types.DECIMAL);
        info.addNativeTypeMapping(Types.OTHER, "LONG BYTE", Types.LONGVARBINARY);
        info.addNativeTypeMapping(Types.REAL, "FLOAT(16)", Types.FLOAT);
        info.addNativeTypeMapping(Types.REF, "LONG BYTE", Types.LONGVARBINARY);
        info.addNativeTypeMapping(Types.STRUCT, "LONG BYTE", Types.LONGVARBINARY);
        info.addNativeTypeMapping(Types.TINYINT, "SMALLINT", Types.SMALLINT);
        info.addNativeTypeMapping(Types.VARBINARY, "VARCHAR{0} BYTE");

        info.setDefaultSize(Types.CHAR, 254);
        info.setDefaultSize(Types.VARCHAR, 254);
        info.setDefaultSize(Types.BINARY, 254);
        info.setDefaultSize(Types.VARBINARY, 254);

        setSqlBuilder(new SapDbBuilder(this));
        setModelReader(new SapDbModelReader(this));
    }

    @Override
    public DBType getDBType() {
        return BuiltinDBType.SAPDB;
    }

    /**
     * Returns the model comparator for this platform.
     *
     * @return The comparator
     */
    @Override
    protected ModelComparator getModelComparator() {
        ModelComparator comparator = super.getModelComparator();

        comparator.setCanDropPrimaryKeyColumns(false);
        comparator.setGeneratePrimaryKeyChanges(false);
        return comparator;
    }

    @Override
    protected TableDefinitionChangesPredicate getTableDefinitionChangesPredicate() {
        return new DefaultTableDefinitionChangesPredicate() {
            @Override
            protected boolean isSupported(Table intermediateTable, TableChange change) {
                if ((change instanceof RemoveColumnChange) ||
                    (change instanceof AddPrimaryKeyChange) ||
                    (change instanceof PrimaryKeyChange) ||
                    (change instanceof RemovePrimaryKeyChange)) {
                    return true;
                } else if (change instanceof AddColumnChange addColumnChange) {

                    // SapDB can only add not insert columns, and required columns have to have
                    // a default value or be IDENTITY
                    return (addColumnChange.getNextColumn() == null) &&
                           (!addColumnChange.getNewColumn().isRequired() ||
                            !StringUtils.isEmpty(addColumnChange.getNewColumn().getDefaultValue()));
                } else if (change instanceof ColumnDefinitionChange colChange) {

                    // SapDB has a ALTER TABLE MODIFY COLUMN, but it is limited regarding the type conversions
                    // it can perform, so we don't use it here but rather rebuild the table
                    Column curColumn = intermediateTable.findColumn(colChange.getChangedColumn(), isDelimitedIdentifierModeOn());
                    Column newColumn = colChange.getNewColumn();

                    // we can however handle the change if only the default value or the required status was changed
                    return ((curColumn.getTypeCode() == newColumn.getTypeCode()) &&
                            !ColumnDefinitionChange.isSizeChanged(getPlatformInfo(), curColumn, newColumn) &&
                            (curColumn.isAutoIncrement() == newColumn.isAutoIncrement()));
                }
                return false;
            }
        };
    }

    /**
     * Processes the removal of a column from a table.
     *
     * @param currentModel The current database schema
     * @param params       The parameters used in the creation of new tables. Note that for existing
     *                     tables, the parameters won't be applied
     * @param change       The change object
     */
    public void processChange(Database currentModel,
                              CreationParameters params,
                              RemoveColumnChange change) throws IOException {
        Table changedTable = findChangedTable(currentModel, change);
        Column removedColumn = changedTable.findColumn(change.getChangedColumn(), isDelimitedIdentifierModeOn());

        ((SapDbBuilder) getSqlBuilder()).dropColumn(changedTable, removedColumn);
        change.apply(currentModel, isDelimitedIdentifierModeOn());
    }

    /**
     * Processes the removal of a primary key from a table.
     *
     * @param currentModel The current database schema
     * @param params       The parameters used in the creation of new tables. Note that for existing
     *                     tables, the parameters won't be applied
     * @param change       The change object
     */
    public void processChange(Database currentModel,
                              CreationParameters params,
                              RemovePrimaryKeyChange change) throws IOException {
        Table changedTable = findChangedTable(currentModel, change);

        ((SapDbBuilder) getSqlBuilder()).dropPrimaryKey(changedTable);
        change.apply(currentModel, isDelimitedIdentifierModeOn());
    }

    /**
     * Processes the change of the primary key of a table.
     *
     * @param currentModel The current database schema
     * @param params       The parameters used in the creation of new tables. Note that for existing
     *                     tables, the parameters won't be applied
     * @param change       The change object
     */
    public void processChange(Database currentModel,
                              CreationParameters params,
                              PrimaryKeyChange change) throws IOException {
        Table changedTable = findChangedTable(currentModel, change);
        String[] newPKColumnNames = change.getNewPrimaryKeyColumns();
        Column[] newPKColumns = new Column[newPKColumnNames.length];

        for (int colIdx = 0; colIdx < newPKColumnNames.length; colIdx++) {
            newPKColumns[colIdx] = changedTable.findColumn(newPKColumnNames[colIdx], isDelimitedIdentifierModeOn());
        }

        ((SapDbBuilder) getSqlBuilder()).dropPrimaryKey(changedTable);
        getSqlBuilder().createPrimaryKey(changedTable, newPKColumns);
        change.apply(currentModel, isDelimitedIdentifierModeOn());
    }

    /**
     * Processes the change of the column of a table.
     *
     * @param currentModel The current database schema
     * @param params       The parameters used in the creation of new tables. Note that for existing
     *                     tables, the parameters won't be applied
     * @param change       The change object
     */
    public void processChange(Database currentModel,
                              CreationParameters params,
                              ColumnDefinitionChange change) throws IOException {
        Table changedTable = findChangedTable(currentModel, change);
        Column changedColumn = changedTable.findColumn(change.getChangedColumn(), isDelimitedIdentifierModeOn());

        if (!StringUtils.equals(changedColumn.getDefaultValue(), change.getNewColumn().getDefaultValue())) {
            ((SapDbBuilder) getSqlBuilder()).changeColumnDefaultValue(changedTable,
                changedColumn,
                change.getNewColumn().getDefaultValue());
        }
        if (changedColumn.isRequired() != change.getNewColumn().isRequired()) {
            ((SapDbBuilder) getSqlBuilder()).changeColumnRequiredStatus(changedTable,
                changedColumn,
                change.getNewColumn().isRequired());
        }
        change.apply(currentModel, isDelimitedIdentifierModeOn());
    }
}
