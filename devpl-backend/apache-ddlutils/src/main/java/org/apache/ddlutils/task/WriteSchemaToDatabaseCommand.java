package org.apache.ddlutils.task;

import org.apache.ddlutils.DatabasePlatform;
import org.apache.ddlutils.model.Database;
import org.apache.ddlutils.platform.SqlBuildContext;

/**
 * Parses the schema XML files specified for the enclosing task, and creates the corresponding
 * schema in the database.
 * @version $Revision: 289996 $
 * name="writeSchemaToDatabase"
 */
public class WriteSchemaToDatabaseCommand extends DatabaseCommandWithCreationParameters {
    /**
     * Whether to alter or re-set the database if it already exists.
     */
    private boolean _alterDb = true;
    /**
     * Whether to drop tables and the associated constraints if necessary.
     */
    private boolean _doDrops = true;

    /**
     * Determines whether to alter the database if it already exists, or re-set it.
     * @return <code>true</code> if to alter the database
     */
    protected boolean isAlterDatabase() {
        return _alterDb;
    }

    /**
     * Specifies whether DdlUtils shall alter an existing database rather than clearing it and
     * creating it new.
     * @param alterTheDb <code>true</code> if to alter the database
     *                   Per default an existing database is altered
     */
    public void setAlterDatabase(boolean alterTheDb) {
        _alterDb = alterTheDb;
    }

    /**
     * Determines whether to drop tables and the associated constraints before re-creating them
     * (this implies <code>alterDatabase</code> is <code>false</code>).
     * @return <code>true</code> if drops shall be performed
     */
    protected boolean isDoDrops() {
        return _doDrops;
    }

    /**
     * Specifies whether tables, external constraints, etc. can be dropped if necessary.
     * Note that this is only relevant when <code>alterDatabase</code> is <code>false</code>.
     * @param doDrops <code>true</code> if drops shall be performed
     *                Per default database structures are dropped if necessary
     */
    public void setDoDrops(boolean doDrops) {
        _doDrops = doDrops;
    }

    @Override
    public void execute(DatabaseTaskBase task, Database model) throws RuntimeException {
        if (getDataSource() == null) {
            throw new RuntimeException("No database specified.");
        }

        DatabasePlatform platform = getPlatform();
        boolean isCaseSensitive = platform.isDelimitedIdentifierModeOn();
        SqlBuildContext params = getFilteredParameters(model, platform.getName(), isCaseSensitive);

        platform.setScriptModeOn(false);
        // we're disabling the comment generation because we're writing directly to the database
        platform.setSqlCommentsOn(false);
        try {
            if (isAlterDatabase()) {
                Database currentModel = platform.readModelFromDatabase(model.getName(), getCatalogPattern(), getSchemaPattern(), null);

                platform.alterModel(currentModel, model, params, true);
            } else {
                platform.createModel(model,
                    params,
                    _doDrops,
                    true);
            }

            _log.info("Written schema to database");
        } catch (Exception ex) {
            handleException(ex, ex.getMessage());
        }
    }
}
