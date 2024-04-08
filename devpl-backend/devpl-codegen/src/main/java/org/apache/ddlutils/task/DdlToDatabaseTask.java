package org.apache.ddlutils.task;


import org.apache.ddlutils.io.DatabaseIO;
import org.apache.ddlutils.model.Database;
import org.apache.tools.ant.BuildException;
import org.apache.tools.ant.DirectoryScanner;
import org.apache.tools.ant.types.FileSet;

import java.io.File;
import java.util.ArrayList;

/**
 * Task for performing operations on a live database. Sub-tasks e.g. create the
 * schema in the database, drop database schemas, insert data into the database,
 * create DTDs for data files, or write the SQL for creating a schema to a file.
 * <br/>
 * Example:<br/>
 * <pre>
 * &lt;taskdef classname="org.apache.ddlutils.task.DdlToDatabaseTask"
 *          name="ddlToDatabase"
 *          classpathRef="project-classpath"/&gt;
 *
 * &lt;ddlToDatabase useDelimitedSqlIdentifiers="true"&gt;
 *   &lt;database driverClassName="org.apache.derby.jdbc.ClientDriver"
 *             url="jdbc:derby://localhost/ddlutils"
 *             username="ddlutils"
 *             password="ddlutils"/&gt;
 *   &lt;fileset dir="."&gt;
 *     &lt;include name="*schema.xml"/&gt;
 *   &lt;/fileset&gt;
 *
 *   &lt;createDatabase failOnError="false"/&gt;
 *   &lt;writeSchemaToDatabase alterDatabase="true"
 *                          failOnError="false"/&gt;
 *   &lt;writeDataToDatabase dataFile="data.xml"
 *                        useBatchMode="true"
 *                        batchSize="1000"/&gt;
 * &lt;/ddlToDatabase&gt;
 * </pre>
 * This Ant build file snippet essentially creates a database, creates tables, foreign keys
 * etc. int it and then writes data into the newly created tables.
 *
 * @ant.task name="ddlToDatabase"
 */
public class DdlToDatabaseTask extends DatabaseTaskBase {
    /**
     * The input files.
     */
    private final ArrayList<FileSet> _fileSets = new ArrayList<>();
    /**
     * A single schema file to read.
     */
    private File _singleSchemaFile = null;
    /**
     * Whether XML input files are validated against the internal or an external DTD.
     */
    private boolean _useInternalDtd = true;
    /**
     * Whether XML input files are validated at all.
     */
    private boolean _validateXml = false;

    /**
     * Specifies whether DdlUtils shall use the embedded DTD for validating the schema XML (if
     * it matches <code>http://db.apache.org/torque/dtd/database.dtd</code>). This is
     * especially useful in environments where no web access is possible or desired.
     *
     * @param useInternalDtd <code>true</code> if input files are to be validated against the internal DTD
     *                       Default is <code>true</code>.
     */
    public void setUseInternalDtd(boolean useInternalDtd) {
        _useInternalDtd = useInternalDtd;
    }

    /**
     * Specifies whether XML input files should be validated against the DTD at all.
     *
     * @param validateXml <code>true</code> if input files are to be validated
     *                    Default is <code>false</code> meaning that the XML is not validated at all.
     */
    public void setValidateXml(boolean validateXml) {
        _validateXml = validateXml;
    }

    /**
     * Adds a fileset.
     *
     * @param fileset The additional input files
     */
    public void addConfiguredFileset(FileSet fileset) {
        _fileSets.add(fileset);
    }

    /**
     * Defines the single file that contains the database file. You can use this instead of embedded
     * <code>fileset</code> elements if you only have one schema file.
     *
     * @param schemaFile The schema
     *                   Use either this or one or more embedded fileset elements.
     */
    public void setSchemaFile(File schemaFile) {
        _singleSchemaFile = schemaFile;
    }

    /**
     * Adds the "create database"-command.
     *
     * @param command The command
     */
    public void addCreateDatabase(CreateDatabaseCommand command) {
        addCommand(command);
    }

    /**
     * Adds the "drop database"-command.
     *
     * @param command The command
     */
    public void addDropDatabase(DropDatabaseCommand command) {
        addCommand(command);
    }

    /**
     * Adds the "write dtd to file"-command.
     *
     * @param command The command
     */
    public void addWriteDtdToFile(WriteDtdToFileCommand command) {
        addCommand(command);
    }

    /**
     * Adds the "write schema to database"-command.
     *
     * @param command The command
     */
    public void addWriteSchemaToDatabase(WriteSchemaToDatabaseCommand command) {
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
     * Adds the "write data to database"-command.
     *
     * @param command The command
     */
    public void addWriteDataToDatabase(WriteDataToDatabaseCommand command) {
        addCommand(command);
    }

    /**
     * Adds the "write data to file"-command.
     *
     * @param command The command
     */
    public void addWriteDataToFile(WriteDataToFileCommand command) {
        addCommand(command);
    }

    @Override
    protected Database readModel() {
        DatabaseIO reader = new DatabaseIO();
        Database model = null;

        reader.setValidateXml(_validateXml);
        reader.setUseInternalDtd(_useInternalDtd);
        if ((_singleSchemaFile != null) && !_fileSets.isEmpty()) {
            throw new BuildException("Please use either the schema file attribute or the sub fileset element, but not both");
        }
        if (_singleSchemaFile != null) {
            model = readSingleSchemaFile(reader, _singleSchemaFile);
        } else {
            for (FileSet fileSet : _fileSets) {
                File fileSetDir = fileSet.getDir(getProject());
                DirectoryScanner scanner = fileSet.getDirectoryScanner(getProject());
                String[] files = scanner.getIncludedFiles();

                for (int idx = 0; (files != null) && (idx < files.length); idx++) {
                    Database curModel = readSingleSchemaFile(reader, new File(fileSetDir, files[idx]));

                    if (model == null) {
                        model = curModel;
                    } else if (curModel != null) {
                        try {
                            model.mergeWith(curModel);
                        } catch (IllegalArgumentException ex) {
                            throw new BuildException("Could not merge with schema from file " + files[idx] + ": " + ex.getLocalizedMessage(), ex);
                        }
                    }
                }
            }
        }
        return model;
    }

    /**
     * Reads a single schema file.
     *
     * @param reader     The schema reader
     * @param schemaFile The schema file
     * @return The model
     */
    private Database readSingleSchemaFile(DatabaseIO reader, File schemaFile) {
        Database model = null;

        if (!schemaFile.isFile()) {
            _log.error("Path " + schemaFile.getAbsolutePath() + " does not denote a file");
        } else if (!schemaFile.canRead()) {
            _log.error("Could not read schema file " + schemaFile.getAbsolutePath());
        } else {
            try {
                model = reader.read(schemaFile);
                _log.info("Read schema file " + schemaFile.getAbsolutePath());
            } catch (Exception ex) {
                throw new BuildException("Could not read schema file " + schemaFile.getAbsolutePath() + ": " + ex.getLocalizedMessage(), ex);
            }
        }
        return model;
    }
}
