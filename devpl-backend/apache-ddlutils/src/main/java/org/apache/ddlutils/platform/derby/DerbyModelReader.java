package org.apache.ddlutils.platform.derby;

import org.apache.ddlutils.Platform;
import org.apache.ddlutils.model.*;
import org.apache.ddlutils.platform.DatabaseMetaDataWrapper;
import org.apache.ddlutils.platform.JdbcModelReader;
import org.apache.ddlutils.util.ContextMap;

import java.sql.SQLException;

/**
 * Reads a database model from a Derby database.
 */
public class DerbyModelReader extends JdbcModelReader {
    /**
     * Creates a new model reader for Derby databases.
     *
     * @param platform The platform that this model reader belongs to
     */
    public DerbyModelReader(Platform platform) {
        super(platform);
    }

    @Override
    protected Column readColumn(DatabaseMetaDataWrapper metaData, ContextMap values) throws SQLException {
        Column column = super.readColumn(metaData, values);
        String defaultValue = column.getDefaultValue();

        if (defaultValue != null) {
            // we check for these strings
            //   GENERATED_BY_DEFAULT               -> 'GENERATED BY DEFAULT AS IDENTITY'
            //   AUTOINCREMENT: start 1 increment 1 -> 'GENERATED ALWAYS AS IDENTITY'
            if ("GENERATED_BY_DEFAULT".equals(defaultValue) || defaultValue.startsWith("AUTOINCREMENT:")) {
                column.setDefaultValue(null);
                column.setAutoIncrement(true);
            } else if (TypeMap.isTextType(column.getTypeCode())) {
                column.setDefaultValue(unescape(defaultValue, "'", "''"));
            }
        }
        return column;
    }

    @Override
    protected boolean isInternalForeignKeyIndex(DatabaseMetaDataWrapper metaData, Table table, ForeignKey fk, Index index) {
        return isInternalIndex(index);
    }

    @Override
    protected boolean isInternalPrimaryKeyIndex(DatabaseMetaDataWrapper metaData, Table table, Index index) {
        return isInternalIndex(index);
    }

    /**
     * Determines whether the index is an internal index, i.e. one created by Derby.
     *
     * @param index The index to check
     * @return <code>true</code> if the index seems to be an internal one
     */
    private boolean isInternalIndex(Index index) {
        String name = index.getName();

        // Internal names normally have the form "SQL051228005030780"
        if ((name != null) && name.startsWith("SQL")) {
            try {
                Long.parseLong(name.substring(3));
                return true;
            } catch (NumberFormatException ex) {
                // we ignore it
            }
        }
        return false;
    }
}
