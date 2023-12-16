package io.devpl.codegen.config;

/**
 * SQL like 枚举
 *
 * @author Caratacus
 * @since 2016-12-4
 */
public enum SqlLike {
    /**
     * %值
     */
    LEFT,
    /**
     * 值%
     */
    RIGHT,
    /**
     * %值%
     */
    DEFAULT
}