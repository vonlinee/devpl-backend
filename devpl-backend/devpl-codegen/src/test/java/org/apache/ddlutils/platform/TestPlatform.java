package org.apache.ddlutils.platform;

/**
 * Platform implementation that makes the base functionality available without
 * overriding anything.
 */
public class TestPlatform extends PlatformImplBase {
    /**
     * Creates a new test platform instance.
     */
    public TestPlatform() {
        setSqlBuilder(new SqlBuilder(this) {
        });
    }

    @Override
    public DBType getDBType() {
        return () -> "TestPlatform";
    }
}