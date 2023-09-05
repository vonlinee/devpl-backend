package org.apache.ddlutils.io;

import org.apache.ddlutils.dynabean.DynaBean;
import org.apache.ddlutils.io.converters.SqlTypeConverter;
import org.apache.ddlutils.model.Column;
import org.apache.ddlutils.model.Database;
import org.apache.ddlutils.model.Table;
import org.apache.ddlutils.util.Base64;
import org.apache.ddlutils.util.ValueMap;
import org.apache.ddlutils.util.bean.PropertyUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.xml.sax.InputSource;

import javax.xml.namespace.QName;
import javax.xml.stream.Location;
import javax.xml.stream.XMLInputFactory;
import javax.xml.stream.XMLStreamException;
import javax.xml.stream.XMLStreamReader;
import java.io.*;
import java.lang.reflect.InvocationTargetException;

/**
 * Reads data XML into dyna beans matching a specified database model. Note that
 * the data sink won't be started or ended by the data reader, this has to be done
 * in the code that uses the data reader.
 */
public class DataReader {
    /**
     * Our log.
     */
    private final Logger _log = LoggerFactory.getLogger(DataReader.class);

    /**
     * The database model.
     */
    private Database _model;
    /**
     * The object to receive the read beans.
     */
    private DataSink _sink;
    /**
     * The converters.
     */
    private final ConverterConfiguration _converterConf = new ConverterConfiguration();
    /**
     * Whether to be case-sensitive or not.
     */
    private boolean _caseSensitive = false;

    /**
     * Returns the converter configuration of this data reader.
     * @return The converter configuration
     */
    public ConverterConfiguration getConverterConfiguration() {
        return _converterConf;
    }

    /**
     * Returns the database model.
     * @return The model
     */
    public Database getModel() {
        return _model;
    }

    /**
     * Sets the database model.
     * @param model The model
     */
    public void setModel(Database model) {
        _model = model;
    }

    /**
     * Returns the data sink.
     * @return The sink
     */
    public DataSink getSink() {
        return _sink;
    }

    /**
     * Sets the data sink.
     * @param sink The sink
     */
    public void setSink(DataSink sink) {
        _sink = sink;
    }

    /**
     * Determines whether this rules object matches case-sensitively.
     * @return <code>true</code> if the case of the pattern matters
     */
    public boolean isCaseSensitive() {
        return _caseSensitive;
    }


    /**
     * Specifies whether this rules object shall match case-sensitively.
     * @param beCaseSensitive <code>true</code> if the case of the pattern shall matter
     */
    public void setCaseSensitive(boolean beCaseSensitive) {
        _caseSensitive = beCaseSensitive;
    }

    /**
     * Creates a new, initialized XML input factory object.
     * @return The factory object
     */
    private XMLInputFactory getXMLInputFactory() {
        XMLInputFactory factory = XMLInputFactory.newInstance();

        factory.setProperty("javax.xml.stream.isCoalescing", Boolean.TRUE);
        factory.setProperty("javax.xml.stream.isNamespaceAware", Boolean.FALSE);
        return factory;
    }

    /**
     * Reads the data contained in the specified file.
     * @param filename The data file name
     */
    public void read(String filename) throws DdlUtilsXMLException {
        read(new File(filename));
    }

    /**
     * Reads the data contained in the specified file.
     * @param file The data file
     */
    public void read(File file) throws DdlUtilsXMLException {
        FileInputStream input = null;

        try {
            input = new FileInputStream(file);
            read(input);
        } catch (IOException ex) {
            throw new DdlUtilsXMLException(ex);
        } finally {
            if (input != null) {
                try {
                    input.close();
                } catch (IOException ex) {
                    _log.warn("Error while trying to close the input stream for " + file, ex);
                }
            }
        }
    }

    /**
     * Reads the data given by the reader.
     * @param reader The reader that returns the data XML
     */
    public void read(Reader reader) throws DdlUtilsXMLException {
        BufferedReader bufferedReader;

        if (reader instanceof BufferedReader) {
            bufferedReader = (BufferedReader) reader;
        } else {
            bufferedReader = new BufferedReader(reader);
        }
        try {
            read(getXMLInputFactory().createXMLStreamReader(bufferedReader));
        } catch (XMLStreamException ex) {
            throw new DdlUtilsXMLException(ex);
        }
    }

    /**
     * Reads the data given by the input stream.
     * @param input The input stream that returns the data XML
     */
    public void read(InputStream input) throws DdlUtilsXMLException {
        BufferedInputStream bufferedInput;

        if (input instanceof BufferedInputStream) {
            bufferedInput = (BufferedInputStream) input;
        } else {
            bufferedInput = new BufferedInputStream(input);
        }
        try {
            read(getXMLInputFactory().createXMLStreamReader(bufferedInput));
        } catch (XMLStreamException ex) {
            throw new DdlUtilsXMLException(ex);
        }
    }

    /**
     * Reads the data from the given input source.
     * @param source The input source
     */
    public void read(InputSource source) throws DdlUtilsXMLException {
        read(source.getCharacterStream());
    }

    /**
     * Reads the data from the given XML stream reader.
     * @param xmlReader The reader
     */
    private void read(XMLStreamReader xmlReader) throws DdlUtilsXMLException {
        try {
            while (xmlReader.getEventType() != XMLStreamReader.START_ELEMENT) {
                if (xmlReader.next() == XMLStreamReader.END_DOCUMENT) {
                    return;
                }
            }
            readDocument(xmlReader);
        } catch (XMLStreamException ex) {
            throw new DdlUtilsXMLException(ex);
        }
    }

    // TODO: add debug level logging (or trace ?)

    /**
     * Reads the xml document from the given xml stream reader.
     * @param xmlReader The reader
     */
    private void readDocument(XMLStreamReader xmlReader) throws XMLStreamException, DdlUtilsXMLException {
        // we ignore the top-level tag since we don't know about its name
        int eventType = XMLStreamReader.START_ELEMENT;

        while (eventType != XMLStreamReader.END_ELEMENT) {
            eventType = xmlReader.next();
            if (eventType == XMLStreamReader.START_ELEMENT) {
                readBean(xmlReader);
            }
        }
    }

    /**
     * Reads a bean from the given xml stream reader.
     * @param xmlReader The reader
     */
    private void readBean(XMLStreamReader xmlReader) throws XMLStreamException, DdlUtilsXMLException {
        QName elemQName = xmlReader.getName();
        Location location = xmlReader.getLocation();
        ValueMap attributes = new ValueMap();
        String tableName;

        for (int idx = 0; idx < xmlReader.getAttributeCount(); idx++) {
            QName attrQName = xmlReader.getAttributeName(idx);

            attributes.put(isCaseSensitive() ? attrQName.getLocalPart() : attrQName.getLocalPart().toLowerCase(),
                xmlReader.getAttributeValue(idx));
        }
        readColumnSubElements(xmlReader, attributes);

        if ("table".equals(elemQName.getLocalPart())) {
            tableName = (String) attributes.get("table-name");
        } else {
            tableName = elemQName.getLocalPart();
        }

        Table table = _model.findTable(tableName, isCaseSensitive());

        if (table == null) {
            _log.warn("Data XML contains an element " + elemQName + " at location " + location +
                " but there is no table defined with this name. This element will be ignored.");
        } else {
            DynaBean bean = _model.createDynaBeanFor(table);

            for (int idx = 0; idx < table.getColumnCount(); idx++) {
                Column column = table.getColumn(idx);
                String value = (String) attributes.get(isCaseSensitive() ? column.getName() : column.getName()
                    .toLowerCase());

                if (value != null) {
                    setColumnValue(bean, table, column, value);
                }
            }
            getSink().addBean(bean);
            consumeRestOfElement(xmlReader);
        }
    }

    /**
     * Reads all relevant sub elements that match the columns specified by the given table object from the xml reader into the given bean.
     * @param xmlReader The reader
     * @param data      Where to store the values
     */
    private void readColumnSubElements(XMLStreamReader xmlReader, ValueMap data) throws XMLStreamException, DdlUtilsXMLException {
        int eventType = XMLStreamReader.START_ELEMENT;

        while (eventType != XMLStreamReader.END_ELEMENT) {
            eventType = xmlReader.next();
            if (eventType == XMLStreamReader.START_ELEMENT) {
                readColumnSubElement(xmlReader, data);
            }
        }
    }

    /**
     * Reads the next column sub element that matches a column specified by the given table object from the xml reader into the given bean.
     * @param xmlReader The reader
     * @param data      Where to store the values
     */
    private void readColumnSubElement(XMLStreamReader xmlReader, ValueMap data) throws XMLStreamException, DdlUtilsXMLException {
        QName elemQName = xmlReader.getName();
        ValueMap attributes = new ValueMap();
        boolean usesBase64 = false;

        for (int idx = 0; idx < xmlReader.getAttributeCount(); idx++) {
            QName attrQName = xmlReader.getAttributeName(idx);
            String value = xmlReader.getAttributeValue(idx);

            if (DatabaseIO.BASE64_ATTR_NAME.equals(attrQName.getLocalPart())) {
                if ("true".equalsIgnoreCase(value)) {
                    usesBase64 = true;
                }
            } else {
                attributes.put(attrQName.getLocalPart(), value);
            }
        }

        int eventType = XMLStreamReader.START_ELEMENT;
        StringBuilder content = new StringBuilder();

        while (eventType != XMLStreamReader.END_ELEMENT) {
            eventType = xmlReader.next();
            if (eventType == XMLStreamReader.START_ELEMENT) {
                readColumnDataSubElement(xmlReader, attributes);
            } else if ((eventType == XMLStreamReader.CHARACTERS) ||
                (eventType == XMLStreamReader.CDATA) ||
                (eventType == XMLStreamReader.SPACE) ||
                (eventType == XMLStreamReader.ENTITY_REFERENCE)) {
                content.append(xmlReader.getText());
            }
        }

        String value = content.toString().trim();

        if (usesBase64) {
            value = new String(Base64.decodeBase64(value.getBytes()));
        }

        String name = elemQName.getLocalPart();

        if ("table-name".equals(name)) {
            data.put("table-name", value);
        } else {
            if ("column".equals(name)) {
                name = (String) attributes.get("column-name");
            }
            if (attributes.containsKey("column-value")) {
                value = (String) attributes.get("column-value");
            }
            data.put(name, value);
        }
        consumeRestOfElement(xmlReader);
    }


    /**
     * Reads the next column-name or column-value sub element.
     * @param xmlReader The reader
     * @param data      Where to store the values
     */
    private void readColumnDataSubElement(XMLStreamReader xmlReader, ValueMap data) throws XMLStreamException, DdlUtilsXMLException {
        QName elemQName = xmlReader.getName();
        boolean usesBase64 = false;

        for (int idx = 0; idx < xmlReader.getAttributeCount(); idx++) {
            QName attrQName = xmlReader.getAttributeName(idx);
            String value = xmlReader.getAttributeValue(idx);

            if (DatabaseIO.BASE64_ATTR_NAME.equals(attrQName.getLocalPart())) {
                if ("true".equalsIgnoreCase(value)) {
                    usesBase64 = true;
                }
                break;
            }
        }

        String value = xmlReader.getElementText();

        if (value != null) {
            value = value.trim();

            if (usesBase64) {
                value = new String(Base64.decodeBase64(value.getBytes()));
            }
        }

        String name = elemQName.getLocalPart();

        if ("column-name".equals(name)) {
            data.put("column-name", value);
        } else if ("column-value".equals(name)) {
            data.put("column-value", value);
        }
        consumeRestOfElement(xmlReader);
    }

    /**
     * Converts the column value read from the XML stream to an object and sets it at the given bean.
     * @param bean   The bean
     * @param table  The table definition
     * @param column The column definition
     * @param value  The value as a string
     */
    private void setColumnValue(DynaBean bean, Table table, Column column, String value) throws DdlUtilsXMLException {
        SqlTypeConverter converter = _converterConf.getRegisteredConverter(table, column);
        Object propValue = (converter != null ? converter.convertFromString(value, column.getJdbcTypeCode()) : value);

        try {
            PropertyUtils.setProperty(bean, column.getName(), propValue);
        } catch (NoSuchMethodException ex) {
            throw new DdlUtilsXMLException("Undefined column " + column.getName());
        } catch (IllegalAccessException | InvocationTargetException ex) {
            throw new DdlUtilsXMLException("Could not set bean property for column " + column.getName(), ex);
        }
    }

    /**
     * Consumes the rest of the current element. This assumes that the current XML stream
     * event type is not START_ELEMENT.
     * @param reader The xml reader
     */
    private void consumeRestOfElement(XMLStreamReader reader) throws XMLStreamException {
        int eventType = reader.getEventType();

        while ((eventType != XMLStreamReader.END_ELEMENT) && (eventType != XMLStreamReader.END_DOCUMENT)) {
            eventType = reader.next();
        }
    }
}