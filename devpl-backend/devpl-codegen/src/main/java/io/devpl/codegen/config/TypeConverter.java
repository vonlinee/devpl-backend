package io.devpl.codegen.config;

import io.devpl.codegen.db.ColumnJavaType;

/**
 * 数据库字段类型转换
 *
 * @author hubin
 * @author hanchunlin
 * @since 2017-01-20
 */
public interface TypeConverter {

    /**
     * 执行类型转换
     *
     * @param globalConfig 全局配置
     * @param fieldType    字段类型
     * @return ignore
     */
    ColumnJavaType processTypeConvert(GlobalConfig globalConfig, String fieldType);
}