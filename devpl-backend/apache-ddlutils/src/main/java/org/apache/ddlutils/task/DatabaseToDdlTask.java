package org.apache.ddlutils.task;

import org.apache.ddlutils.DdlUtilsTaskException;
import org.apache.ddlutils.model.Database;
import org.apache.ddlutils.model.ModelHelper;
import org.apache.ddlutils.model.Table;
import org.apache.ddlutils.util.StringUtils;

import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;

/**
 * Task for getting structural info and data from a live database. E.g. it has sub-tasks for
 * writing the schema of the live database or the data currently in it to an XML file, for
 * creating the DTDs for these data files, and for generating SQL to creating a schema in the
 * database to a file.
 * <br/>
 * Example:<br/>
 * <pre>
 * &lt;taskdef classname="org.apache.ddlutils.task.DatabaseToDdlTask"
 *          name="databaseToDdl"
 *          classpath="project-classpath" /&gt;
 *
 * &lt;databaseToDdl useDelimitedSqlIdentifiers="true"
 *                modelName="example"&gt;
 *   &lt;database driverClassName="org.apache.derby.jdbc.ClientDriver"
 *             url="jdbc:derby://localhost/ddlutils"
 *             username="ddlutils"
 *             password="ddlutils"/&gt;
 *
 *   &lt;write schema to file outputFile="schema.xml"/&gt;
 *   &lt;write data to file outputFile="data.xml"
 *                    encoding="ISO-8859-1"/&gt;
 * &lt;/databaseToDdl&gt;
 * </pre>
 * This reads the schema and data from the database and writes them to XML files.
 */
public class DatabaseToDdlTask extends DatabaseTask {
    /**
     * The table types to recognize when reading the model from the database.
     */
    private String _tableTypes;
    /**
     * The name of the model read from the database.
     */
    private String databaseName = "unnamed";
    /**
     * The names of the tables to read.
     */
    private String[] _includeTableNames;
    /**
     * The regular expression matching the names of the tables to read.
     */
    private String _includeTableNameRegExp;
    /**
     * The names of the tables to ignore.
     */
    private String[] _excludeTableNames;
    /**
     * The regular expression matching the names of the tables to ignore.
     */
    private String _excludeTableNameRegExp;

    /**
     * Specifies the name of the model that is read from the database. This is mostly useful
     * for the <code>writeSchemaToFile</code> sub-task as it ensures that the generated
     * XML defines a valid model.
     *
     * @param databaseName The database name. Use <code>null</code> or an empty string for the default name
     *                     By default, DldUtils uses the schema name returned from the database
     *                     or <code>"default"</code> if no schema name was returned by the database.
     */
    public void setDatabaseName(String databaseName) {
        this.databaseName = databaseName;
    }

    /**
     * Sets the names of the tables that shall be read, as a comma-separated list. Escape a
     * comma via '\,' if it is part of the table name. Please note that table names are
     * not trimmed which means that whitespace characters should only be present in
     * this string if they are actually part of the table name (i.e. in delimited
     * identifier mode).
     *
     * @param tableNameList The comma-separated list of table names
     *                      If no table filter is specified, then all tables will be read unless
     *                      <code>excludeTables</code> or <code>excludeTableFilter</code> is
     *                      specified
     */
    public void setIncludeTables(String tableNameList) {
        _includeTableNames = TaskHelper.parseCommaSeparatedStringList(tableNameList);
    }

    /**
     * Sets the regular expression matching the names of the tables that shall be read.
     * For case-insensitive matching, an uppercase name can be assumed.
     *
     * @param tableNameRegExp The regular expression; see {@link java.util.regex.Pattern}
     *                        for details
     *                        If no table filter is specified, then all tables will be read unless
     *                        <code>excludeTables</code> or <code>excludeTableFilter</code> is
     *                        specified
     */
    public void setIncludeTableFilter(String tableNameRegExp) {
        _includeTableNameRegExp = tableNameRegExp;
    }

    /**
     * Sets the names of the tables that shall be ignored, as a comma-separated list. Escape a
     * comma via '\,' if it is part of the table name. Please note that table names are
     * not trimmed which means that whitespace characters should only be present in
     * this string if they are actually part of the table name (i.e. in delimited
     * identifier mode).
     *
     * @param tableNameList The comma-separated list of table names
     *                      If no table filter is specified, then all tables will be read unless
     *                      <code>includeTables</code> or <code>includeTableFilter</code> is
     *                      specified
     */
    public void setExcludeTables(String tableNameList) {
        _excludeTableNames = TaskHelper.parseCommaSeparatedStringList(tableNameList);
    }

    /**
     * Sets the regular expression matching the names of the tables that shall be ignored.
     * For case-insensitive matching, an uppercase name can be assumed.
     *
     * @param tableNameRegExp The regular expression; see {@link java.util.regex.Pattern}
     *                        for details
     *                        If no table filter is specified, then all tables will be read unless
     *                        <code>includeTables</code> or <code>includeTableFilter</code> is
     *                        specified
     */
    public void setExcludeTableFilter(String tableNameRegExp) {
        _excludeTableNameRegExp = tableNameRegExp;
    }

    /**
     * Adds the "create dtd"-command.
     *
     * @param command The command
     */
    public void addWriteDtdToFile(WriteDtdToFileCommand command) {
        addCommand(command);
    }

    /**
     * Adds the "write schema to file"-command.
     *
     * @param command The command
     */
    public void addWriteSchemaToFile(WriteSchemaToFileCommand command) {
        addCommand(command);
    }

    /**
     * Adds the "write schema sql to file"-command.
     *
     * @param command The command
     */
    public void addWriteSchemaSqlToFile(WriteSchemaSqlToFileCommand command) {
        addCommand(command);
    }

    /**
     * Adds the "write data into database"-command.
     *
     * @param command The command
     */
    public void addWriteDataToDatabase(WriteDataToDatabaseCommand command) {
        addCommand(command);
    }

    /**
     * Adds the "write data into file"-command.
     *
     * @param command The command
     */
    public void addWriteDataToFile(WriteDataToFileCommand command) {
        addCommand(command);
    }

    /**
     * Adds the "drop tables"-command.
     *
     * @param command The command
     */
    public void addDropTables(DropTablesCommand command) {
        addCommand(command);
    }

    /**
     * Returns the table types to recognize.
     *
     * @return The table types
     */
    private String[] getTableTypes() {
        return StringUtils.splitToArray(_tableTypes, ",");
    }

    /**
     * Specifies the table types to be processed. More precisely, all tables that are of a
     * type not in this list, will be ignored by the task and its sub-tasks. For details and
     * typical table types see
     * <a href="http://java.sun.com/j2se/1.4.2/docs/api/java/sql/DatabaseMetaData.html#getTables(java.lang.String,%20java.lang.String,%20java.lang.String,%20java.lang.String[])">java.sql.DatabaseMetaData#getTables</a>.
     *
     * @param tableTypes The table types as a comma-separated list
     *                   By default, only tables of type <code>TABLE</code> are used by the task.
     */
    public void setTableTypes(String tableTypes) {
        _tableTypes = tableTypes;
    }

    @Override
    protected Database readModel() {
        if (getDataSource() == null) {
            throw new DdlUtilsTaskException("No database specified.");
        }
        try {
            Database model = getPlatform().readModelFromDatabase(databaseName,
                getPlatformConfiguration().getCatalogPattern(),
                getPlatformConfiguration().getSchemaPattern(),
                getTableTypes());

            if (_includeTableNames != null || _includeTableNameRegExp != null ||
                _excludeTableNames != null || _excludeTableNameRegExp != null) {

                if (_includeTableNames != null) {
                    Table[] tables = model.findTables(_includeTableNames, getPlatformConfiguration().isUseDelimitedSqlIdentifiers());
                    ModelHelper.checkForForeignKeysToAndFromTables(model, tables);
                    model.removeAllTablesExcept(tables);
                } else if (_includeTableNameRegExp != null) {
                    Table[] tables = model.findTables(_includeTableNameRegExp, getPlatformConfiguration().isUseDelimitedSqlIdentifiers());
                    ModelHelper.checkForForeignKeysToAndFromTables(model, tables);
                    model.removeAllTablesExcept(tables);
                }
                if (_excludeTableNames != null) {
                    Table[] tables = model.findTables(_excludeTableNames, getPlatformConfiguration().isUseDelimitedSqlIdentifiers());
                    ModelHelper.checkForForeignKeysToAndFromTables(model, tables);
                    model.removeTables(tables);
                } else if (_excludeTableNameRegExp != null) {
                    Table[] tables = model.findTables(_excludeTableNameRegExp, getPlatformConfiguration().isUseDelimitedSqlIdentifiers());
                    ModelHelper.checkForForeignKeysToAndFromTables(model, tables);
                    model.removeTables(tables);
                }
            }
            return model;
        } catch (Exception ex) {
            throw new DdlUtilsTaskException("Could not read the schema from the specified database: " + ex.getLocalizedMessage(), ex);
        }
    }
}
