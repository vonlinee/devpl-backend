package io.devpl.codegen.parser.sql;

import lombok.Getter;
import lombok.Setter;

/**
 * 不包含INSERT字段的值，可能有批量插入
 */
@Getter
@Setter
public class InsertColumn extends SqlColumn {

    private String insertValue;
}
