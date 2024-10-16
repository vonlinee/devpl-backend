package org.apache.ddlutils.io;

import junit.framework.Test;
import org.apache.ddlutils.TestAgainstLiveDatabaseBase;
import org.apache.ddlutils.model.TableRow;
import org.apache.ddlutils.platform.BuiltinDBType;

import java.math.BigDecimal;
import java.util.List;
import java.util.Objects;

import static org.junit.jupiter.api.Assertions.assertTrue;

/**
 * Tests database alterations that insert columns.
 */
public class TestInsertColumn extends TestAgainstLiveDatabaseBase {
    /**
     * Parameterized test case pattern.
     *
     * @return The tests
     */
    public static Test suite() throws Exception {
        return getTests(TestInsertColumn.class);
    }

    /**
     * Tests the insertion of a column.
     */
    public void testInsertColumn() {
        final String model1Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip'>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
              </table>
            </database>""";
        final String model2Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip'>
                <column name='avalue' type='VARCHAR' size='32'/>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
              </table>
            </database>""";

        createDatabase(model1Xml);

        insertRow("roundtrip", new Object[]{(1)});

        alterDatabase(model2Xml);

        assertEquals(getAdjustedModel(), readModelFromDatabase("roundtriptest"));

        List<TableRow> rows = getRows("roundtrip");

        assertEquals((Object) null, rows.get(0), "avalue");
    }

    /**
     * Tests the insertion of an auto-increment column.
     */
    public void testInsertAutoIncrementColumn() {
        if (!getPlatformInfo().isNonPrimaryKeyIdentityColumnsSupported()) {
            return;
        }

        // we need special catering for Sybase which does not support identity for INTEGER columns
        boolean isSybase = BuiltinDBType.SYBASE.getName().equals(getPlatform().getName());
        final String model1Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip'>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
              </table>
            </database>""";
        final String model2Xml;

        if (isSybase) {
            model2Xml = """
                <?xml version='1.0' encoding='ISO-8859-1'?>
                <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
                  <table name='roundtrip'>
                    <column name='avalue' type='NUMERIC' size='12,0' autoIncrement='true'/>
                    <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
                  </table>
                </database>""";
        } else {
            model2Xml = """
                <?xml version='1.0' encoding='ISO-8859-1'?>
                <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
                  <table name='roundtrip'>
                    <column name='avalue' type='INTEGER' autoIncrement='true'/>
                    <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
                  </table>
                </database>""";
        }

        createDatabase(model1Xml);

        insertRow("roundtrip", new Object[]{(1)});

        alterDatabase(model2Xml);

        assertEquals(getAdjustedModel(), readModelFromDatabase("roundtriptest"));

        List<TableRow> rows = getRows("roundtrip");

        if (isSybase) {
            assertEquals(new BigDecimal(1), rows.get(0), "avalue");
        } else {
            Object avalue = rows.get(0).getColumnValue("avalue");

            assertTrue((avalue == null) || Objects.equals(1, avalue));
        }
    }

    /**
     * Tests the insertion of a column that is set to NOT NULL.
     */
    public void testInsertRequiredColumn() {
        final String model1Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip'>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
              </table>
            </database>""";
        final String model2Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip'>
                <column name='avalue' type='NUMERIC' size='12,0' default='2' required='true'/>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
              </table>
            </database>""";

        createDatabase(model1Xml);

        insertRow("roundtrip", new Object[]{(1)});

        alterDatabase(model2Xml);

        assertEquals(getAdjustedModel(), readModelFromDatabase("roundtriptest"));

        List<TableRow> rows = getRows("roundtrip");

        assertEquals(new BigDecimal(2), rows.get(0), "avalue");
    }

    /**
     * Tests the insert of a column with a default value. Note that depending
     * on whether the database supports this via a statement, this test may fail.
     * For instance, Sql Server has a statement for this which means that the
     * existing value in column avalue won't be changed and thus the test fails.
     */
    public void testInsertColumnWithDefault() {
        final String model1Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip'>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
              </table>
            </database>""";
        final String model2Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip'>
                <column name='avalue' type='DOUBLE' default='2'/>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
              </table>
            </database>""";

        createDatabase(model1Xml);

        insertRow("roundtrip", new Object[]{(1)});

        alterDatabase(model2Xml);

        assertEquals(getAdjustedModel(), readModelFromDatabase("roundtriptest"));

        List<TableRow> rows = getRows("roundtrip");

        // we cannot be sure whether the default algorithm is used (which will apply the
        // default value even to existing columns with NULL in it) or the database supports
        // it directly (in which case it might still be NULL)
        Object avalue = rows.get(0).getColumnValue("avalue");

        assertTrue((avalue == null) || Double.valueOf(2).equals(avalue));
    }

    /**
     * Tests the insertion of a required auto-increment column.
     */
    public void testInsertRequiredAutoIncrementColumn() {
        if (!getPlatformInfo().isNonPrimaryKeyIdentityColumnsSupported()) {
            return;
        }

        // we need special catering for Sybase which does not support identity for INTEGER columns
        boolean isSybase = BuiltinDBType.SYBASE.getName().equals(getPlatform().getName());
        final String model1Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip'>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
              </table>
            </database>""";
        final String model2Xml;

        if (isSybase) {
            model2Xml = """
                <?xml version='1.0' encoding='ISO-8859-1'?>
                <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
                  <table name='roundtrip'>
                    <column name='avalue' type='NUMERIC' size='12,0' autoIncrement='true' required='true'/>
                    <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
                  </table>
                </database>""";
        } else {
            model2Xml = """
                <?xml version='1.0' encoding='ISO-8859-1'?>
                <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
                  <table name='roundtrip'>
                    <column name='avalue' type='INTEGER' autoIncrement='true' required='true'/>
                    <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
                  </table>
                </database>""";
        }

        createDatabase(model1Xml);

        insertRow("roundtrip", new Object[]{(1)});

        alterDatabase(model2Xml);

        assertEquals(getAdjustedModel(), readModelFromDatabase("roundtriptest"));

        List<TableRow> rows = getRows("roundtrip");

        if (isSybase) {
            assertEquals(new BigDecimal(1), rows.get(0), "avalue");
        } else {
            Object avalue = rows.get(0).getColumnValue("avalue");

            assertTrue((avalue == null) || Objects.equals(1, avalue));
        }
    }

    /**
     * Tests the insertion of a column with a default value. Note that depending
     * on whether the database supports this via a statement, this test may fail.
     * For instance, Sql Server has a statement for this which means that the
     * existing value in column avalue won't be changed and thus the test fails.
     */
    public void testAddRequiredColumnWithDefault() {
        final String model1Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip'>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
              </table>
            </database>""";
        final String model2Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip'>
                <column name='avalue' type='CHAR' size='8' default='text' required='true'/>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
              </table>
            </database>""";

        createDatabase(model1Xml);

        insertRow("roundtrip", new Object[]{(1)});

        alterDatabase(model2Xml);

        assertEquals(getAdjustedModel(), readModelFromDatabase("roundtriptest"));

        List<TableRow> rows = getRows("roundtrip");

        // we cannot be sure whether the default algorithm is used (which will apply the
        // default value even to existing columns with NULL in it) or the database supports
        // it directly (in which case it might still be NULL)
        Object avalue = rows.get(0).getColumnValue("avalue");

        if (BuiltinDBType.MYSQL.getName().equals(getPlatform().getName()) || BuiltinDBType.MYSQL5.getName().equals(getPlatform().getName()) || BuiltinDBType.HSQLDB.getName().equals(getPlatform().getName()) || BuiltinDBType.MAXDB.getName().equals(getPlatform().getName())) {
            // Some DBs ignore that the type is CHAR(8) and trim the value
            assertEquals("text", avalue);
        } else {
            // TODO
            //assertTrue((avalue == null) || "text    ".equals(avalue));
            assertEquals("text    ", avalue);
        }
    }

    /**
     * Tests the addition and insertion of several columns.
     */
    public void testAddAndInsertMultipleColumns() {
        final String model1Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip'>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
                <column name='avalue3' type='DOUBLE' default='1.0'/>
              </table>
            </database>""";
        final String model2Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip'>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
                <column name='avalue1' type='VARCHAR' size='32'/>
                <column name='avalue2' type='INTEGER'/>
                <column name='avalue3' type='DOUBLE' default='1.0' required='true'/>
                <column name='avalue4' type='VARCHAR' size='16'/>
              </table>
            </database>""";

        createDatabase(model1Xml);

        insertRow("roundtrip", new Object[]{(1), 3.0});

        alterDatabase(model2Xml);

        assertEquals(getAdjustedModel(), readModelFromDatabase("roundtriptest"));

        List<TableRow> rows = getRows("roundtrip");

        assertEquals((Object) null, rows.get(0), "avalue1");
        assertEquals((Object) null, rows.get(0), "avalue2");
        assertEquals(3.0, rows.get(0), "avalue3");
        assertEquals((Object) null, rows.get(0), "avalue4");
    }

    /**
     * Tests the insertion of a primary key and a column.
     */
    public void testInsertPKAndColumn() {
        final String model1Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip'>
                <column name='avalue' type='INTEGER'/>
              </table>
            </database>""";
        final String model2Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip'>
                <column name='pk' type='VARCHAR' size='32' primaryKey='true' required='true'/>
                <column name='avalue' type='INTEGER'/>
              </table>
            </database>""";

        createDatabase(model1Xml);

        insertRow("roundtrip", new Object[]{(1)});

        alterDatabase(model2Xml);

        assertEquals(getAdjustedModel(), readModelFromDatabase("roundtriptest"));

        List<TableRow> rows = getRows("roundtrip");

        assertTrue(rows.isEmpty());
    }

    /**
     * Tests the insertion of a primary key and an autoincrement column.
     */
    public void testInsertPKAndAutoIncrementColumn() {
        // we need special catering for Sybase which does not support identity for INTEGER columns
        boolean isSybase = BuiltinDBType.SYBASE.getName().equals(getPlatform().getName());
        final String model1Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip'>
                <column name='avalue' type='INTEGER'/>
              </table>
            </database>""";
        final String model2Xml;

        if (isSybase) {
            model2Xml = """
                <?xml version='1.0' encoding='ISO-8859-1'?>
                <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
                  <table name='roundtrip'>
                    <column name='pk' type='NUMERIC' size='12,0' primaryKey='true' required='true' autoIncrement='true'/>
                    <column name='avalue' type='INTEGER'/>
                  </table>
                </database>""";
        } else {
            model2Xml = """
                <?xml version='1.0' encoding='ISO-8859-1'?>
                <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
                  <table name='roundtrip'>
                    <column name='pk' type='INTEGER' primaryKey='true' required='true' autoIncrement='true'/>
                    <column name='avalue' type='INTEGER'/>
                  </table>
                </database>""";
        }

        createDatabase(model1Xml);

        insertRow("roundtrip", new Object[]{(1)});

        alterDatabase(model2Xml);

        assertEquals(getAdjustedModel(), readModelFromDatabase("roundtriptest"));

        List<TableRow> rows = getRows("roundtrip");

        if (isSybase) {
            assertEquals(new BigDecimal(1), rows.get(0), "avalue");
        } else {
            assertEquals((1), rows.get(0), "avalue");
        }
    }

    /**
     * Tests the insertion of a primary key and multiple columns.
     */
    public void testAddAndInsertPKAndMultipleColumns() {
        if (!getPlatformInfo().isMixingIdentityAndNormalPrimaryKeyColumnsSupported()) {
            return;
        }

        final String model1Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip'>
                <column name='avalue' type='INTEGER'/>
              </table>
            </database>""";
        final String model2Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip'>
                <column name='pk1' type='INTEGER' primaryKey='true' required='true' autoIncrement='true'/>
                <column name='pk2' type='VARCHAR' size='32' primaryKey='true' required='true'/>
                <column name='avalue' type='INTEGER'/>
                <column name='pk3' type='DOUBLE' primaryKey='true' required='true'/>
              </table>
            </database>""";

        createDatabase(model1Xml);

        insertRow("roundtrip", new Object[]{(1)});

        alterDatabase(model2Xml);

        assertEquals(getAdjustedModel(), readModelFromDatabase("roundtriptest"));

        assertTrue(getRows("roundtrip").isEmpty());
    }


    /**
     * Tests the insertion of a column to a primary key.
     */
    public void testInsertColumnIntoPK() {
        final String model1Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip'>
                <column name='pk1' type='INTEGER' primaryKey='true' required='true'/>
                <column name='avalue' type='INTEGER'/>
              </table>
            </database>""";
        final String model2Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip'>
                <column name='pk1' type='INTEGER' primaryKey='true' required='true'/>
                <column name='pk2' type='INTEGER' primaryKey='true' required='true'/>
                <column name='avalue' type='INTEGER'/>
              </table>
            </database>""";

        createDatabase(model1Xml);

        insertRow("roundtrip", new Object[]{(1), (2)});

        alterDatabase(model2Xml);

        assertEquals(getAdjustedModel(), readModelFromDatabase("roundtriptest"));

        assertTrue(getRows("roundtrip").isEmpty());
    }

    /**
     * Tests the insertion of an autoincrement column into the primary key.
     */
    public void testInsertAutoIncrementColumnIntoPK() {
        if (!getPlatformInfo().isMixingIdentityAndNormalPrimaryKeyColumnsSupported()) {
            return;
        }

        // we need special catering for Sybase which does not support identity for INTEGER columns
        boolean isSybase = BuiltinDBType.SYBASE.getName().equals(getPlatform().getName());
        final String model1Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip'>
                <column name='pk1' type='INTEGER' primaryKey='true' required='true'/>
                <column name='avalue' type='INTEGER'/>
              </table>
            </database>""";
        final String model2Xml;

        if (isSybase) {
            model2Xml = """
                <?xml version='1.0' encoding='ISO-8859-1'?>
                <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
                  <table name='roundtrip'>
                    <column name='pk1' type='INTEGER' primaryKey='true' required='true'/>
                    <column name='pk2' type='NUMERIC' size='12,0' primaryKey='true' required='true' autoIncrement='true'/>
                    <column name='avalue' type='INTEGER'/>
                  </table>
                </database>""";
        } else {
            model2Xml = """
                <?xml version='1.0' encoding='ISO-8859-1'?>
                <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
                  <table name='roundtrip'>
                    <column name='pk1' type='INTEGER' primaryKey='true' required='true'/>
                    <column name='pk2' type='INTEGER' primaryKey='true' required='true' autoIncrement='true'/>
                    <column name='avalue' type='INTEGER'/>
                  </table>
                </database>""";
        }

        createDatabase(model1Xml);

        insertRow("roundtrip", new Object[]{(-1), (2)});

        alterDatabase(model2Xml);

        assertEquals(getAdjustedModel(), readModelFromDatabase("roundtriptest"));

        List<TableRow> rows = getRows("roundtrip");

        if (isSybase) {
            assertEquals(new BigDecimal(-1), rows.get(0), "pk1");
        } else {
            assertEquals((-1), rows.get(0), "pk1");
        }
        assertEquals((2), rows.get(0).getColumnValue("avalue"));
    }

    /**
     * Tests the insertion of multiple columns into the primary key.
     */
    public void testInsertMultipleColumnsIntoPK() {
        if (!getPlatformInfo().isMixingIdentityAndNormalPrimaryKeyColumnsSupported()) {
            return;
        }

        final String model1Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip'>
                <column name='pk1' type='INTEGER' primaryKey='true' required='true' autoIncrement='true'/>
                <column name='avalue' type='INTEGER'/>
              </table>
            </database>""";
        final String model2Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip'>
                <column name='pk1' type='INTEGER' primaryKey='true' required='true' autoIncrement='true'/>
                <column name='pk2' type='VARCHAR' size='32' primaryKey='true' required='true'/>
                <column name='avalue' type='INTEGER'/>
                <column name='pk3' type='DOUBLE' primaryKey='true' required='true'/>
              </table>
            </database>""";

        createDatabase(model1Xml);

        insertRow("roundtrip", new Object[]{(1)});

        alterDatabase(model2Xml);

        assertEquals(getAdjustedModel(), readModelFromDatabase("roundtriptest"));

        assertTrue(getRows("roundtrip").isEmpty());
    }

    /**
     * Tests the insertion of a non-unique index and a column.
     */
    public void testInsertNonUniqueIndexAndColumn() {
        if (!getPlatformInfo().isIndicesSupported()) {
            return;
        }

        final String model1Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip'>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
              </table>
            </database>""";
        final String model2Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip'>
                <column name='avalue' type='VARCHAR' size='32'/>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
                <index name='test'>
                  <index-column name='avalue'/>
                </index>
              </table>
            </database>""";

        createDatabase(model1Xml);

        insertRow("roundtrip", new Object[]{(1)});

        alterDatabase(model2Xml);

        assertEquals(getAdjustedModel(), readModelFromDatabase("roundtriptest"));

        List<TableRow> rows = getRows("roundtrip");

        assertEquals((Object) null, rows.get(0), "avalue");
    }

    /**
     * Tests the insertion of a non-unique index and an auto increment column.
     */
    public void testInsertNonUniqueIndexAndAutoIncrementColumn() {
        if (!getPlatformInfo().isNonPrimaryKeyIdentityColumnsSupported() || !getPlatformInfo().isIndicesSupported()) {
            return;
        }

        final String model1Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip'>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
              </table>
            </database>""";
        final String model2Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip'>
                <column name='avalue' type='INTEGER' autoIncrement='true'/>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
                <index name='test'>
                  <index-column name='avalue'/>
                </index>
              </table>
            </database>""";

        createDatabase(model1Xml);

        insertRow("roundtrip", new Object[]{(1)});

        alterDatabase(model2Xml);

        assertEquals(getAdjustedModel(), readModelFromDatabase("roundtriptest"));

        List<TableRow> rows = getRows("roundtrip");

        assertEquals((1), rows.get(0), "avalue");
    }

    /**
     * Tests the insertion of a non-unique index and a required column.
     */
    public void testInsertNonUniqueIndexAndRequiredColumn() {
        if (!getPlatformInfo().isIndicesSupported()) {
            return;
        }

        final String model1Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip'>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
              </table>
            </database>""";
        final String model2Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip'>
                <column name='avalue' type='NUMERIC' size='12,0' required='true'/>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
                <index name='test'>
                  <index-column name='avalue'/>
                </index>
              </table>
            </database>""";

        createDatabase(model1Xml);

        insertRow("roundtrip", new Object[]{(1)});

        alterDatabase(model2Xml);

        assertEquals(getAdjustedModel(), readModelFromDatabase("roundtriptest"));

        assertTrue(getRows("roundtrip").isEmpty());
    }

    /**
     * Tests the insertion of a non-unique index and a column with a default value.
     */
    public void testInsertNonUniqueIndexAndColumnWithDefault() {
        if (!getPlatformInfo().isIndicesSupported()) {
            return;
        }

        final String model1Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip'>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
              </table>
            </database>""";
        final String model2Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip'>
                <column name='avalue' type='DOUBLE' default='2'/>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
                <index name='test'>
                  <index-column name='avalue'/>
                </index>
              </table>
            </database>""";

        createDatabase(model1Xml);

        insertRow("roundtrip", new Object[]{(1)});

        alterDatabase(model2Xml);

        assertEquals(getAdjustedModel(), readModelFromDatabase("roundtriptest"));

        List<TableRow> rows = getRows("roundtrip");

        assertEquals(2.0, rows.get(0), "avalue");
    }

    /**
     * Tests the insertion of a non-unique index and a required auto increment column.
     */
    public void testInsertNonUniqueIndexAndrequiredAutoIncrementColumn() {
        if (!getPlatformInfo().isNonPrimaryKeyIdentityColumnsSupported() || !getPlatformInfo().isIndicesSupported()) {
            return;
        }

        final String model1Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip'>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
              </table>
            </database>""";
        final String model2Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip'>
                <column name='avalue' type='INTEGER' required='true' autoIncrement='true'/>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
                <index name='test'>
                  <index-column name='avalue'/>
                </index>
              </table>
            </database>""";

        createDatabase(model1Xml);

        insertRow("roundtrip", new Object[]{(1)});

        alterDatabase(model2Xml);

        assertEquals(getAdjustedModel(), readModelFromDatabase("roundtriptest"));

        List<TableRow> rows = getRows("roundtrip");

        assertEquals((1), rows.get(0), "avalue");
    }

    /**
     * Tests the insertion of a non-unique index and a required column with a default value.
     */
    public void testInsertNonUniqueIndexAndRequiredColumnWithDefault() {
        if (!getPlatformInfo().isIndicesSupported()) {
            return;
        }

        final String model1Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip'>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
              </table>
            </database>""";
        final String model2Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip'>
                <column name='avalue' type='CHAR' size='8' required='true' default='text'/>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
                <index name='test'>
                  <index-column name='avalue'/>
                </index>
              </table>
            </database>""";

        createDatabase(model1Xml);

        insertRow("roundtrip", new Object[]{(1)});

        alterDatabase(model2Xml);

        assertEquals(getAdjustedModel(), readModelFromDatabase("roundtriptest"));

        List<TableRow> rows = getRows("roundtrip");
        Object avalue = rows.get(0).getColumnValue("avalue");

        if (BuiltinDBType.MYSQL.getName().equals(getPlatform().getName()) || BuiltinDBType.MYSQL5.getName().equals(getPlatform().getName()) || BuiltinDBType.HSQLDB.getName().equals(getPlatform().getName()) || BuiltinDBType.MAXDB.getName().equals(getPlatform().getName())) {
            // Some DBs ignore that the type is CHAR(8) and trim the value
            assertEquals("text", avalue);
        } else {
            assertEquals("text    ", avalue);
        }
    }

    /**
     * Tests the insertion of a non-unique index and several columns.
     */
    public void testAddAndInsertNonUniqueIndexAndMultipleColumns() {
        if (!getPlatformInfo().isIndicesSupported()) {
            return;
        }

        final String model1Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip'>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
              </table>
            </database>""";
        final String model2Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip'>
                <column name='avalue1' type='INTEGER' default='1'/>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
                <column name='avalue2' type='VARCHAR' size='32' required='true'/>
                <index name='test'>
                  <index-column name='avalue1'/>
                  <index-column name='avalue2'/>
                </index>
              </table>
            </database>""";

        createDatabase(model1Xml);

        insertRow("roundtrip", new Object[]{(1)});

        alterDatabase(model2Xml);

        assertEquals(getAdjustedModel(), readModelFromDatabase("roundtriptest"));

        assertTrue(getRows("roundtrip").isEmpty());
    }

    /**
     * Tests the insertion of an unique index and a column.
     */
    public void testInsertUniqueIndexAndColumn() {
        if (!getPlatformInfo().isIndicesSupported()) {
            return;
        }

        final String model1Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip'>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
              </table>
            </database>""";
        final String model2Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip'>
                <column name='avalue' type='VARCHAR' size='32'/>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
                <unique name='test'>
                  <unique-column name='avalue'/>
                </unique>
              </table>
            </database>""";

        createDatabase(model1Xml);

        insertRow("roundtrip", new Object[]{(1)});

        alterDatabase(model2Xml);

        assertEquals(getAdjustedModel(), readModelFromDatabase("roundtriptest"));

        List<TableRow> rows = getRows("roundtrip");

        assertEquals((Object) null, rows.get(0), "avalue");
    }

    /**
     * Tests the insertion of an unique index and an auto increment column.
     */
    public void testInsertUniqueIndexAndAutoIncrementColumn() {
        if (!getPlatformInfo().isNonPrimaryKeyIdentityColumnsSupported() || !getPlatformInfo().isIndicesSupported()) {
            return;
        }

        final String model1Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip'>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
              </table>
            </database>""";
        final String model2Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip'>
                <column name='avalue' type='INTEGER' autoIncrement='true'/>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
                <unique name='test'>
                  <unique-column name='avalue'/>
                </unique>
              </table>
            </database>""";

        createDatabase(model1Xml);

        insertRow("roundtrip", new Object[]{(1)});

        alterDatabase(model2Xml);

        assertEquals(getAdjustedModel(), readModelFromDatabase("roundtriptest"));

        List<TableRow> rows = getRows("roundtrip");

        assertEquals((1), rows.get(0), "avalue");
    }

    /**
     * Tests the insertion of an unique index and a required column.
     */
    public void testInsertUniqueIndexAndRequiredColumn() {
        if (!getPlatformInfo().isIndicesSupported()) {
            return;
        }

        final String model1Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip'>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
              </table>
            </database>""";
        final String model2Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip'>
                <column name='avalue' type='NUMERIC' size='12,0' required='true'/>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
                <unique name='test'>
                  <unique-column name='avalue'/>
                </unique>
              </table>
            </database>""";

        createDatabase(model1Xml);

        insertRow("roundtrip", new Object[]{(1)});

        alterDatabase(model2Xml);

        assertEquals(getAdjustedModel(), readModelFromDatabase("roundtriptest"));

        assertTrue(getRows("roundtrip").isEmpty());
    }

    /**
     * Tests the insertion of an unique index and a column with a default value.
     */
    public void testInsertUniqueIndexAndColumnWithDefault() {
        if (!getPlatformInfo().isIndicesSupported()) {
            return;
        }

        final String model1Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip'>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
              </table>
            </database>""";
        final String model2Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip'>
                <column name='avalue' type='DOUBLE' default='2'/>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
                <unique name='test'>
                  <unique-column name='avalue'/>
                </unique>
              </table>
            </database>""";

        createDatabase(model1Xml);

        insertRow("roundtrip", new Object[]{(1)});

        alterDatabase(model2Xml);

        assertEquals(getAdjustedModel(), readModelFromDatabase("roundtriptest"));

        List<TableRow> rows = getRows("roundtrip");

        assertEquals(2.0, rows.get(0), "avalue");
    }

    /**
     * Tests the insertion of an unique index and a required auto increment column.
     */
    public void testInsertUniqueIndexAndRequiredAutoIncrementColumn() {
        if (!getPlatformInfo().isNonPrimaryKeyIdentityColumnsSupported() || !getPlatformInfo().isIndicesSupported()) {
            return;
        }

        final String model1Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip'>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
              </table>
            </database>""";
        final String model2Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip'>
                <column name='avalue' type='INTEGER' required='true' autoIncrement='true'/>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
                <unique name='test'>
                  <unique-column name='avalue'/>
                </unique>
              </table>
            </database>""";

        createDatabase(model1Xml);

        insertRow("roundtrip", new Object[]{(1)});

        alterDatabase(model2Xml);

        assertEquals(getAdjustedModel(), readModelFromDatabase("roundtriptest"));

        List<TableRow> rows = getRows("roundtrip");

        assertEquals((1), rows.get(0), "avalue");
    }

    /**
     * Tests the insertion of an unique index and a required column with a default value.
     */
    public void testInsertUniqueIndexAndRequiredColumnWithDefault() {
        if (!getPlatformInfo().isIndicesSupported()) {
            return;
        }

        final String model1Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip'>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
              </table>
            </database>""";
        final String model2Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip'>
                <column name='avalue' type='CHAR' size='8' required='true' default='text'/>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
                <unique name='test'>
                  <unique-column name='avalue'/>
                </unique>
              </table>
            </database>""";

        createDatabase(model1Xml);

        insertRow("roundtrip", new Object[]{(1)});

        alterDatabase(model2Xml);

        assertEquals(getAdjustedModel(), readModelFromDatabase("roundtriptest"));

        List<TableRow> rows = getRows("roundtrip");
        Object avalue = rows.get(0).getColumnValue("avalue");

        if (BuiltinDBType.MYSQL.getName().equals(getPlatform().getName()) || BuiltinDBType.MYSQL5.getName().equals(getPlatform().getName()) || BuiltinDBType.HSQLDB.getName().equals(getPlatform().getName()) || BuiltinDBType.MAXDB.getName().equals(getPlatform().getName())) {
            // Some DBs ignore that the type is CHAR(8) and trim the value
            assertEquals("text", avalue);
        } else {
            assertEquals("text    ", avalue);
        }
    }

    /**
     * Tests the insertion of an unique index and several columns.
     */
    public void testAddAndInsertUniqueIndexAndMultipleColumns() {
        if (!getPlatformInfo().isIndicesSupported()) {
            return;
        }

        final String model1Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip'>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
              </table>
            </database>""";
        final String model2Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip'>
                <column name='avalue1' type='INTEGER' default='1'/>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
                <column name='avalue2' type='VARCHAR' size='32' required='true'/>
                <unique name='test'>
                  <unique-column name='avalue1'/>
                  <unique-column name='avalue2'/>
                </unique>
              </table>
            </database>""";

        createDatabase(model1Xml);

        insertRow("roundtrip", new Object[]{(1)});

        alterDatabase(model2Xml);

        assertEquals(getAdjustedModel(), readModelFromDatabase("roundtriptest"));

        assertTrue(getRows("roundtrip").isEmpty());
    }

    /**
     * Tests the insertion of a column into a non-unique index.
     */
    public void testInsertColumnIntoNonUniqueIndex() {
        if (!getPlatformInfo().isIndicesSupported()) {
            return;
        }

        final String model1Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip'>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
                <column name='avalue1' type='INTEGER'/>
                <index name='test'>
                  <index-column name='avalue1'/>
                </index>
              </table>
            </database>""";
        final String model2Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip'>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
                <column name='avalue2' type='VARCHAR' size='32'/>
                <column name='avalue1' type='INTEGER'/>
                <index name='test'>
                  <index-column name='avalue1'/>
                  <index-column name='avalue2'/>
                </index>
              </table>
            </database>""";

        createDatabase(model1Xml);

        insertRow("roundtrip", new Object[]{(1), (2)});

        alterDatabase(model2Xml);

        assertEquals(getAdjustedModel(), readModelFromDatabase("roundtriptest"));

        List<TableRow> rows = getRows("roundtrip");

        assertEquals((2), rows.get(0), "avalue1");
        assertEquals((Object) null, rows.get(0), "avalue2");
    }

    /**
     * Tests the insert of an auto increment column into a non-unique index.
     */
    public void testInsertAutoIncrementColumnIntoNonUniqueIndex() {
        if (!getPlatformInfo().isNonPrimaryKeyIdentityColumnsSupported() || !getPlatformInfo().isIndicesSupported()) {
            return;
        }

        final String model1Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip'>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
                <column name='avalue1' type='INTEGER'/>
                <index name='test'>
                  <index-column name='avalue1'/>
                </index>
              </table>
            </database>""";
        final String model2Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip'>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
                <column name='avalue2' type='INTEGER' autoIncrement='true'/>
                <column name='avalue1' type='INTEGER'/>
                <index name='test'>
                  <index-column name='avalue1'/>
                  <index-column name='avalue2'/>
                </index>
              </table>
            </database>""";

        createDatabase(model1Xml);

        insertRow("roundtrip", new Object[]{(1), (2)});

        alterDatabase(model2Xml);

        assertEquals(getAdjustedModel(), readModelFromDatabase("roundtriptest"));

        List<TableRow> rows = getRows("roundtrip");

        assertEquals((2), rows.get(0), "avalue1");
        assertEquals((1), rows.get(0), "avalue2");
    }

    /**
     * Tests the insertion of a required column into a non-unique index.
     */
    public void testInsertRequiredColumnIntoNonUniqueIndex() {
        if (!getPlatformInfo().isIndicesSupported()) {
            return;
        }

        final String model1Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip'>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
                <column name='avalue1' type='INTEGER'/>
                <index name='test'>
                  <index-column name='avalue1'/>
                </index>
              </table>
            </database>""";
        final String model2Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip'>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
                <column name='avalue2' type='NUMERIC' size='12,0' required='true'/>
                <column name='avalue1' type='INTEGER'/>
                <index name='test'>
                  <index-column name='avalue1'/>
                  <index-column name='avalue2'/>
                </index>
              </table>
            </database>""";

        createDatabase(model1Xml);

        insertRow("roundtrip", new Object[]{(1), (2)});

        alterDatabase(model2Xml);

        assertEquals(getAdjustedModel(), readModelFromDatabase("roundtriptest"));

        assertTrue(getRows("roundtrip").isEmpty());
    }

    /**
     * Tests the insertion of a column with a default value into a non-unique index.
     */
    public void testInsertColumnWithDefaultIntoNonUniqueIndex() {
        if (!getPlatformInfo().isIndicesSupported()) {
            return;
        }

        final String model1Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip'>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
                <column name='avalue1' type='INTEGER'/>
                <index name='test'>
                  <index-column name='avalue1'/>
                </index>
              </table>
            </database>""";
        final String model2Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip'>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
                <column name='avalue2' type='DOUBLE' default='2'/>
                <column name='avalue1' type='INTEGER'/>
                <index name='test'>
                  <index-column name='avalue1'/>
                  <index-column name='avalue2'/>
                </index>
              </table>
            </database>""";

        createDatabase(model1Xml);

        insertRow("roundtrip", new Object[]{(1), (2)});

        alterDatabase(model2Xml);

        assertEquals(getAdjustedModel(), readModelFromDatabase("roundtriptest"));

        List<TableRow> rows = getRows("roundtrip");

        assertEquals((2), rows.get(0), "avalue1");
        assertEquals(2.0, rows.get(0), "avalue2");
    }

    /**
     * Tests the insertion of a required auto increment column into a non-unique index.
     */
    public void testInsertRequiredAutoIncrementColumnIntoNonUniqueIndex() {
        if (!getPlatformInfo().isNonPrimaryKeyIdentityColumnsSupported() || !getPlatformInfo().isIndicesSupported()) {
            return;
        }

        final String model1Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip'>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
                <column name='avalue1' type='INTEGER'/>
                <index name='test'>
                  <index-column name='avalue1'/>
                </index>
              </table>
            </database>""";
        final String model2Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip'>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
                <column name='avalue2' type='INTEGER' autoIncrement='true' required='true'/>
                <column name='avalue1' type='INTEGER'/>
                <index name='test'>
                  <index-column name='avalue1'/>
                  <index-column name='avalue2'/>
                </index>
              </table>
            </database>""";

        createDatabase(model1Xml);

        insertRow("roundtrip", new Object[]{(1), (2)});

        alterDatabase(model2Xml);

        assertEquals(getAdjustedModel(), readModelFromDatabase("roundtriptest"));

        List<TableRow> rows = getRows("roundtrip");

        assertEquals((2), rows.get(0), "avalue1");
        assertEquals((1), rows.get(0), "avalue2");
    }

    /**
     * Tests the insertion of a required column with a default value into a non-unique index.
     */
    public void testInsertRequiredColumnWithDefaultIntoNonUniqueIndex() {
        if (!getPlatformInfo().isIndicesSupported()) {
            return;
        }

        final String model1Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip'>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
                <column name='avalue1' type='INTEGER'/>
                <index name='test'>
                  <index-column name='avalue1'/>
                </index>
              </table>
            </database>""";
        final String model2Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip'>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
                <column name='avalue2' type='CHAR' size='8' default='text' required='true'/>
                <column name='avalue1' type='INTEGER'/>
                <index name='test'>
                  <index-column name='avalue1'/>
                  <index-column name='avalue2'/>
                </index>
              </table>
            </database>""";

        createDatabase(model1Xml);

        insertRow("roundtrip", new Object[]{(1), (2)});

        alterDatabase(model2Xml);

        assertEquals(getAdjustedModel(), readModelFromDatabase("roundtriptest"));

        List<TableRow> rows = getRows("roundtrip");
        Object avalue2 = rows.get(0).getColumnValue("avalue2");

        assertEquals((2), rows.get(0), "avalue1");
        if (BuiltinDBType.MYSQL.getName().equals(getPlatform().getName()) || BuiltinDBType.MYSQL5.getName().equals(getPlatform().getName()) || BuiltinDBType.HSQLDB.getName().equals(getPlatform().getName()) || BuiltinDBType.MAXDB.getName().equals(getPlatform().getName())) {
            // Some DBs ignore that the type is CHAR(8) and trim the value
            assertEquals("text", avalue2);
        } else {
            assertEquals("text    ", avalue2);
        }
    }

    /**
     * Tests the insertion of multiple columns into a non-unique index.
     */
    public void testAddAndInsertMultipleColumnsIntoNonUniqueIndex() {
        if (!getPlatformInfo().isIndicesSupported()) {
            return;
        }

        final String model1Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip'>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
                <column name='avalue1' type='INTEGER'/>
                <index name='test'>
                  <index-column name='avalue1'/>
                </index>
              </table>
            </database>""";
        final String model2Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip'>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
                <column name='avalue2' type='INTEGER' default='3'/>
                <column name='avalue1' type='INTEGER'/>
                <column name='avalue3' type='DOUBLE' required='true'/>
                <index name='test'>
                  <index-column name='avalue1'/>
                  <index-column name='avalue2'/>
                  <index-column name='avalue3'/>
                </index>
              </table>
            </database>""";

        createDatabase(model1Xml);

        insertRow("roundtrip", new Object[]{(1), (2)});

        alterDatabase(model2Xml);

        assertEquals(getAdjustedModel(), readModelFromDatabase("roundtriptest"));

        assertTrue(getRows("roundtrip").isEmpty());
    }

    /**
     * Tests the insertion of a column into an unique index.
     */
    public void testInsertColumnIntoUniqueIndex() {
        if (!getPlatformInfo().isIndicesSupported()) {
            return;
        }

        final String model1Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip'>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
                <column name='avalue1' type='INTEGER'/>
                <unique name='test'>
                  <unique-column name='avalue1'/>
                </unique>
              </table>
            </database>""";
        final String model2Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip'>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
                <column name='avalue2' type='VARCHAR' size='32'/>
                <column name='avalue1' type='INTEGER'/>
                <unique name='test'>
                  <unique-column name='avalue1'/>
                  <unique-column name='avalue2'/>
                </unique>
              </table>
            </database>""";

        createDatabase(model1Xml);

        insertRow("roundtrip", new Object[]{(1), (2)});

        alterDatabase(model2Xml);

        assertEquals(getAdjustedModel(), readModelFromDatabase("roundtriptest"));

        List<TableRow> rows = getRows("roundtrip");

        assertEquals((2), rows.get(0), "avalue1");
        assertEquals((Object) null, rows.get(0), "avalue2");
    }

    /**
     * Tests the insertion of an auto increment column into an unique index.
     */
    public void testInsertAutoIncrementColumnIntoUniqueIndex() {
        if (!getPlatformInfo().isNonPrimaryKeyIdentityColumnsSupported() || !getPlatformInfo().isIndicesSupported()) {
            return;
        }

        final String model1Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip'>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
                <column name='avalue1' type='INTEGER'/>
                <unique name='test'>
                  <unique-column name='avalue1'/>
                </unique>
              </table>
            </database>""";
        final String model2Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip'>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
                <column name='avalue2' type='INTEGER' autoIncrement='true'/>
                <column name='avalue1' type='INTEGER'/>
                <unique name='test'>
                  <unique-column name='avalue1'/>
                  <unique-column name='avalue2'/>
                </unique>
              </table>
            </database>""";

        createDatabase(model1Xml);

        insertRow("roundtrip", new Object[]{(1), (2)});

        alterDatabase(model2Xml);

        assertEquals(getAdjustedModel(), readModelFromDatabase("roundtriptest"));

        List<TableRow> rows = getRows("roundtrip");

        assertEquals((2), rows.get(0), "avalue1");
        assertEquals((1), rows.get(0), "avalue2");
    }

    /**
     * Tests the insertion of a required column into an unique index.
     */
    public void testInsertRequiredColumnIntoUniqueIndex() {
        if (!getPlatformInfo().isIndicesSupported()) {
            return;
        }

        final String model1Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip'>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
                <column name='avalue1' type='INTEGER'/>
                <unique name='test'>
                  <unique-column name='avalue1'/>
                </unique>
              </table>
            </database>""";
        final String model2Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip'>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
                <column name='avalue2' type='NUMERIC' size='12,0' required='true'/>
                <column name='avalue1' type='INTEGER'/>
                <unique name='test'>
                  <unique-column name='avalue1'/>
                  <unique-column name='avalue2'/>
                </unique>
              </table>
            </database>""";

        createDatabase(model1Xml);

        insertRow("roundtrip", new Object[]{(1), (2)});

        alterDatabase(model2Xml);

        assertEquals(getAdjustedModel(), readModelFromDatabase("roundtriptest"));

        assertTrue(getRows("roundtrip").isEmpty());
    }

    /**
     * Tests the insertion of a column with a default value into an unique index.
     */
    public void testInsertColumnWithDefaultIntoUniqueIndex() {
        if (!getPlatformInfo().isIndicesSupported()) {
            return;
        }

        final String model1Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip'>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
                <column name='avalue1' type='INTEGER'/>
                <unique name='test'>
                  <unique-column name='avalue1'/>
                </unique>
              </table>
            </database>""";
        final String model2Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip'>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
                <column name='avalue2' type='DOUBLE' default='2'/>
                <column name='avalue1' type='INTEGER'/>
                <unique name='test'>
                  <unique-column name='avalue1'/>
                  <unique-column name='avalue2'/>
                </unique>
              </table>
            </database>""";

        createDatabase(model1Xml);

        insertRow("roundtrip", new Object[]{(1), (2)});

        alterDatabase(model2Xml);

        assertEquals(getAdjustedModel(), readModelFromDatabase("roundtriptest"));

        List<TableRow> rows = getRows("roundtrip");

        assertEquals((2), rows.get(0), "avalue1");
        assertEquals(2.0, rows.get(0), "avalue2");
    }

    /**
     * Tests the insertion of a required auto increment column into an unique index.
     */
    public void testInsertRequiredAutoIncrementColumnIntoUniqueIndex() {
        if (!getPlatformInfo().isNonPrimaryKeyIdentityColumnsSupported() || !getPlatformInfo().isIndicesSupported()) {
            return;
        }

        final String model1Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip'>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
                <column name='avalue1' type='INTEGER'/>
                <unique name='test'>
                  <unique-column name='avalue1'/>
                </unique>
              </table>
            </database>""";
        final String model2Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip'>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
                <column name='avalue2' type='INTEGER' autoIncrement='true' required='true'/>
                <column name='avalue1' type='INTEGER'/>
                <unique name='test'>
                  <unique-column name='avalue1'/>
                  <unique-column name='avalue2'/>
                </unique>
              </table>
            </database>""";

        createDatabase(model1Xml);

        insertRow("roundtrip", new Object[]{(1), (2)});

        alterDatabase(model2Xml);

        assertEquals(getAdjustedModel(), readModelFromDatabase("roundtriptest"));

        List<TableRow> rows = getRows("roundtrip");

        assertEquals((2), rows.get(0), "avalue1");
        assertEquals((1), rows.get(0), "avalue2");
    }

    /**
     * Tests the insertion of a required column with a default value into an unique index.
     */
    public void testInsertRequiredColumnWithDefaultIntoUniqueIndex() {
        if (!getPlatformInfo().isIndicesSupported()) {
            return;
        }

        final String model1Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip'>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
                <column name='avalue1' type='INTEGER'/>
                <unique name='test'>
                  <unique-column name='avalue1'/>
                </unique>
              </table>
            </database>""";
        final String model2Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip'>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
                <column name='avalue2' type='CHAR' size='8' default='text' required='true'/>
                <column name='avalue1' type='INTEGER'/>
                <unique name='test'>
                  <unique-column name='avalue1'/>
                  <unique-column name='avalue2'/>
                </unique>
              </table>
            </database>""";

        createDatabase(model1Xml);

        insertRow("roundtrip", new Object[]{(1), (2)});

        alterDatabase(model2Xml);

        assertEquals(getAdjustedModel(), readModelFromDatabase("roundtriptest"));

        List<TableRow> rows = getRows("roundtrip");
        Object avalue2 = rows.get(0).getColumnValue("avalue2");

        assertEquals((2), rows.get(0), "avalue1");
        if (BuiltinDBType.MYSQL.getName().equals(getPlatform().getName()) || BuiltinDBType.MYSQL5.getName().equals(getPlatform().getName()) || BuiltinDBType.HSQLDB.getName().equals(getPlatform().getName()) || BuiltinDBType.MAXDB.getName().equals(getPlatform().getName())) {
            // Some DBs ignore that the type is CHAR(8) and trim the value
            assertEquals("text", avalue2);
        } else {
            assertEquals("text    ", avalue2);
        }
    }

    /**
     * Tests the insertion of multiple columns into a unique index.
     */
    public void testAddAndInsertMultipleColumnsIntoUniqueIndex() {
        if (!getPlatformInfo().isIndicesSupported()) {
            return;
        }

        final String model1Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip'>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
                <column name='avalue1' type='INTEGER'/>
                <unique name='test'>
                  <unique-column name='avalue1'/>
                </unique>
              </table>
            </database>""";
        final String model2Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip'>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
                <column name='avalue2' type='INTEGER' default='3'/>
                <column name='avalue1' type='INTEGER'/>
                <column name='avalue3' type='DOUBLE' required='true'/>
                <unique name='test'>
                  <unique-column name='avalue1'/>
                  <unique-column name='avalue2'/>
                  <unique-column name='avalue3'/>
                </unique>
              </table>
            </database>""";

        createDatabase(model1Xml);

        insertRow("roundtrip", new Object[]{(1), (2)});

        alterDatabase(model2Xml);

        assertEquals(getAdjustedModel(), readModelFromDatabase("roundtriptest"));

        assertTrue(getRows("roundtrip").isEmpty());
    }

    /**
     * Tests the insertion of a foreign key and its local column.
     */
    public void testInsertFKAndLocalColumn() {
        final String model1Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip1'>
                <column name='pk' type='VARCHAR' size='32' primaryKey='true' required='true'/>
              </table>
              <table name='roundtrip2'>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
              </table>
            </database>""";
        final String model2Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip1'>
                <column name='pk' type='VARCHAR' size='32' primaryKey='true' required='true'/>
              </table>
              <table name='roundtrip2'>
                <column name='avalue' type='VARCHAR' size='32'/>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
                <foreign-key foreignTable='roundtrip1'>
                  <reference local='avalue' foreign='pk'/>
                </foreign-key>
              </table>
            </database>""";

        createDatabase(model1Xml);

        insertRow("roundtrip1", new Object[]{"text"});
        insertRow("roundtrip2", new Object[]{(1)});

        alterDatabase(model2Xml);

        assertEquals(getAdjustedModel(), readModelFromDatabase("roundtriptest"));

        List<TableRow> beans1 = getRows("roundtrip1");
        List<TableRow> beans2 = getRows("roundtrip2");

        assertEquals((Object) "text", beans1.get(0), "pk");
        assertEquals((1), beans2.get(0), "pk");
        assertEquals((Object) null, beans2.get(0), "avalue");
    }

    /**
     * Tests the insertion of a foreign key and its local auto increment column.
     */
    public void testInsertFKAndLocalAutoIncrementColumn() {
        if (!getPlatformInfo().isNonPrimaryKeyIdentityColumnsSupported()) {
            return;
        }

        final String model1Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip1'>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
              </table>
              <table name='roundtrip2'>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
              </table>
            </database>""";
        final String model2Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip1'>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
              </table>
              <table name='roundtrip2'>
                <column name='avalue' type='INTEGER' autoIncrement='true'/>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
                <foreign-key foreignTable='roundtrip1'>
                  <reference local='avalue' foreign='pk'/>
                </foreign-key>
              </table>
            </database>""";

        createDatabase(model1Xml);

        insertRow("roundtrip1", new Object[]{(1)});
        insertRow("roundtrip2", new Object[]{(2)});

        alterDatabase(model2Xml);

        assertEquals(getAdjustedModel(), readModelFromDatabase("roundtriptest"));

        List<TableRow> beans1 = getRows("roundtrip1");
        List<TableRow> beans2 = getRows("roundtrip2");

        assertEquals((1), beans1.get(0), "pk");
        assertEquals((2), beans2.get(0), "pk");
        assertEquals((1), beans2.get(0), "avalue");
    }

    /**
     * Tests the insertion of a foreign key and its local required column.
     */
    public void testInsertFKAndLocalRequiredColumn() {
        final String model1Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip1'>
                <column name='pk' type='NUMERIC' size='12,0' primaryKey='true' required='true'/>
              </table>
              <table name='roundtrip2'>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
              </table>
            </database>""";
        final String model2Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip1'>
                <column name='pk' type='NUMERIC' size='12,0' primaryKey='true' required='true'/>
              </table>
              <table name='roundtrip2'>
                <column name='avalue' type='NUMERIC' size='12,0' required='true'/>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
                <foreign-key foreignTable='roundtrip1'>
                  <reference local='avalue' foreign='pk'/>
                </foreign-key>
              </table>
            </database>""";

        createDatabase(model1Xml);

        insertRow("roundtrip1", new Object[]{new BigDecimal(1)});
        insertRow("roundtrip2", new Object[]{(2)});

        alterDatabase(model2Xml);

        assertEquals(getAdjustedModel(), readModelFromDatabase("roundtriptest"));

        List<TableRow> beans1 = getRows("roundtrip1");
        List<TableRow> beans2 = getRows("roundtrip2");

        assertEquals(new BigDecimal(1), beans1.get(0), "pk");
        assertTrue(beans2.isEmpty());
    }

    /**
     * Tests the insertion of a foreign key and its local column with a default value.
     */
    public void testInsertFKAndLocalColumnWithDefault() {
        final String model1Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip1'>
                <column name='pk' type='DOUBLE' primaryKey='true' required='true'/>
              </table>
              <table name='roundtrip2'>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
              </table>
            </database>""";
        final String model2Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip1'>
                <column name='pk' type='DOUBLE' primaryKey='true' required='true'/>
              </table>
              <table name='roundtrip2'>
                <column name='avalue' type='DOUBLE' default='1'/>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
                <foreign-key foreignTable='roundtrip1'>
                  <reference local='avalue' foreign='pk'/>
                </foreign-key>
              </table>
            </database>""";

        createDatabase(model1Xml);

        insertRow("roundtrip1", new Object[]{1.0});
        insertRow("roundtrip2", new Object[]{(2)});

        alterDatabase(model2Xml);

        assertEquals(getAdjustedModel(), readModelFromDatabase("roundtriptest"));

        List<TableRow> beans1 = getRows("roundtrip1");
        List<TableRow> beans2 = getRows("roundtrip2");

        assertEquals(1.0, beans1.get(0), "pk");
        assertEquals((2), beans2.get(0), "pk");
        assertEquals(1.0, beans2.get(0), "avalue");
    }

    /**
     * Tests the insertion of a foreign key and its local required auto increment column.
     */
    public void testInsertFKAndLocalRequiredAutoIncrementColumn() {
        if (!getPlatformInfo().isNonPrimaryKeyIdentityColumnsSupported()) {
            return;
        }

        final String model1Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip1'>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
              </table>
              <table name='roundtrip2'>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
              </table>
            </database>""";
        final String model2Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip1'>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
              </table>
              <table name='roundtrip2'>
                <column name='avalue' type='INTEGER' required='true' autoIncrement='true'/>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
                <foreign-key foreignTable='roundtrip1'>
                  <reference local='avalue' foreign='pk'/>
                </foreign-key>
              </table>
            </database>""";

        createDatabase(model1Xml);

        insertRow("roundtrip1", new Object[]{(1)});
        insertRow("roundtrip2", new Object[]{(2)});

        alterDatabase(model2Xml);

        assertEquals(getAdjustedModel(), readModelFromDatabase("roundtriptest"));

        List<TableRow> beans1 = getRows("roundtrip1");
        List<TableRow> beans2 = getRows("roundtrip2");

        assertEquals((1), beans1.get(0), "pk");
        assertEquals((2), beans2.get(0), "pk");
        assertEquals((1), beans2.get(0), "avalue");
    }

    /**
     * Tests the insertion of a foreign key and its local required column with a default value.
     */
    public void testInsertFKAndLocalRequiredColumnWithDefault() {
        final String model1Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip1'>
                <column name='pk' type='CHAR' size='8' primaryKey='true' required='true'/>
              </table>
              <table name='roundtrip2'>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
              </table>
            </database>""";
        final String model2Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip1'>
                <column name='pk' type='CHAR' size='8' primaryKey='true' required='true'/>
              </table>
              <table name='roundtrip2'>
                <column name='avalue' type='CHAR' size='8' required='true' default='text'/>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
                <foreign-key foreignTable='roundtrip1'>
                  <reference local='avalue' foreign='pk'/>
                </foreign-key>
              </table>
            </database>""";

        createDatabase(model1Xml);

        insertRow("roundtrip1", new Object[]{"text"});
        insertRow("roundtrip2", new Object[]{(1)});

        alterDatabase(model2Xml);

        assertEquals(getAdjustedModel(), readModelFromDatabase("roundtriptest"));

        List<TableRow> beans1 = getRows("roundtrip1");
        List<TableRow> beans2 = getRows("roundtrip2");
        Object pk1 = beans1.get(0).getColumnValue("pk");
        Object avalue = beans2.get(0).getColumnValue("avalue");

        assertEquals((1), beans2.get(0), "pk");
        if (BuiltinDBType.MYSQL.getName().equals(getPlatform().getName()) || BuiltinDBType.MYSQL5.getName().equals(getPlatform().getName()) || BuiltinDBType.HSQLDB.getName().equals(getPlatform().getName()) || BuiltinDBType.MAXDB.getName().equals(getPlatform().getName())) {
            // Some DBs ignore that the type is CHAR(8) and trim the value
            assertEquals("text", pk1);
            assertEquals("text", avalue);
        } else {
            // TODO
            //assertTrue((avalue == null) || "text    ".equals(avalue));
            assertEquals("text    ", pk1);
            assertEquals("text    ", avalue);
        }
    }

    /**
     * Tests the insertion of a foreign key and its local columns.
     */
    public void testAddAndInsertFKAndMultipleLocalColumns() {
        final String model1Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip1'>
                <column name='pk1' type='INTEGER' primaryKey='true' required='true'/>
                <column name='pk2' type='DOUBLE' primaryKey='true' required='true'/>
              </table>
              <table name='roundtrip2'>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
              </table>
            </database>""";
        final String model2Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip1'>
                <column name='pk1' type='INTEGER' primaryKey='true' required='true'/>
                <column name='pk2' type='DOUBLE' primaryKey='true' required='true'/>
              </table>
              <table name='roundtrip2'>
                <column name='avalue1' type='INTEGER' default='1'/>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
                <column name='avalue2' type='DOUBLE' required='true'/>
                <foreign-key foreignTable='roundtrip1'>
                  <reference local='avalue1' foreign='pk1'/>
                  <reference local='avalue2' foreign='pk2'/>
                </foreign-key>
              </table>
            </database>""";

        createDatabase(model1Xml);

        insertRow("roundtrip1", new Object[]{(1), 2.0});
        insertRow("roundtrip2", new Object[]{(3)});

        alterDatabase(model2Xml);

        assertEquals(getAdjustedModel(), readModelFromDatabase("roundtriptest"));

        List<TableRow> beans1 = getRows("roundtrip1");
        List<TableRow> beans2 = getRows("roundtrip2");

        assertEquals((1), beans1.get(0), "pk1");
        assertEquals(2.0, beans1.get(0), "pk2");
        assertTrue(beans2.isEmpty());
    }

    /**
     * Tests the insertion of a foreign key and its foreign column.
     */
    public void testInsertFKAndForeignColumn() {
        final String model1Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip1'>
                <column name='avalue' type='INTEGER'/>
              </table>
              <table name='roundtrip2'>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
                <column name='avalue' type='VARCHAR' size='32'/>
              </table>
            </database>""";
        final String model2Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip1'>
                <column name='avalue' type='INTEGER'/>
                <column name='pk' type='VARCHAR' size='32' primaryKey='true' required='true'/>
              </table>
              <table name='roundtrip2'>
                <column name='avalue' type='VARCHAR' size='32'/>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
                <foreign-key foreignTable='roundtrip1'>
                  <reference local='avalue' foreign='pk'/>
                </foreign-key>
              </table>
            </database>""";

        createDatabase(model1Xml);
        // no point trying this with data in the db as it will only cause a constraint violation
        alterDatabase(model2Xml);

        assertEquals(getAdjustedModel(), readModelFromDatabase("roundtriptest"));
    }

    /**
     * Tests the insertion of a foreign key and its foreign auto increment column.
     */
    public void testInsertFKAndForeignAutoIncrementColumn() {
        final String model1Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip1'>
                <column name='avalue' type='INTEGER'/>
              </table>
              <table name='roundtrip2'>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
                <column name='avalue' type='INTEGER'/>
              </table>
            </database>""";
        final String model2Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip1'>
                <column name='pk' type='INTEGER' primaryKey='true' autoIncrement='true'/>
                <column name='avalue' type='INTEGER'/>
              </table>
              <table name='roundtrip2'>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
                <column name='avalue' type='INTEGER'/>
                <foreign-key foreignTable='roundtrip1'>
                  <reference local='avalue' foreign='pk'/>
                </foreign-key>
              </table>
            </database>""";

        createDatabase(model1Xml);

        insertRow("roundtrip1", new Object[]{(2)});
        insertRow("roundtrip2", new Object[]{(1), (1)});

        alterDatabase(model2Xml);

        assertEquals(getAdjustedModel(), readModelFromDatabase("roundtriptest"));

        List<TableRow> beans1 = getRows("roundtrip1");
        List<TableRow> beans2 = getRows("roundtrip2");

        assertEquals((1), beans1.get(0), "pk");
        assertEquals((2), beans1.get(0), "avalue");
        assertEquals((1), beans2.get(0), "pk");
        assertEquals((1), beans2.get(0), "avalue");
    }

    /**
     * Tests the insertion of a foreign key and its foreign auto increment column.
     */
    public void testInsertFKAndForeignColumnWithDefault() {
        final String model1Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip1'>
                <column name='avalue' type='INTEGER'/>
              </table>
              <table name='roundtrip2'>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
                <column name='avalue' type='DOUBLE'/>
              </table>
            </database>""";
        final String model2Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip1'>
                <column name='pk' type='DOUBLE' primaryKey='true' required='true' default='1'/>
                <column name='avalue' type='INTEGER'/>
              </table>
              <table name='roundtrip2'>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
                <column name='avalue' type='DOUBLE'/>
                <foreign-key foreignTable='roundtrip1'>
                  <reference local='avalue' foreign='pk'/>
                </foreign-key>
              </table>
            </database>""";

        createDatabase(model1Xml);

        insertRow("roundtrip1", new Object[]{(2)});
        insertRow("roundtrip2", new Object[]{(1), 1.0});

        alterDatabase(model2Xml);

        assertEquals(getAdjustedModel(), readModelFromDatabase("roundtriptest"));

        List<TableRow> beans1 = getRows("roundtrip1");
        List<TableRow> beans2 = getRows("roundtrip2");

        assertEquals(1.0, beans1.get(0), "pk");
        assertEquals((2), beans1.get(0), "avalue");
        assertEquals((1), beans2.get(0), "pk");
        assertEquals(1.0, beans2.get(0), "avalue");
    }

    /**
     * Tests the insertion of a foreign key and its multiple foreign columns.
     */
    public void testAddAndInsertFKAndMultipleForeignColumns() {
        final String model1Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip1'>
                <column name='avalue' type='INTEGER'/>
              </table>
              <table name='roundtrip2'>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
                <column name='avalue1' type='INTEGER'/>
                <column name='avalue2' type='DOUBLE'/>
              </table>
            </database>""";
        final String model2Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip1'>
                <column name='pk2' type='DOUBLE' primaryKey='true' required='true' default='1'/>
                <column name='avalue' type='INTEGER'/>
                <column name='pk1' type='INTEGER' primaryKey='true' required='true'/>
              </table>
              <table name='roundtrip2'>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
                <column name='avalue1' type='INTEGER'/>
                <column name='avalue2' type='DOUBLE'/>
                <foreign-key foreignTable='roundtrip1'>
                  <reference local='avalue2' foreign='pk2'/>
                  <reference local='avalue1' foreign='pk1'/>
                </foreign-key>
              </table>
            </database>""";

        createDatabase(model1Xml);
        // no point trying this with data in the db as it will only cause a constraint violation
        alterDatabase(model2Xml);

        assertEquals(getAdjustedModel(), readModelFromDatabase("roundtriptest"));
    }

    /**
     * Tests the insertion of local and foreign column into a foreign key.
     */
    public void testInsertColumnsIntoFK() {
        final String model1Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip1'>
                <column name='pk1' type='INTEGER' primaryKey='true' required='true'/>
              </table>
              <table name='roundtrip2'>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
                <column name='avalue1' type='INTEGER'/>
                <foreign-key foreignTable='roundtrip1'>
                  <reference local='avalue1' foreign='pk1'/>
                </foreign-key>
              </table>
            </database>""";
        final String model2Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip1'>
                <column name='pk2' type='VARCHAR' size='32' primaryKey='true' required='true'/>
                <column name='pk1' type='INTEGER' primaryKey='true' required='true'/>
              </table>
              <table name='roundtrip2'>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
                <column name='avalue2' type='VARCHAR' size='32'/>
                <column name='avalue1' type='INTEGER'/>
                <foreign-key foreignTable='roundtrip1'>
                  <reference local='avalue2' foreign='pk2'/>
                  <reference local='avalue1' foreign='pk1'/>
                </foreign-key>
              </table>
            </database>""";

        createDatabase(model1Xml);
        // no point trying this with data in the db as it will only cause a constraint violation
        alterDatabase(model2Xml);

        assertEquals(getAdjustedModel(), readModelFromDatabase("roundtriptest"));
    }

    /**
     * Tests the insertion of local and foreign auto increment columns into a foreign key.
     */
    public void testInsertAutoIncrementColumnIntoFK() {
        if (!getPlatformInfo().isNonPrimaryKeyIdentityColumnsSupported()) {
            return;
        }

        final String model1Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip1'>
                <column name='pk1' type='INTEGER' primaryKey='true' required='true'/>
              </table>
              <table name='roundtrip2'>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
                <column name='avalue1' type='INTEGER'/>
                <foreign-key foreignTable='roundtrip1'>
                  <reference local='avalue1' foreign='pk1'/>
                </foreign-key>
              </table>
            </database>""";
        final String model2Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip1'>
                <column name='pk2' type='INTEGER' primaryKey='true' autoIncrement='true'/>
                <column name='pk1' type='INTEGER' primaryKey='true' required='true'/>
              </table>
              <table name='roundtrip2'>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
                <column name='avalue2' type='INTEGER' autoIncrement='true'/>
                <column name='avalue1' type='INTEGER'/>
                <foreign-key foreignTable='roundtrip1'>
                  <reference local='avalue2' foreign='pk2'/>
                  <reference local='avalue1' foreign='pk1'/>
                </foreign-key>
              </table>
            </database>""";

        createDatabase(model1Xml);

        insertRow("roundtrip1", new Object[]{(1)});
        insertRow("roundtrip2", new Object[]{(2), (1)});

        alterDatabase(model2Xml);

        assertEquals(getAdjustedModel(), readModelFromDatabase("roundtriptest"));

        List<TableRow> beans1 = getRows("roundtrip1");
        List<TableRow> beans2 = getRows("roundtrip2");

        assertEquals((1), beans1.get(0), "pk1");
        assertEquals((1), beans1.get(0), "pk2");
        assertEquals((2), beans2.get(0), "pk");
        assertEquals((1), beans2.get(0), "avalue1");
        assertEquals((1), beans2.get(0), "avalue2");
    }

    /**
     * Tests the insertion of local and foreign required columns into a foreign key.
     */
    public void testInsertRequiredColumnsIntoFK() {
        final String model1Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip1'>
                <column name='pk1' type='INTEGER' primaryKey='true' required='true'/>
              </table>
              <table name='roundtrip2'>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
                <column name='avalue1' type='INTEGER'/>
                <foreign-key foreignTable='roundtrip1'>
                  <reference local='avalue1' foreign='pk1'/>
                </foreign-key>
              </table>
            </database>""";
        final String model2Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip1'>
                <column name='pk2' type='NUMERIC' size='12,0' primaryKey='true' required='true'/>
                <column name='pk1' type='INTEGER' primaryKey='true' required='true'/>
              </table>
              <table name='roundtrip2'>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
                <column name='avalue2' type='NUMERIC' size='12,0' required='true'/>
                <column name='avalue1' type='INTEGER'/>
                <foreign-key foreignTable='roundtrip1'>
                  <reference local='avalue2' foreign='pk2'/>
                  <reference local='avalue1' foreign='pk1'/>
                </foreign-key>
              </table>
            </database>""";

        createDatabase(model1Xml);
        // no point trying this with data in the db as it will only cause a constraint violation
        alterDatabase(model2Xml);

        assertEquals(getAdjustedModel(), readModelFromDatabase("roundtriptest"));
    }

    /**
     * Tests the insertion of local and foreign columns with default values into a foreign key.
     */
    public void testInsertColumnsWithDefaultsIntoFK() {
        if (getPlatformInfo().isPrimaryKeyColumnsHaveToBeRequired()) {
            return;
        }

        final String model1Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip1'>
                <column name='pk1' type='INTEGER' primaryKey='true' required='true'/>
              </table>
              <table name='roundtrip2'>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
                <column name='avalue1' type='INTEGER'/>
                <foreign-key foreignTable='roundtrip1'>
                  <reference local='avalue1' foreign='pk1'/>
                </foreign-key>
              </table>
            </database>""";
        final String model2Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip1'>
                <column name='pk2' type='DOUBLE' primaryKey='true' default='2'/>
                <column name='pk1' type='INTEGER' primaryKey='true' required='true'/>
              </table>
              <table name='roundtrip2'>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
                <column name='avalue2' type='DOUBLE' default='2'/>
                <column name='avalue1' type='INTEGER'/>
                <foreign-key foreignTable='roundtrip1'>
                  <reference local='avalue2' foreign='pk2'/>
                  <reference local='avalue1' foreign='pk1'/>
                </foreign-key>
              </table>
            </database>""";

        createDatabase(model1Xml);

        insertRow("roundtrip1", new Object[]{(1)});
        insertRow("roundtrip2", new Object[]{(2), (1)});

        alterDatabase(model2Xml);

        List<TableRow> beans1 = getRows("roundtrip1");
        List<TableRow> beans2 = getRows("roundtrip2");

        assertEquals((1), beans1.get(0), "pk1");
        assertEquals(2.0, beans1.get(0), "pk2");
        assertEquals((2), beans2.get(0), "pk");
        assertEquals((1), beans2.get(0), "avalue1");
        assertEquals(2.0, beans2.get(0), "avalue2");
    }

    /**
     * Tests the insertion of local and foreign required auto increment columns into a foreign key.
     */
    public void testInsertRequiredAutoIncrementColumnIntoFK() {
        if (!getPlatformInfo().isNonPrimaryKeyIdentityColumnsSupported()) {
            return;
        }

        final String model1Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip1'>
                <column name='pk1' type='INTEGER' primaryKey='true' required='true'/>
              </table>
              <table name='roundtrip2'>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
                <column name='avalue1' type='INTEGER'/>
                <foreign-key foreignTable='roundtrip1'>
                  <reference local='avalue1' foreign='pk1'/>
                </foreign-key>
              </table>
            </database>""";
        final String model2Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip1'>
                <column name='pk2' type='INTEGER' primaryKey='true' required='true' autoIncrement='true'/>
                <column name='pk1' type='INTEGER' primaryKey='true' required='true'/>
              </table>
              <table name='roundtrip2'>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
                <column name='avalue2' type='INTEGER' required='true' autoIncrement='true'/>
                <column name='avalue1' type='INTEGER'/>
                <foreign-key foreignTable='roundtrip1'>
                  <reference local='avalue2' foreign='pk2'/>
                  <reference local='avalue1' foreign='pk1'/>
                </foreign-key>
              </table>
            </database>""";

        createDatabase(model1Xml);

        insertRow("roundtrip1", new Object[]{(1)});
        insertRow("roundtrip2", new Object[]{(2), (1)});

        alterDatabase(model2Xml);

        assertEquals(getAdjustedModel(), readModelFromDatabase("roundtriptest"));

        List<TableRow> beans1 = getRows("roundtrip1");
        List<TableRow> beans2 = getRows("roundtrip2");

        assertEquals((1), beans1.get(0), "pk1");
        assertEquals((1), beans1.get(0), "pk2");
        assertEquals((2), beans2.get(0), "pk");
        assertEquals((1), beans2.get(0), "avalue1");
        assertEquals((1), beans2.get(0), "avalue2");
    }

    /**
     * Tests the insertion of local and foreign required columns with default values into a foreign key.
     */
    public void testInsertRequiredColumnsWithDefaultsIntoFK() {
        final String model1Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip1'>
                <column name='pk1' type='INTEGER' primaryKey='true' required='true'/>
              </table>
              <table name='roundtrip2'>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
                <column name='avalue1' type='INTEGER'/>
                <foreign-key foreignTable='roundtrip1'>
                  <reference local='avalue1' foreign='pk1'/>
                </foreign-key>
              </table>
            </database>""";
        final String model2Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip1'>
                <column name='pk2' type='CHAR' size='8' primaryKey='true' required='true' default='text'/>
                <column name='pk1' type='INTEGER' primaryKey='true' required='true'/>
              </table>
              <table name='roundtrip2'>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
                <column name='avalue2' type='CHAR' size='8' required='true' default='text'/>
                <column name='avalue1' type='INTEGER'/>
                <foreign-key foreignTable='roundtrip1'>
                  <reference local='avalue2' foreign='pk2'/>
                  <reference local='avalue1' foreign='pk1'/>
                </foreign-key>
              </table>
            </database>""";

        createDatabase(model1Xml);

        insertRow("roundtrip1", new Object[]{(1)});
        insertRow("roundtrip2", new Object[]{(2), (1)});

        alterDatabase(model2Xml);

        List<TableRow> beans1 = getRows("roundtrip1");
        List<TableRow> beans2 = getRows("roundtrip2");
        Object pk2 = beans1.get(0).getColumnValue("pk2");
        Object avalue2 = beans2.get(0).getColumnValue("avalue2");

        assertEquals((1), beans1.get(0), "pk1");
        assertEquals((2), beans2.get(0), "pk");
        assertEquals((1), beans2.get(0), "avalue1");
        if (BuiltinDBType.MYSQL.getName().equals(getPlatform().getName()) || BuiltinDBType.MYSQL5.getName().equals(getPlatform().getName()) || BuiltinDBType.HSQLDB.getName().equals(getPlatform().getName()) || BuiltinDBType.MAXDB.getName().equals(getPlatform().getName())) {
            // Some DBs ignore that the type is CHAR(8) and trim the value
            assertEquals("text", pk2);
            assertEquals("text", avalue2);
        } else {
            assertEquals("text    ", pk2);
            assertEquals("text    ", avalue2);
        }
    }

    /**
     * Tests the insertion of multiple local and foreign columns into a foreign key.
     */
    public void testAddAndInsertMultipleColumnsIntoFK() {
        final String model1Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip1'>
                <column name='pk1' type='INTEGER' primaryKey='true' required='true'/>
              </table>
              <table name='roundtrip2'>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
                <column name='avalue1' type='INTEGER'/>
                <foreign-key foreignTable='roundtrip1'>
                  <reference local='avalue1' foreign='pk1'/>
                </foreign-key>
              </table>
            </database>""";
        final String model2Xml = """
            <?xml version='1.0' encoding='ISO-8859-1'?>
            <database xmlns='http://db.apache.org/ddlutils/schema/1.1' name='roundtriptest'>
              <table name='roundtrip1'>
                <column name='pk3' type='DOUBLE' primaryKey='true' required='true'/>
                <column name='pk1' type='INTEGER' primaryKey='true' required='true'/>
                <column name='pk2' type='INTEGER' primaryKey='true' default='1' required='true'/>
              </table>
              <table name='roundtrip2'>
                <column name='avalue3' type='DOUBLE' required='true'/>
                <column name='pk' type='INTEGER' primaryKey='true' required='true'/>
                <column name='avalue1' type='INTEGER'/>
                <column name='avalue2' type='INTEGER' default='1'/>
                <foreign-key foreignTable='roundtrip1'>
                  <reference local='avalue3' foreign='pk3'/>
                  <reference local='avalue1' foreign='pk1'/>
                  <reference local='avalue2' foreign='pk2'/>
                </foreign-key>
              </table>
            </database>""";

        createDatabase(model1Xml);
        // no point trying this with data in the db as it will only cause a constraint violation
        alterDatabase(model2Xml);

        assertEquals(getAdjustedModel(), readModelFromDatabase("roundtriptest"));
    }
}
