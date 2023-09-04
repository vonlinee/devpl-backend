package org.apache.ddlutils.io;

import org.apache.ddlutils.DatabasePlatform;
import org.apache.ddlutils.DdlUtilsException;
import org.apache.ddlutils.model.Column;
import org.apache.ddlutils.model.Database;
import org.apache.ddlutils.model.Table;
import org.apache.ddlutils.util.ListOrderedMap;

import java.io.*;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.*;

/**
 * Provides basic live database data <-> XML functionality.
 * @version $Revision: $
 */
public class DatabaseDataIO {
    /**
     * The converters to use for converting between data and its XML representation.
     */
    private final ArrayList<DataConverterRegistration> _converters = new ArrayList<>();
    /**
     * Whether we should continue when an error was detected.
     */
    private boolean _failOnError = true;
    /**
     * Whether foreign key order shall be followed when inserting data into the database.
     */
    private boolean _ensureFKOrder = true;
    /**
     * Whether we should use batch mode.
     */
    private boolean _useBatchMode;
    /**
     * The maximum number of objects to insert in one batch.
     */
    private Integer _batchSize;

    /**
     * Whether DdlUtils should search for the schema of the tables. @deprecated
     */
    private boolean _determineSchema;
    /**
     * The schema pattern for finding tables when reading data from a live database. @deprecated
     */
    private String _schemaPattern;

    /**
     * Registers a converter.
     * @param converterRegistration The registration info
     */
    public void registerConverter(DataConverterRegistration converterRegistration) {
        _converters.add(converterRegistration);
    }

    /**
     * Determines whether data io is stopped when an error happens.
     * @return Whether io is stopped when an error was detected (true by default)
     */
    public boolean isFailOnError() {
        return _failOnError;
    }

    /**
     * Specifies whether data io shall be stopped when an error happens.
     * @param failOnError Whether io should stop when an error was detected
     */
    public void setFailOnError(boolean failOnError) {
        _failOnError = failOnError;
    }

    /**
     * Determines whether batch mode is used for inserting data into the database.
     * @return <code>true</code> if batch mode is used
     */
    public boolean getUseBatchMode() {
        return _useBatchMode;
    }

    /**
     * Specifies whether batch mode should be used for inserting data into the database.
     * @param useBatchMode <code>true</code> if batch mode shall be used
     */
    public void setUseBatchMode(boolean useBatchMode) {
        _useBatchMode = useBatchMode;
    }

    /**
     * Returns the batch size override.
     * @return The batch size if different from the default, <code>null</code> otherwise
     */
    public Integer getBatchSize() {
        return _batchSize;
    }

    /**
     * Sets the batch size to be used by this object.
     * @param batchSize The batch size if different from the default, or <code>null</code> if
     *                  the default shall be used
     */
    public void setBatchSize(Integer batchSize) {
        _batchSize = batchSize;
    }

    /**
     * Determines whether the sink delays the insertion of beans so that the beans referenced by it
     * via foreignkeys are already inserted into the database.
     * @return <code>true</code> if beans are inserted after its foreignkey-references
     */
    public boolean isEnsureFKOrder() {
        return _ensureFKOrder;
    }

    /**
     * Specifies whether the sink shall delay the insertion of beans so that the beans referenced by it
     * via foreignkeys are already inserted into the database.<br/>
     * Note that you should careful with setting <code>haltOnErrors</code> to false as this might
     * result in beans not inserted at all. The sink will then throw an appropriate exception at the end
     * of the insertion process (method {@link DataSink#end()}).
     * @param ensureFKOrder <code>true</code> if beans shall be inserted after its foreignkey-references
     */
    public void setEnsureFKOrder(boolean ensureFKOrder) {
        _ensureFKOrder = ensureFKOrder;
    }

    /**
     * Specifies whether DdlUtils should try to find the schema of the tables when reading data
     * from a live database.
     * @param determineSchema Whether to try to find the table's schemas
     * @deprecated Will be removed once proper schema support is in place
     */
    public void setDetermineSchema(boolean determineSchema) {
        _determineSchema = determineSchema;
    }

    /**
     * Sets the schema pattern to find the schemas of tables when reading data from a live database.
     * @param schemaPattern The schema pattern
     * @deprecated Will be removed once proper schema support is in place
     */
    public void setSchemaPattern(String schemaPattern) {
        _schemaPattern = schemaPattern;
    }

    /**
     * Registers the converters at the given configuration.
     * @param converterConf The converter configuration
     */
    private void registerConverters(ConverterConfiguration converterConf) throws DdlUtilsException {
        for (Iterator it = _converters.iterator(); it.hasNext(); ) {
            DataConverterRegistration registrationInfo = (DataConverterRegistration) it.next();

            if (registrationInfo.getTypeCode() != Integer.MIN_VALUE) {
                converterConf.registerConverter(registrationInfo.getTypeCode(), registrationInfo.getConverter());
            } else {
                if ((registrationInfo.getTable() == null) || (registrationInfo.getColumn() == null)) {
                    throw new DdlUtilsException("Please specify either the jdbc type or a table/column pair for which the converter shall be defined");
                }
                converterConf.registerConverter(registrationInfo.getTable(), registrationInfo.getColumn(), registrationInfo.getConverter());
            }
        }
    }

    /**
     * Returns a data writer instance configured to write to the indicated file
     * in the specified encoding.
     * @param path        The path to the output XML data file
     * @param xmlEncoding The encoding to use for writing the XML
     * @return The writer
     */
    public DataWriter getConfiguredDataWriter(String path, String xmlEncoding) throws DdlUtilsException {
        try {
            DataWriter writer = new DataWriter(new FileOutputStream(path), xmlEncoding);

            registerConverters(writer.getConverterConfiguration());
            return writer;
        } catch (IOException ex) {
            throw new DdlUtilsException(ex);
        }
    }

    /**
     * Returns a data writer instance configured to write to the given output stream
     * in the specified encoding.
     * @param output      The output stream
     * @param xmlEncoding The encoding to use for writing the XML
     * @return The writer
     */
    public DataWriter getConfiguredDataWriter(OutputStream output, String xmlEncoding) throws DdlUtilsException {
        DataWriter writer = new DataWriter(output, xmlEncoding);

        registerConverters(writer.getConverterConfiguration());
        return writer;
    }

    /**
     * Returns a data writer instance configured to write to the given output writer
     * in the specified encoding.
     * @param output      The output writer; needs to be configured with the specified encoding
     * @param xmlEncoding The encoding to use for writing the XML
     * @return The writer
     */
    public DataWriter getConfiguredDataWriter(Writer output, String xmlEncoding) throws DdlUtilsException {
        DataWriter writer = new DataWriter(output, xmlEncoding);

        registerConverters(writer.getConverterConfiguration());
        return writer;
    }

    /**
     * Writes the data contained in the database to which the given platform is connected, as XML
     * to the given output stream (which won't be closed by this method).
     * @param platform    The platform; needs to be connected to a live database
     * @param path        The path of the output file
     * @param xmlEncoding The encoding to use for the XML
     */
    public void writeDataToXML(DatabasePlatform platform, String path, String xmlEncoding) throws DdlUtilsException {
        writeDataToXML(platform, getConfiguredDataWriter(path, xmlEncoding));
    }

    /**
     * Writes the data contained in the database to which the given platform is connected, as XML
     * to the given output stream (which won't be closed by this method).
     * @param platform    The platform; needs to be connected to a live database
     * @param model       The model for which to retrieve and write the data
     * @param path        The path of the output file
     * @param xmlEncoding The encoding to use for the XML
     */
    public void writeDataToXML(DatabasePlatform platform, Database model, String path, String xmlEncoding) {
        writeDataToXML(platform, model, getConfiguredDataWriter(path, xmlEncoding));
    }

    /**
     * Writes the data contained in the database to which the given platform is connected, as XML
     * to the given output stream (which won't be closed by this method).
     * @param platform    The platform; needs to be connected to a live database
     * @param output      The output stream
     * @param xmlEncoding The encoding to use for the XML
     */
    public void writeDataToXML(DatabasePlatform platform, OutputStream output, String xmlEncoding) {
        writeDataToXML(platform, getConfiguredDataWriter(output, xmlEncoding));
    }

    /**
     * Writes the data contained in the database to which the given platform is connected, as XML
     * to the given output stream (which won't be closed by this method).
     * @param platform    The platform; needs to be connected to a live database
     * @param model       The model for which to retrieve and write the data
     * @param output      The output stream
     * @param xmlEncoding The encoding to use for the XML
     */
    public void writeDataToXML(DatabasePlatform platform, Database model, OutputStream output, String xmlEncoding) {
        writeDataToXML(platform, model, getConfiguredDataWriter(output, xmlEncoding));
    }

    /**
     * Writes the data contained in the database to which the given platform is connected, as XML
     * to the given output writer (which won't be closed by this method).
     * @param platform    The platform; needs to be connected to a live database
     * @param output      The output writer (which needs to be openend with the specified encoding)
     * @param xmlEncoding The encoding to use for the XML
     */
    public void writeDataToXML(DatabasePlatform platform, Writer output, String xmlEncoding) {
        writeDataToXML(platform, getConfiguredDataWriter(output, xmlEncoding));
    }

    /**
     * Writes the data contained in the database to which the given platform is connected, as XML
     * to the given output writer (which won't be closed by this method).
     * @param platform    The platform; needs to be connected to a live database
     * @param model       The model for which to retrieve and write the data
     * @param output      The output writer (which needs to be openend with the specified encoding)
     * @param xmlEncoding The encoding to use for the XML
     */
    public void writeDataToXML(DatabasePlatform platform, Database model, Writer output, String xmlEncoding) {
        writeDataToXML(platform, model, getConfiguredDataWriter(output, xmlEncoding));
    }

    /**
     * Writes the data contained in the database to which the given platform is connected, as XML
     * to the given data writer.
     * @param platform The platform; needs to be connected to a live database
     * @param writer   The data writer
     */
    public void writeDataToXML(DatabasePlatform platform, DataWriter writer) {
        writeDataToXML(platform, platform.readModelFromDatabase("unnamed"), writer);
    }

    /**
     * Writes the data contained in the database to which the given platform is connected, as XML
     * to the given data writer.
     * @param platform The platform; needs to be connected to a live database
     * @param model    The model for which to retrieve and write the data
     * @param writer   The data writer
     */
    public void writeDataToXML(DatabasePlatform platform, Database model, DataWriter writer) {
        registerConverters(writer.getConverterConfiguration());

        // TODO: An advanced algorithm could be employed here that writes individual
        //       objects related by foreign keys, in the correct order
        List<Table> tables = sortTables(model.getTables());

        writer.writeDocumentStart();
        for (Table table : tables) {
            writeDataForTableToXML(platform, model, table, writer);
        }
        writer.writeDocumentEnd();
    }

    /**
     * Sorts the given table according to their foreign key order.
     * @param tables The tables
     * @return The sorted tables
     */
    private List<Table> sortTables(Table[] tables) {
        List<Table> result = new ArrayList<>();
        Set<Table> processed = new HashSet<>();
        ListOrderedMap<Table, Set<Table>> pending = new ListOrderedMap<>();

        for (Table table : tables) {
            if (table.getForeignKeyCount() == 0) {
                result.add(table);
                processed.add(table);
            } else {
                Set<Table> waitedFor = new HashSet<>();

                for (int fkIdx = 0; fkIdx < table.getForeignKeyCount(); fkIdx++) {
                    Table waitedForTable = table.getForeignKey(fkIdx).getForeignTable();

                    if (!table.equals(waitedForTable)) {
                        waitedFor.add(waitedForTable);
                    }
                }
                pending.put(table, waitedFor);
            }
        }

        Set<Table> newProcessed = new HashSet<>();

        while (!processed.isEmpty() && !pending.isEmpty()) {
            for (Iterator<Map.Entry<Table, Set<Table>>> it = pending.entrySet().iterator(); it.hasNext(); ) {
                Map.Entry<Table, Set<Table>> entry = it.next();
                Table table = entry.getKey();
                HashSet<Table> waitedFor = (HashSet<Table>) entry.getValue();

                waitedFor.removeAll(processed);
                if (waitedFor.isEmpty()) {
                    it.remove();
                    result.add(table);
                    newProcessed.add(table);
                }
            }
            processed.clear();

            Set<Table> tmp = processed;

            processed = newProcessed;
            newProcessed = tmp;
        }
        // the remaining are within circular dependencies
        result.addAll(pending.keySet());
        return result;
    }

    /**
     * Writes the data contained in a single table to XML.
     * @param platform The platform
     * @param model    The database model
     * @param table    The table
     * @param writer   The data writer
     */
    private void writeDataForTableToXML(DatabasePlatform platform, Database model, Table table, DataWriter writer) {
        Table[] tables = {table};
        StringBuilder query = new StringBuilder();

        query.append("SELECT ");

        Connection connection = null;
        String schema = null;

        if (_determineSchema) {
            try {
                // TODO: Remove this once we have full support for schemas
                connection = platform.borrowConnection();
                schema = platform.getModelReader().determineSchemaOf(connection, _schemaPattern, tables[0]);
            } catch (SQLException ex) {
                // ignored
            } finally {
                if (connection != null) {
                    try {
                        connection.close();
                    } catch (SQLException ex) {
                        // ignored
                    }
                }
            }
        }

        Column[] columns = tables[0].getColumns();

        for (int columnIdx = 0; columnIdx < columns.length; columnIdx++) {
            if (columnIdx > 0) {
                query.append(",");
            }
            if (platform.isDelimitedIdentifierModeOn()) {
                query.append(platform.getPlatformInfo().getDelimiterToken());
            }
            query.append(columns[columnIdx].getName());
            if (platform.isDelimitedIdentifierModeOn()) {
                query.append(platform.getPlatformInfo().getDelimiterToken());
            }
        }
        query.append(" FROM ");
        if (platform.isDelimitedIdentifierModeOn()) {
            query.append(platform.getPlatformInfo().getDelimiterToken());
        }
        if (schema != null) {
            query.append(schema);
            query.append(".");
        }
        query.append(tables[0].getName());
        if (platform.isDelimitedIdentifierModeOn()) {
            query.append(platform.getPlatformInfo().getDelimiterToken());
        }

        writer.write(platform.query(model, query.toString(), tables));
    }

    /**
     * Returns a data reader instance configured for the given platform (which needs to
     * be connected to a live database) and model.
     * @param platform The database
     * @param model    The model
     * @return The data reader
     */
    public DataReader getConfiguredDataReader(DatabasePlatform platform, Database model) throws DdlUtilsException {
        DataToDatabaseSink sink = new DataToDatabaseSink(platform, model);
        DataReader reader = new DataReader();

        sink.setHaltOnErrors(_failOnError);
        sink.setEnsureForeignKeyOrder(_ensureFKOrder);
        sink.setUseBatchMode(_useBatchMode);
        if (_batchSize != null) {
            sink.setBatchSize(_batchSize);
        }

        reader.setModel(model);
        reader.setSink(sink);
        registerConverters(reader.getConverterConfiguration());
        return reader;
    }

    /**
     * Reads the data from the specified files and writes it to the database to which the given
     * platform is connected.
     * @param platform The platform, must be connected to a live database
     * @param files    The XML data files
     */
    public void writeDataToDatabase(DatabasePlatform platform, String[] files) throws DdlUtilsException {
        writeDataToDatabase(platform, platform.readModelFromDatabase("unnamed"), files);
    }

    /**
     * Reads the data from the given input streams and writes it to the database to which the given
     * platform is connected.
     * @param platform The platform, must be connected to a live database
     * @param inputs   The input streams for the XML data
     */
    public void writeDataToDatabase(DatabasePlatform platform, InputStream[] inputs) throws DdlUtilsException {
        writeDataToDatabase(platform, platform.readModelFromDatabase("unnamed"), inputs);
    }

    /**
     * Reads the data from the given input readers and writes it to the database to which the given
     * platform is connected.
     * @param platform The platform, must be connected to a live database
     * @param inputs   The input readers for the XML data
     */
    public void writeDataToDatabase(DatabasePlatform platform, Reader[] inputs) throws DdlUtilsException {
        writeDataToDatabase(platform, platform.readModelFromDatabase("unnamed"), inputs);
    }

    /**
     * Reads the data from the indicated files and writes it to the database to which the given
     * platform is connected. Only data that matches the given model will be written.
     * @param platform The platform, must be connected to a live database
     * @param model    The model to which to constrain the written data
     * @param files    The XML data files
     */
    public void writeDataToDatabase(DatabasePlatform platform, Database model, String[] files) throws DdlUtilsException {
        DataReader dataReader = getConfiguredDataReader(platform, model);

        dataReader.getSink().start();
        for (int idx = 0; (files != null) && (idx < files.length); idx++) {
            writeDataToDatabase(dataReader, files[idx]);
        }
        dataReader.getSink().end();
    }

    /**
     * Reads the data from the given input streams and writes it to the database to which the given
     * platform is connected. Only data that matches the given model will be written.
     * @param platform The platform, must be connected to a live database
     * @param model    The model to which to constrain the written data
     * @param inputs   The input streams for the XML data
     */
    public void writeDataToDatabase(DatabasePlatform platform, Database model, InputStream[] inputs) throws DdlUtilsException {
        DataReader dataReader = getConfiguredDataReader(platform, model);

        dataReader.getSink().start();
        for (int idx = 0; (inputs != null) && (idx < inputs.length); idx++) {
            writeDataToDatabase(dataReader, inputs[idx]);
        }
        dataReader.getSink().end();
    }

    /**
     * Reads the data from the given input readers and writes it to the database to which the given
     * platform is connected. Only data that matches the given model will be written.
     * @param platform The platform, must be connected to a live database
     * @param model    The model to which to constrain the written data
     * @param inputs   The input readers for the XML data
     */
    public void writeDataToDatabase(DatabasePlatform platform, Database model, Reader[] inputs) throws DdlUtilsException {
        DataReader dataReader = getConfiguredDataReader(platform, model);

        dataReader.getSink().start();
        for (int idx = 0; (inputs != null) && (idx < inputs.length); idx++) {
            writeDataToDatabase(dataReader, inputs[idx]);
        }
        dataReader.getSink().end();
    }

    /**
     * Reads the data from the specified files and writes it to the database via the given data reader.
     * Note that the sink that the data reader is configured with, won't be started or ended by
     * this method. This has to be done by the code using this method.
     * @param dataReader The data reader
     * @param files      The XML data files
     */
    public void writeDataToDatabase(DataReader dataReader, String[] files) throws DdlUtilsException {
        for (int idx = 0; (files != null) && (idx < files.length); idx++) {
            writeDataToDatabase(dataReader, files[idx]);
        }
    }

    /**
     * Reads the data from the given input stream and writes it to the database via the given data reader.
     * Note that the input stream won't be closed by this method. Note also that the sink that the data
     * reader is configured with, won't be started or ended by this method. This has to be done by the
     * code using this method.
     * @param dataReader The data reader
     * @param inputs     The input streams for the XML data
     */
    public void writeDataToDatabase(DataReader dataReader, InputStream[] inputs) throws DdlUtilsException {
        for (int idx = 0; (inputs != null) && (idx < inputs.length); idx++) {
            writeDataToDatabase(dataReader, inputs[idx]);
        }
    }

    /**
     * Reads the data from the given input stream and writes it to the database via the given data reader.
     * Note that the input stream won't be closed by this method. Note also that the sink that the data
     * reader is configured with, won't be started or ended by this method. This has to be done by the
     * code using this method.
     * @param dataReader The data reader
     * @param inputs     The input readers for the XML data
     */
    public void writeDataToDatabase(DataReader dataReader, Reader[] inputs) throws DdlUtilsException {
        for (int idx = 0; (inputs != null) && (idx < inputs.length); idx++) {
            writeDataToDatabase(dataReader, inputs[idx]);
        }
    }

    /**
     * Reads the data from the indicated XML file and writes it to the database via the given data reader.
     * Note that the sink that the data reader is configured with, won't be started or ended by this method.
     * This has to be done by the code using this method.
     * @param dataReader The data reader
     * @param path       The path to the XML data file
     */
    public void writeDataToDatabase(DataReader dataReader, String path) throws DdlUtilsException {
        try {
            dataReader.read(path);
        } catch (Exception ex) {
            throw new DdlUtilsException(ex);
        }
    }

    /**
     * Reads the data from the given input stream and writes it to the database via the given data reader.
     * Note that the input stream won't be closed by this method. Note also that the sink that the data
     * reader is configured with, won't be started or ended by this method. This has to be done by the
     * code using this method.
     * @param dataReader The data reader
     * @param input      The input stream for the XML data
     */
    public void writeDataToDatabase(DataReader dataReader, InputStream input) throws DdlUtilsException {
        try {
            dataReader.read(input);
        } catch (Exception ex) {
            throw new DdlUtilsException(ex);
        }
    }

    /**
     * Reads the data from the given input stream and writes it to the database via the given data reader.
     * Note that the input stream won't be closed by this method. Note also that the sink that the data
     * reader is configured with, won't be started or ended by this method. This has to be done by the
     * code using this method.
     * @param dataReader The data reader
     * @param input      The input reader for the XML data
     */
    public void writeDataToDatabase(DataReader dataReader, Reader input) throws DdlUtilsException {
        try {
            dataReader.read(input);
        } catch (Exception ex) {
            throw new DdlUtilsException(ex);
        }
    }
}
