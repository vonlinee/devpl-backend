package org.apache.ddlutils.model;

import org.apache.ddlutils.util.ListOrderedSet;
import org.apache.ddlutils.util.StringUtils;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Objects;

/**
 * Represents a database foreign key.
 */
public class ForeignKey implements Serializable {
    /**
     * Unique ID for serialization purposes.
     */
    private static final long serialVersionUID = 7833254626253719913L;
    /**
     * The name of the foreign key, may be <code>null</code>.
     */
    private String _name;
    /**
     * The target table.
     */
    private Table _foreignTable;
    /**
     * The name of the foreign table.
     */
    private String _foreignTableName;
    /**
     * The action to perform when the value of the referenced column changes.
     */
    private CascadeActionEnum _onUpdate = CascadeActionEnum.NONE;
    /**
     * The action to perform when the referenced row is deleted.
     */
    private CascadeActionEnum _onDelete = CascadeActionEnum.NONE;
    /**
     * The references between local and remote columns.
     */
    private final ListOrderedSet<Reference> _references = new ListOrderedSet<>();
    /**
     * Whether this foreign key has an associated auto-generated index.
     */
    private boolean _autoIndexPresent;

    /**
     * Creates a new foreign key object that has no name.
     */
    public ForeignKey() {
        this(null);
    }

    /**
     * Creates a new foreign key object.
     * @param name The name of the foreign key
     */
    public ForeignKey(String name) {
        _name = name;
    }

    /**
     * Returns the name of this foreign key.
     * @return The name
     */
    public String getName() {
        return _name;
    }

    /**
     * Sets the name of this foreign key.
     * @param name The name
     */
    public void setName(String name) {
        _name = name;
    }

    /**
     * Returns the foreign table.
     * @return The foreign table
     */
    public Table getForeignTable() {
        return _foreignTable;
    }

    /**
     * Sets the foreign table.
     * @param foreignTable The foreign table
     */
    public void setForeignTable(Table foreignTable) {
        _foreignTable = foreignTable;
        _foreignTableName = (foreignTable == null ? null : foreignTable.getName());
    }

    /**
     * Returns the name of the foreign table.
     * @return The table name
     */
    public String getForeignTableName() {
        return _foreignTableName;
    }

    /**
     * Sets the name of the foreign table. Please note that you should not use this method
     * when manually constructing or manipulating the database model. Rather utilize the
     * {@link #setForeignTable(Table)} method.
     * @param foreignTableName The table name
     */
    public void setForeignTableName(String foreignTableName) {
        if ((_foreignTable != null) && !_foreignTable.getName().equals(foreignTableName)) {
            _foreignTable = null;
        }
        _foreignTableName = foreignTableName;
    }

    /**
     * Returns the action for this foreignkey for when the referenced row is deleted.
     * @return The action
     */
    public CascadeActionEnum getOnDelete() {
        return _onDelete;
    }

    /**
     * Sets the action for this foreignkey for when the referenced row is deleted.
     * @param onDelete The action
     * @throws NullPointerException If <code>onDelete</code> is null
     */
    public void setOnDelete(CascadeActionEnum onDelete) throws NullPointerException {
        if (onDelete == null) {
            throw new NullPointerException("The onDelete action cannot be null");
        }
        _onDelete = onDelete;
    }

    /**
     * Returns the action for this foreignkey for when the referenced row is changed.
     * @return The action
     */
    public CascadeActionEnum getOnUpdate() {
        return _onUpdate;
    }

    /**
     * Sets the action for this foreignkey for when the referenced row is changed.
     * @param onUpdate The action
     * @throws NullPointerException If <code>onUdate</code> is null
     */
    public void setOnUpdate(CascadeActionEnum onUpdate) throws NullPointerException {
        if (onUpdate == null) {
            throw new NullPointerException("The onUpdate action cannot be null");
        }
        _onUpdate = onUpdate;
    }

    /**
     * Returns the number of references.
     * @return The number of references
     */
    public int getReferenceCount() {
        return _references.size();
    }

    /**
     * Returns the indicated reference.
     * @param idx The index
     * @return The reference
     */
    public Reference getReference(int idx) {
        return (Reference) _references.get(idx);
    }

    /**
     * Returns the references.
     * @return The references
     */
    public Reference[] getReferences() {
        return (Reference[]) _references.toArray(new Object[0]);
    }

    /**
     * Returns the first reference if it exists.
     * @return The first reference
     */
    public Reference getFirstReference() {
        return (Reference) (_references.isEmpty() ? null : _references.get(0));
    }

    /**
     * Adds a reference, i.e. a mapping between a local column (in the table that owns this foreign key)
     * and a remote column.
     * @param reference The reference to add
     */
    public void addReference(Reference reference) {
        if (reference != null) {
            for (int idx = 0; idx < _references.size(); idx++) {
                Reference curRef = getReference(idx);

                if (curRef.getSequenceValue() > reference.getSequenceValue()) {
                    _references.add(idx, reference);
                    return;
                }
            }
            _references.add(reference);
        }
    }

    /**
     * Removes the given reference.
     * @param reference The reference to remove
     */
    public void removeReference(Reference reference) {
        if (reference != null) {
            _references.remove(reference);
        }
    }

    /**
     * Removes the indicated reference.
     * @param idx The index of the reference to remove
     */
    public void removeReference(int idx) {
        _references.remove(idx);
    }

    /**
     * Determines whether this foreign key uses the given column as a local
     * column in a reference.
     * @param column The column to check
     * @return <code>true</code> if a reference uses the column as a local
     * column
     */
    public boolean hasLocalColumn(Column column) {
        for (int idx = 0; idx < getReferenceCount(); idx++) {
            if (column.equals(getReference(idx).getLocalColumn())) {
                return true;
            }
        }
        return false;
    }

    /**
     * Determines whether this foreign key uses the indicated column as a local
     * column in a reference. This method assumes that the caller checked
     * already that the column is a column in the table owning this foreign key.
     * @param columnName    The name of the column to check
     * @param caseSensitive Whether case matters when checking for the column's name
     * @return <code>true</code> if a reference uses the column as a local
     * column
     */
    public boolean hasLocalColumn(String columnName, boolean caseSensitive) {
        for (int idx = 0; idx < getReferenceCount(); idx++) {
            if (StringUtils.equals(columnName, getReference(idx).getLocalColumnName(), caseSensitive)) {
                return true;
            }
        }
        return false;
    }

    /**
     * Determines whether this foreign key uses the given column as a foreign
     * column in a reference.
     * @param column The column to check
     * @return <code>true</code> if a reference uses the column as a foreign
     * column
     */
    public boolean hasForeignColumn(Column column) {
        for (int idx = 0; idx < getReferenceCount(); idx++) {
            if (column.equals(getReference(idx).getForeignColumn())) {
                return true;
            }
        }
        return false;
    }

    /**
     * Determines whether this foreign key uses the given column as a foreign
     * column in a reference. This method assumes that the caller already checked
     * whether this foreign key references the tale owning the indicate column.
     * @param columnName    The name of the column to check
     * @param caseSensitive Whether case matters when checking for the column's name
     * @return <code>true</code> if a reference uses the column as a foreign
     * column
     */
    public boolean hasForeignColumn(String columnName, boolean caseSensitive) {
        for (int idx = 0; idx < getReferenceCount(); idx++) {
            if (StringUtils.equals(columnName, getReference(idx).getForeignColumnName(), caseSensitive)) {
                return true;
            }
        }
        return false;
    }

    /**
     * Determines whether this foreign key has an auto-generated associated index. Note that
     * this is a hint for the platform and has no relevancy to the model itself.
     * @return <code>true</code> if an auto-generated index exists
     */
    public boolean isAutoIndexPresent() {
        return _autoIndexPresent;
    }

    /**
     * Specifies whether this foreign key has an auto-generated associated index. Note that
     * this is a hint set by the model reader and has no relevancy to the model itself.
     * @param autoIndexPresent <code>true</code> if an auto-generated index exists
     */
    public void setAutoIndexPresent(boolean autoIndexPresent) {
        _autoIndexPresent = autoIndexPresent;
    }


    @Override
    public boolean equals(Object obj) {
        if (obj instanceof ForeignKey otherFk) {

            // Note that this compares case-sensitive
            // Note also that we can simply compare the references regardless of their order
            // (which is irrelevant for fks) because they are contained in a set
            return Objects.equals(_name, otherFk._name) && Objects.equals(_foreignTableName, otherFk._foreignTableName) && Objects.equals(_references, otherFk._references);
        } else {
            return false;
        }
    }

    /**
     * Compares this foreign key to the given one while ignoring the case of identifiers.
     * @param otherFk The other foreign key
     * @return <code>true</code> if this foreign key is equal (ignoring case) to the given one
     */
    public boolean equalsIgnoreCase(ForeignKey otherFk) {
        boolean checkName = (_name != null) && (!_name.isEmpty()) && (otherFk._name != null) && (!otherFk._name.isEmpty());

        if ((!checkName || _name.equalsIgnoreCase(otherFk._name)) && _foreignTableName.equalsIgnoreCase(otherFk._foreignTableName)) {

            HashSet<Reference> otherRefs = new HashSet<>(otherFk._references);
            for (Reference curLocalRef : _references) {
                boolean found = false;

                for (Iterator<Reference> otherIt = otherRefs.iterator(); otherIt.hasNext(); ) {
                    Reference curOtherRef = otherIt.next();

                    if (curLocalRef.equalsIgnoreCase(curOtherRef)) {
                        otherIt.remove();
                        found = true;
                        break;
                    }
                }
                if (!found) {
                    return false;
                }
            }
            return otherRefs.isEmpty();
        } else {
            return false;
        }
    }


    @Override
    public int hashCode() {
        return Objects.hash(_name, _foreignTableName, _references);
    }


    @Override
    public String toString() {
        StringBuilder result = new StringBuilder();

        result.append("Foreign key [");
        if ((getName() != null) && (!getName().isEmpty())) {
            result.append("name=");
            result.append(getName());
            result.append("; ");
        }
        result.append("foreign table=");
        result.append(getForeignTableName());
        result.append("; ");
        result.append(getReferenceCount());
        result.append(" references]");

        return result.toString();
    }

    /**
     * Returns a verbose string representation of this foreign key.
     * @return The string representation
     */
    public String toVerboseString() {
        StringBuilder result = new StringBuilder();

        result.append("ForeignK ky [");
        if ((getName() != null) && (!getName().isEmpty())) {
            result.append("name=");
            result.append(getName());
            result.append("; ");
        }
        result.append("foreign table=");
        result.append(getForeignTableName());
        result.append("] references:");
        for (int idx = 0; idx < getReferenceCount(); idx++) {
            result.append(" ");
            result.append(getReference(idx).toString());
        }

        return result.toString();
    }
}
