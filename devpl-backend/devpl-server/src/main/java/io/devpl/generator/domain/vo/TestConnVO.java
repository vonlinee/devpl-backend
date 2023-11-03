package io.devpl.generator.domain.vo;

import lombok.Data;

/**
 * 类似Idea的测试连接结果
 */
@Data
public class TestConnVO {

    /**
     * 是否失败
     */
    private boolean failed;

    /**
     * 数据库类型
     */
    private String dbmsType;

    /**
     * 是否使用ssl连接
     */
    private boolean useSsl;

    /**
     * 连接失败时的错误信息
     */
    private String errorMsg;
}