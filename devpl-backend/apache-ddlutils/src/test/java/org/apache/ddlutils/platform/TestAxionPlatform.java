package org.apache.ddlutils.platform;


import org.apache.ddlutils.TestPlatformBase;
import org.apache.ddlutils.platform.axion.AxionPlatform;
import org.junit.jupiter.api.Test;

/**
 * Tests the Axion platform.
 */
public class TestAxionPlatform extends TestPlatformBase {

    @Override
    protected String getDatabaseName() {
        return AxionPlatform.DATABASENAME;
    }

    /**
     * Tests the column types.
     */
    @Test
    public void testColumnTypes() throws Exception {
        assertEqualsIgnoringWhitespaces("""
            DROP TABLE IF EXISTS coltype;
            CREATE TABLE coltype
            (
                COL_ARRAY           BLOB,
                COL_BIGINT          BIGINT,
                COL_BINARY          BINARY,
                COL_BIT             BOOLEAN,
                COL_BLOB            BLOB,
                COL_BOOLEAN         BOOLEAN,
                COL_CHAR            CHAR(15),
                COL_CLOB            CLOB,
                COL_DATALINK        VARBINARY,
                COL_DATE            DATE,
                COL_DECIMAL         DECIMAL(15,3),
                COL_DECIMAL_NOSCALE DECIMAL(15,0),
                COL_DISTINCT        VARBINARY,
                COL_DOUBLE          DOUBLE,
                COL_FLOAT           FLOAT,
                COL_INTEGER         INTEGER,
                COL_JAVA_OBJECT     JAVA_OBJECT,
                COL_LONGVARBINARY   LONGVARBINARY,
                COL_LONGVARCHAR     LONGVARCHAR,
                COL_NULL            VARBINARY,
                COL_NUMERIC         NUMERIC(15,0),
                COL_OTHER           BLOB,
                COL_REAL            REAL,
                COL_REF             VARBINARY,
                COL_SMALLINT        SMALLINT,
                COL_STRUCT          VARBINARY,
                COL_TIME            TIME,
                COL_TIMESTAMP       TIMESTAMP,
                COL_TINYINT         SMALLINT,
                COL_VARBINARY       VARBINARY(15),
                COL_VARCHAR         VARCHAR(15)
            );
            """, getColumnTestDatabaseCreationSql());
    }

    /**
     * Tests the column constraints.
     */
    public void testColumnConstraints() throws Exception {
        assertEqualsIgnoringWhitespaces("""
            DROP TABLE IF EXISTS constraints;
            CREATE TABLE constraints
            (
                COL_PK               VARCHAR(32),
                COL_PK_AUTO_INCR     INTEGER GENERATED BY DEFAULT AS IDENTITY,
                COL_NOT_NULL         BINARY(100) NOT NULL,
                COL_NOT_NULL_DEFAULT DOUBLE DEFAULT -2.0 NOT NULL,
                COL_DEFAULT          CHAR(4) DEFAULT 'test',
                COL_AUTO_INCR        BIGINT GENERATED BY DEFAULT AS IDENTITY,
                PRIMARY KEY (COL_PK, COL_PK_AUTO_INCR)
            );
            """, getConstraintTestDatabaseCreationSql());
    }

    /**
     * Tests the table constraints.
     */
    public void testTableConstraints() throws Exception {
        assertEqualsIgnoringWhitespaces("""
            ALTER TABLE table3 DROP CONSTRAINT testfk;
            ALTER TABLE table2 DROP CONSTRAINT table2_FK_COL_FK_1_COL_FK_2_table1;
            DROP TABLE IF EXISTS table3;
            DROP TABLE IF EXISTS table2;
            DROP TABLE IF EXISTS table1;
            CREATE TABLE table1
            (
                COL_PK_1    VARCHAR(32) NOT NULL,
                COL_PK_2    INTEGER,
                COL_INDEX_1 BINARY(100) NOT NULL,
                COL_INDEX_2 DOUBLE NOT NULL,
                COL_INDEX_3 CHAR(4),
                PRIMARY KEY (COL_PK_1, COL_PK_2)
            );
            CREATE INDEX testindex1 ON table1 (COL_INDEX_2);
            CREATE UNIQUE INDEX testindex2 ON table1 (COL_INDEX_3, COL_INDEX_1);
            CREATE TABLE table2
            (
                COL_PK   INTEGER,
                COL_FK_1 INTEGER,
                COL_FK_2 VARCHAR(32) NOT NULL,
                PRIMARY KEY (COL_PK)
            );
            CREATE TABLE table3
            (
                COL_PK VARCHAR(16),
                COL_FK INTEGER NOT NULL,
                PRIMARY KEY (COL_PK)
            );
            ALTER TABLE table2 ADD CONSTRAINT table2_FK_COL_FK_1_COL_FK_2_table1 FOREIGN KEY (COL_FK_1, COL_FK_2) REFERENCES table1 (COL_PK_2, COL_PK_1);
            ALTER TABLE table3 ADD CONSTRAINT testfk FOREIGN KEY (COL_FK) REFERENCES table2 (COL_PK);
            """, getTableConstraintTestDatabaseCreationSql());
    }

    /**
     * Tests the proper escaping of character sequences where Axion requires it.
     */
    public void testCharacterEscaping() throws Exception {
        assertEqualsIgnoringWhitespaces("""
            DROP TABLE IF EXISTS escapedcharacters;
            CREATE TABLE escapedcharacters
            (
                COL_PK   INTEGER,
                COL_TEXT VARCHAR(128) DEFAULT '''',
                PRIMARY KEY (COL_PK)
            );
            """, getCharEscapingTestDatabaseCreationSql());
    }
}
