package org.apache.ddlutils.model;

import java.io.Serial;
import java.io.Serializable;
import java.util.Objects;

/**
 * Represents a reference between a column in the local table and a column in another table.
 */
public class Reference implements Serializable {
    /**
     * Unique ID for serialization purposes.
     */
    @Serial
    private static final long serialVersionUID = 6062467640266171664L;

    /**
     * The sequence value within the key.
     */
    private int _sequenceValue;
    /**
     * The local column.
     */
    private Column _localColumn;
    /**
     * The foreign column.
     */
    private Column _foreignColumn;
    /**
     * The name of the local column.
     */
    private String _localColumnName;
    /**
     * The name of the foreign column.
     */
    private String _foreignColumnName;

    /**
     * Creates a new, empty reference.
     */
    public Reference() {
    }

    /**
     * Creates a new reference between the two given columns.
     *
     * @param localColumn   The local column
     * @param foreignColumn The remote column
     */
    public Reference(Column localColumn, Column foreignColumn) {
        setLocalColumn(localColumn);
        setForeignColumn(foreignColumn);
    }

    /**
     * Returns the sequence value within the owning key.
     *
     * @return The sequence value
     */
    public int getSequenceValue() {
        return _sequenceValue;
    }

    /**
     * Sets the sequence value within the owning key. Please note
     * that you should not change the value once the reference has
     * been added to a key.
     *
     * @param sequenceValue The sequence value
     */
    public void setSequenceValue(int sequenceValue) {
        _sequenceValue = sequenceValue;
    }

    /**
     * Returns the local column.
     *
     * @return The local column
     */
    public Column getLocalColumn() {
        return _localColumn;
    }

    /**
     * Sets the local column.
     *
     * @param localColumn The local column
     */
    public void setLocalColumn(Column localColumn) {
        _localColumn = localColumn;
        _localColumnName = (localColumn == null ? null : localColumn.getName());
    }

    /**
     * Returns the foreign column.
     *
     * @return The foreign column
     */
    public Column getForeignColumn() {
        return _foreignColumn;
    }

    /**
     * Sets the foreign column.
     *
     * @param foreignColumn The foreign column
     */
    public void setForeignColumn(Column foreignColumn) {
        _foreignColumn = foreignColumn;
        _foreignColumnName = foreignColumn == null ? null : foreignColumn.getName();
    }

    /**
     * Returns the name of the local column.
     *
     * @return The column name
     */
    public String getLocalColumnName() {
        return _localColumnName;
    }

    /**
     * Sets the name of the local column. Note that you should not use this method when
     * manipulating the model manually. Rather use the {@link #setLocalColumn(Column)} method.
     *
     * @param localColumnName The column name
     */
    public void setLocalColumnName(String localColumnName) {
        if ((_localColumn != null) && !_localColumn.getName().equals(localColumnName)) {
            _localColumn = null;
        }
        _localColumnName = localColumnName;
    }

    /**
     * Returns the name of the foreign column.
     *
     * @return The column name
     */
    public String getForeignColumnName() {
        return _foreignColumnName;
    }

    /**
     * Sets the name of the remote column. Note that you should not use this method when
     * manipulating the model manually. Rather use the {@link #setForeignColumn(Column)} method.
     *
     * @param foreignColumnName The column name
     */
    public void setForeignColumnName(String foreignColumnName) {
        if ((_foreignColumn != null) && !_foreignColumn.getName().equals(foreignColumnName)) {
            _foreignColumn = null;
        }
        _foreignColumnName = foreignColumnName;
    }

    /**
     * Compares this reference to the given one while ignoring the case of identifiers.
     *
     * @param otherRef The other reference
     * @return <code>true</code> if this reference is equal (ignoring case) to the given one
     */
    public boolean equalsIgnoreCase(Reference otherRef) {
        return (otherRef != null) && _localColumnName.equalsIgnoreCase(otherRef._localColumnName) && _foreignColumnName.equalsIgnoreCase(otherRef._foreignColumnName);
    }

    @Override
    public String toString() {
        return getLocalColumnName() + " -> " + getForeignColumnName();
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Reference reference = (Reference) o;
        return Objects.equals(_localColumn, reference._localColumn) && Objects.equals(_foreignColumn, reference._foreignColumn) && Objects.equals(_localColumnName, reference._localColumnName) && Objects.equals(_foreignColumnName, reference._foreignColumnName);
    }

    @Override
    public int hashCode() {
        return Objects.hash(_localColumn, _foreignColumn, _localColumnName, _foreignColumnName);
    }
}
