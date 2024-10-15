package org.apache.ddlutils.platform;


import org.apache.ddlutils.TestPlatformBase;

/**
 * Tests the Cloudscape platform.
 */
public class TestCloudscapePlatform extends TestPlatformBase {

    @Override
    protected String getDatabaseName() {
        return BuiltinDBType.CLOUDSCAPE.getName();
    }

    /**
     * Tests the column types.
     */
    public void testColumnTypes() throws Exception {
        assertEqualsIgnoringWhitespaces("""
            DROP TABLE "coltype";
            CREATE TABLE "coltype"
            (
                "COL_ARRAY"           BLOB,
                "COL_BIGINT"          BIGINT,
                "COL_BINARY"          CHAR(254) FOR BIT DATA,
                "COL_BIT"             SMALLINT,
                "COL_BLOB"            BLOB,
                "COL_BOOLEAN"         SMALLINT,
                "COL_CHAR"            CHAR(15),
                "COL_CLOB"            CLOB,
                "COL_DATALINK"        LONG VARCHAR FOR BIT DATA,
                "COL_DATE"            DATE,
                "COL_DECIMAL"         DECIMAL(15,3),
                "COL_DECIMAL_NOSCALE" DECIMAL(15,0),
                "COL_DISTINCT"        BLOB,
                "COL_DOUBLE"          DOUBLE PRECISION,
                "COL_FLOAT"           DOUBLE PRECISION,
                "COL_INTEGER"         INTEGER,
                "COL_JAVA_OBJECT"     BLOB,
                "COL_LONGVARBINARY"   LONG VARCHAR FOR BIT DATA,
                "COL_LONGVARCHAR"     LONG VARCHAR,
                "COL_NULL"            LONG VARCHAR FOR BIT DATA,
                "COL_NUMERIC"         NUMERIC(15,0),
                "COL_OTHER"           BLOB,
                "COL_REAL"            REAL,
                "COL_REF"             LONG VARCHAR FOR BIT DATA,
                "COL_SMALLINT"        SMALLINT,
                "COL_STRUCT"          BLOB,
                "COL_TIME"            TIME,
                "COL_TIMESTAMP"       TIMESTAMP,
                "COL_TINYINT"         SMALLINT,
                "COL_VARBINARY"       VARCHAR(15) FOR BIT DATA,
                "COL_VARCHAR"         VARCHAR(15)
            );
            """, getColumnTestDatabaseCreationSql());
    }

    /**
     * Tests the column constraints.
     */
    public void testColumnConstraints() throws Exception {
        assertEqualsIgnoringWhitespaces("""
            DROP TABLE "constraints";
            CREATE TABLE "constraints"
            (
                "COL_PK"               VARCHAR(32),
                "COL_PK_AUTO_INCR"     INTEGER GENERATED ALWAYS AS IDENTITY,
                "COL_NOT_NULL"         CHAR(100) FOR BIT DATA NOT NULL,
                "COL_NOT_NULL_DEFAULT" DOUBLE PRECISION DEFAULT -2.0 NOT NULL,
                "COL_DEFAULT"          CHAR(4) DEFAULT 'test',
                "COL_AUTO_INCR"        BIGINT GENERATED ALWAYS AS IDENTITY,
                PRIMARY KEY ("COL_PK", "COL_PK_AUTO_INCR")
            );
            """, getConstraintTestDatabaseCreationSql());
    }

    /**
     * Tests the table constraints.
     */
    public void testTableConstraints() throws Exception {
        assertEqualsIgnoringWhitespaces("""
            ALTER TABLE "table3" DROP CONSTRAINT "testfk";
            ALTER TABLE "table2" DROP CONSTRAINT "table2_FK_COL_FK_1_COL_FK_2_table1";
            DROP TABLE "table3";
            DROP TABLE "table2";
            DROP TABLE "table1";
            CREATE TABLE "table1"
            (
                "COL_PK_1"    VARCHAR(32) NOT NULL,
                "COL_PK_2"    INTEGER,
                "COL_INDEX_1" CHAR(100) FOR BIT DATA NOT NULL,
                "COL_INDEX_2" DOUBLE PRECISION NOT NULL,
                "COL_INDEX_3" CHAR(4),
                PRIMARY KEY ("COL_PK_1", "COL_PK_2")
            );
            CREATE INDEX "testindex1" ON "table1" ("COL_INDEX_2");
            CREATE UNIQUE INDEX "testindex2" ON "table1" ("COL_INDEX_3", "COL_INDEX_1");
            CREATE TABLE "table2"
            (
                "COL_PK"   INTEGER,
                "COL_FK_1" INTEGER,
                "COL_FK_2" VARCHAR(32) NOT NULL,
                PRIMARY KEY ("COL_PK")
            );
            CREATE TABLE "table3"
            (
                "COL_PK" VARCHAR(16),
                "COL_FK" INTEGER NOT NULL,
                PRIMARY KEY ("COL_PK")
            );
            ALTER TABLE "table2" ADD CONSTRAINT "table2_FK_COL_FK_1_COL_FK_2_table1" FOREIGN KEY ("COL_FK_1", "COL_FK_2") REFERENCES "table1" ("COL_PK_2", "COL_PK_1");
            ALTER TABLE "table3" ADD CONSTRAINT "testfk" FOREIGN KEY ("COL_FK") REFERENCES "table2" ("COL_PK");
            """, getTableConstraintTestDatabaseCreationSql());
    }

    /**
     * Tests the proper escaping of character sequences where Cloudscape requires it.
     */
    public void testCharacterEscaping() throws Exception {
        assertEqualsIgnoringWhitespaces("""
            DROP TABLE "escapedcharacters";
            CREATE TABLE "escapedcharacters"
            (
                "COL_PK"   INTEGER,
                "COL_TEXT" VARCHAR(128) DEFAULT '''',
                PRIMARY KEY ("COL_PK")
            );
            """, getCharEscapingTestDatabaseCreationSql());
    }
}