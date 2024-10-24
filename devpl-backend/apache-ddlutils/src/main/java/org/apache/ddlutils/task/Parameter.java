package org.apache.ddlutils.task;

import org.apache.ddlutils.PlatformFactory;

import java.util.HashSet;
import java.util.Set;

/**
 * Specifies a parameter for the creation of the database. These are usually platform specific.
 * A parameter consists of a name-value pair and an optional list of platforms for which the
 * parameter shall be used.
 */
public class Parameter {
    /**
     * The platforms for which this parameter is applicable.
     */
    private final Set<String> _platforms = new HashSet<>();
    /**
     * The name.
     */
    private String _name;
    /**
     * The value.
     */
    private String _value;

    /**
     * Returns the name.
     *
     * @return The name
     */
    public String getName() {
        return _name;
    }

    /**
     * Specifies the name of the parameter. See the database support documentation
     * for details on the parameters supported by the individual platforms.
     *
     * @param name The name
     */
    public void setName(String name) {
        _name = name;
    }

    /**
     * Returns the value.
     *
     * @return The value
     */
    public String getValue() {
        return _value;
    }

    /**
     * Specifies the parameter value.
     *
     * @param value The value
     *              If none is given, <code>null</code> is used.
     */
    public void setValue(String value) {
        _value = value;
    }

    /**
     * Specifies the platforms - a comma-separated list of platform names - for which this parameter
     * shall be used (see the <code>databaseType</code> attribute of the tasks for possible values).
     * For every platform not in this list, the parameter is ignored.
     *
     * @param platforms The platforms
     *                  If not specified then the parameter is processed for every platform.
     */
    public void setPlatforms(String platforms) {
        _platforms.clear();
        if (platforms != null && !platforms.isEmpty()) {
            for (String platform : platforms.split(",")) {
                platform = platform.trim();
                if (PlatformFactory.isPlatformSupported(platform)) {
                    _platforms.add(platform.toLowerCase());
                } else {
                    throw new IllegalArgumentException("Platform " + platform + " is not supported");
                }
            }
        }
    }

    /**
     * Determines whether this parameter is applicable for the indicated platform.
     *
     * @param platformName The platform name
     * @return <code>true</code> if this parameter is defined for the platform
     */
    public boolean isForPlatform(String platformName) {
        return _platforms.isEmpty() || _platforms.contains(platformName.toLowerCase());
    }
}
