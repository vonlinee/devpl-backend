package io.devpl.common.interfaces.impl;

import io.devpl.common.interfaces.FieldParser;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

import java.util.*;

/**
 * 字段信息Map
 */
public final class FieldInfoMap implements Map<String, Object> {

    private final Map<String, Object> map;

    public FieldInfoMap() {
        this(new HashMap<>());
    }

    public FieldInfoMap(Map<String, Object> map) {
        this.map = map;
    }

    public void setFieldName(String fieldName) {
        map.put(FieldParser.FIELD_NAME, fieldName);
    }

    public String getFieldName() {
        return (String) map.get(FieldParser.FIELD_NAME);
    }

    public void setFieldKey(String fieldKey) {
        map.put(FieldParser.FIELD_KEY, fieldKey);
    }

    public String getFieldKey() {
        return (String) map.get(FieldParser.FIELD_KEY);
    }

    public void setFieldDescription(String description) {
        map.put(FieldParser.FIELD_DESCRIPTION, description);
    }

    public String getFieldDescription() {
        return (String) map.get(FieldParser.FIELD_DESCRIPTION);
    }

    public void setFieldDataType(String dataType) {
        map.put(FieldParser.FIELD_TYPE, dataType);
    }

    public String getFieldDataType() {
        return (String) map.get(FieldParser.FIELD_TYPE);
    }

    public void setFieldValue(String value) {
        map.put(FieldParser.FIELD_VALUE, value);
    }

    public String getFieldValue(String value) {
        return String.valueOf(map.get(FieldParser.FIELD_VALUE));
    }

    public Map<String, Object> asMap() {
        return map;
    }

    public static List<FieldInfoMap> wrap(List<Map<String, Object>> list) {
        return list.stream().map(FieldInfoMap::new).toList();
    }

    @Override
    public int size() {
        return map.size();
    }

    @Override
    public boolean isEmpty() {
        return map.isEmpty();
    }

    @Override
    public boolean containsKey(Object key) {
        return map.containsKey(key);
    }

    @Override
    public boolean containsValue(Object value) {
        return map.containsValue(value);
    }

    @Override
    public Object get(Object key) {
        return map.get(key);
    }

    @Nullable
    @Override
    public Object put(String key, Object value) {
        return map.put(key, value);
    }

    @Override
    public Object remove(Object key) {
        return map.remove(key);
    }

    @Override
    public void putAll(@NotNull Map<? extends String, ?> m) {
        map.putAll(m);
    }

    @Override
    public void clear() {
        map.clear();
    }

    @NotNull
    @Override
    public Set<String> keySet() {
        return map.keySet();
    }

    @NotNull
    @Override
    public Collection<Object> values() {
        return map.values();
    }

    @NotNull
    @Override
    public Set<Entry<String, Object>> entrySet() {
        return map.entrySet();
    }
}
