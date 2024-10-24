package org.apache.ddlutils.model;

/**
 * Helper class that provides coping of model elements.
 */
public class DefaultModelCopier implements ModelCopier {
    /**
     * Returns a deep copy of the given model object, including all tables, foreign keys, indexes etc.
     *
     * @param source The source model
     * @return The copy
     */
    @Override
    public Database copy(Database source) {
        Database result = new Database();
        result.setName(source.getName());
        result.setIdMethod(source.getIdMethod());
        result.setVersion(source.getVersion());
        for (Table sourceTable : source.getTables()) {
            Table table = copy(sourceTable, true, false, result, true);
            result.addTable(table);
            for (ForeignKey sourceFk : sourceTable.getForeignKeys()) {
                table.addForeignKey(copy(sourceFk, table, result, true));
            }
        }
        return result;
    }

    /**
     * Returns a copy of the given table.
     *
     * @param source           The source table
     * @param cloneIndexes     Whether to copy indexes; if <code>false</code> then the copy will
     *                         not have any indexes
     * @param cloneForeignKeys Whether to copy foreign keys; if <code>false</code> then the copy
     *                         will not have any foreign keys
     * @param targetModel      The target model, can be <code>null</code> if
     *                         <code>cloneForeignKeys=false</code>
     * @param caseSensitive    Whether comparison is case-sensitive (for cloning foreign keys)
     * @return The copy
     */
    @Override
    public Table copy(Table source, boolean cloneIndexes, boolean cloneForeignKeys, Database targetModel, boolean caseSensitive) {
        Table result = new Table();
        result.setCatalog(source.getCatalog());
        result.setSchema(source.getSchema());
        result.setName(source.getName());
        result.setType(source.getType());
        for (Column column : source.getColumns()) {
            result.addColumn(copy(column, true));
        }
        if (cloneIndexes) {
            for (int indexIdx = 0; indexIdx < source.getIndexCount(); indexIdx++) {
                result.addIndex(copy(source.getIndex(indexIdx), result, true));
            }
        }
        if (cloneForeignKeys) {
            for (int fkIdx = 0; fkIdx < source.getForeignKeyCount(); fkIdx++) {
                result.addForeignKey(copy(source.getForeignKey(fkIdx), result, targetModel, caseSensitive));
            }
        }
        return result;
    }

    /**
     * Returns a copy of the given source column.
     *
     * @param source                The source column
     * @param clonePrimaryKeyStatus Whether to copy the column's primary key status; if <code>false</code>
     *                              then the copy will not be a primary key column
     * @return The copy
     */
    @Override
    public Column copy(Column source, boolean clonePrimaryKeyStatus) {
        Column result = new Column();
        result.setName(source.getName());
        result.setPropertyName(source.getPropertyName());
        result.setPrimaryKey(clonePrimaryKeyStatus && source.isPrimaryKey());
        result.setRequired(source.isRequired());
        result.setAutoIncrement(source.isAutoIncrement());
        result.setTypeCode(source.getTypeCode());
        result.setSize(source.getSize());
        result.setDefaultValue(source.getDefaultValue());
        return result;
    }

    /**
     * Returns a copy of the given source index.
     *
     * @param source        The source index
     * @param targetTable   The table whose columns shall be used by the copy
     * @param caseSensitive Whether comparison is case-sensitive (for finding the columns
     *                      in the target table)
     * @return The copy
     */
    @Override
    public Index copy(Index source, Table targetTable, boolean caseSensitive) {
        Index result = (source.isUnique() ? new UniqueIndex() : new NonUniqueIndex());
        result.setName(source.getName());
        for (int colIdx = 0; colIdx < source.getColumnCount(); colIdx++) {
            IndexColumn column = source.getColumn(colIdx);
            result.addColumn(copy(column, targetTable, caseSensitive));
        }
        return result;
    }

    /**
     * Returns a copy of the given index column.
     *
     * @param source        The source index column
     * @param targetTable   The table containing the column to be used by the copy
     * @param caseSensitive Whether comparison is case-sensitive (for finding the columns
     *                      in the target table)
     * @return The copy
     */
    @Override
    public IndexColumn copy(IndexColumn source, Table targetTable, boolean caseSensitive) {
        IndexColumn result = new IndexColumn();
        result.setColumn(targetTable.findColumn(source.getName(), caseSensitive));
        result.setOrdinalPosition(source.getOrdinalPosition());
        result.setSize(source.getSize());
        return result;
    }

    /**
     * Returns a copy of the given source foreign key.
     *
     * @param source        The source foreign key
     * @param owningTable   The table owning the source foreign key
     * @param targetModel   The target model containing the tables that the copy shall link
     * @param caseSensitive Whether comparison is case-sensitive (for finding the columns
     *                      in the target model)
     * @return The copy
     */
    @Override
    public ForeignKey copy(ForeignKey source, Table owningTable, Database targetModel, boolean caseSensitive) {
        ForeignKey result = new ForeignKey();
        Table foreignTable = targetModel.findTable(source.getForeignTableName(), caseSensitive);
        result.setName(source.getName());
        result.setForeignTable(foreignTable);
        result.setAutoIndexPresent(source.isAutoIndexPresent());
        result.setOnDelete(source.getOnDelete());
        result.setOnUpdate(source.getOnUpdate());
        for (int refIdx = 0; refIdx < source.getReferenceCount(); refIdx++) {
            Reference ref = source.getReference(refIdx);
            result.addReference(copy(ref, owningTable, foreignTable, caseSensitive));
        }
        return result;
    }

    /**
     * Returns a copy of the given source reference.
     *
     * @param source        The source reference
     * @param localTable    The table containing the local column to be used by the reference
     * @param foreignTable  The table containing the foreign column to be used by the reference
     * @param caseSensitive Whether comparison is case-sensitive (for finding the columns
     *                      in the tables)
     * @return The copy
     */
    @Override
    public Reference copy(Reference source, Table localTable, Table foreignTable, boolean caseSensitive) {
        Reference result = new Reference();
        result.setLocalColumn(localTable.findColumn(source.getLocalColumnName(), caseSensitive));
        result.setForeignColumn(foreignTable.findColumn(source.getForeignColumnName(), caseSensitive));
        return result;
    }
}
