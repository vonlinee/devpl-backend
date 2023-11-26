package com.baomidou.mybatisplus.generator.engine;

import java.util.HashMap;
import java.util.Map;

/**
 * 模板参数Map
 */
public final class TemplateArgumentsMap extends HashMap<String, Object> implements TemplateArguments {

    @Override
    public Map<String, Object> asMap() {
        return this;
    }

    @Override
    public Object getValue(String name) {
        return get(name);
    }

    @Override
    public boolean isMap() {
        return true;
    }
}
