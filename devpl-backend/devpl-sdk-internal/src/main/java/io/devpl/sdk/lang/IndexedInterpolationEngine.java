package io.devpl.sdk.lang;

import java.util.regex.Pattern;

public class IndexedInterpolationEngine extends PatternInterpolationEngine {
    private static final Pattern PATTERN = Pattern.compile("\\{([0-9]+)}");

    public IndexedInterpolationEngine() {
        super(PATTERN);
    }

    public static Bindings createBindings(Object... array) {
        return new Bindings.Array(array);
    }
}
