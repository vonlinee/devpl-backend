package io.devpl.backend.domain.enums;

import com.baomidou.mybatisplus.test.type.DataType;
import lombok.Getter;

import java.util.Arrays;

/**
 * MyBatis Mapper Statement 参数值类型
 */
public enum MapperStatementParamValueType implements DataType {

    NULL(-1, "Null"),
    BOOLEAN(1, "Boolean"),
    NUMERIC(2, "Numeric"),
    STRING(3, "String"),
    COLLECTION(4, "Collection");

    @Getter
    private final int type;
    private final String typeName;

    MapperStatementParamValueType(int type, String typeName) {
        this.type = type;
        this.typeName = typeName;
    }

    public static MapperStatementParamValueType valueOfTypeName(String typeName) {
        if (typeName == null) {
            return null;
        }
        for (MapperStatementParamValueType item : values()) {
            if (item.getQualifier().equals(typeName)) {
                return item;
            }
        }
        return null;
    }

    public static MapperStatementParamValueType valueOfType(int type, MapperStatementParamValueType defaultValue) {
        return Arrays.stream(values()).filter(i -> i.getType() == type).findFirst().orElse(defaultValue);
    }

    @Override
    public final String getQualifier() {
        return typeName;
    }
}