package org.apache.ddlutils.alteration;

import org.apache.ddlutils.model.Database;
import org.apache.ddlutils.model.ForeignKey;

/**
 * Represents a change to a foreign key of a table.
 */
public interface ForeignKeyChange extends TableChange {
    /**
     * Finds the foreign key object corresponding to the changed foreign key in the given database model.
     *
     * @param model         The database model
     * @param caseSensitive Whether identifiers are case-sensitive
     * @return The foreign key object or <code>null</code> if it could not be found
     */
    ForeignKey findChangedForeignKey(Database model, boolean caseSensitive);
}
