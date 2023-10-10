SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for connection_config
-- ----------------------------
DROP TABLE IF EXISTS `connection_config`;
CREATE TABLE `connection_config`
(
    `id`       varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci  NOT NULL COMMENT '主键ID',
    `name`     varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '连接名称',
    `host`     varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '主机地址，IP地址',
    `port`     varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '端口号',
    `db_type`  varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '数据库类型',
    `db_name`  varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '数据库名称',
    `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户名',
    `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '密码',
    `encoding` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '连接编码',
    PRIMARY KEY (`id`) USING BTREE,
    UNIQUE INDEX `unk_conn_name` (`name`) USING BTREE,
    UNIQUE INDEX `unk_ip_port` (`host`, `port`) USING BTREE
) ENGINE = InnoDB
  CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_general_ci COMMENT = '连接配置表'
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of connection_config
-- ----------------------------
INSERT INTO `connection_config`
VALUES ('01H320PDJQGCW97923WYYYJESA', '127.0.0.1_3306', '127.0.0.1', '3307', 'MySQL8', 'MYSQL5', 'null', 'root',
        '123456');
INSERT INTO `connection_config`
VALUES ('9c4c93ee-c0d6-4b10-b83d-2702756c6d11', '127.0.0.1-3306-MySQL5', '127.0.0.1', '3306', 'MySQL5', NULL, 'root',
        '123456', 'utf8');

-- ----------------------------
-- Table structure for data_type_mapping
-- ----------------------------
DROP TABLE IF EXISTS `data_type_mapping`;
CREATE TABLE `data_type_mapping`
(
    `id`       int(11)                                                       NOT NULL COMMENT '主键ID',
    `sql_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_general_ci
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of data_type_mapping
-- ----------------------------

-- ----------------------------
-- Table structure for dbs
-- ----------------------------
DROP TABLE IF EXISTS `dbs`;
CREATE TABLE `dbs`
(
    `id`    bigint(20)                                                    NOT NULL AUTO_INCREMENT,
    `name`  varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `value` json                                                          NULL,
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 1
  CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_general_ci COMMENT = '数据库信息'
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of dbs
-- ----------------------------
INSERT INTO `dbs`
VALUES (2, 'mysql_learn', '{
    \"host\": \"127.0.0.1\",
    \"name\": \"mysql_learn\",
    \"port\": \"3306\",
    \"dbType\": \"MySQL5\",
    \"schema\": \"mysql_learn\",
    \"encoding\": \"utf8\",
    \"password\": \"123456\",
    \"username\": \"root\"
}');
INSERT INTO `dbs`
VALUES (3, 'ruoyi', '{
    \"host\": \"127.0.0.1\",
    \"name\": \"ruoyi\",
    \"port\": \"3306\",
    \"dbType\": \"MySQL5\",
    \"schema\": \"ruoyi\",
    \"encoding\": \"utf8\",
    \"password\": \"123456\",
    \"username\": \"root\"
}');

-- ----------------------------
-- Table structure for field_info
-- ----------------------------
DROP TABLE IF EXISTS `field_info`;
CREATE TABLE `field_info`
(
    `id`          bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    `field_key`  varchar(36)         NOT NULL COMMENT '字段Key',
    `field_name`  varchar(100) DEFAULT NULL COMMENT '字段名',
    `data_type`   varchar(100) DEFAULT NULL COMMENT '数据类型',
    `description` varchar(100) DEFAULT NULL COMMENT '描述信息',
    `field_value` varchar(100) DEFAULT NULL COMMENT '默认值',
    `create_time` datetime     DEFAULT NULL COMMENT '创建时间',
    `update_time` datetime     DEFAULT NULL COMMENT '更新时间',
    `is_deleted`  tinyint(1)   DEFAULT NULL COMMENT '是否删除',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_general_ci COMMENT ='字段信息表';

-- ----------------------------
-- Table structure for file_gen_group
-- ----------------------------
DROP TABLE IF EXISTS `file_gen_group`;
CREATE TABLE `file_gen_group`
(
    `group_id`       bigint(20)                                                    NOT NULL AUTO_INCREMENT COMMENT '主键id, 多个文件生成',
    `group_name`     varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '表名',
    `file_id`        varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成文件ID,关联template_file_generatioin表主键ID',
    `table_comment`  varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '说明',
    `author`         varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '作者',
    `email`          varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '邮箱',
    `package_name`   varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '项目包名',
    `version`        varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '项目版本号',
    `generator_type` tinyint(4)                                                    NULL DEFAULT NULL COMMENT '生成方式  0：zip压缩包   1：自定义目录',
    `backend_path`   varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '后端生成路径',
    `frontend_path`  varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '前端生成路径',
    `module_name`    varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '模块名',
    `function_name`  varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '功能名',
    `form_layout`    tinyint(4)                                                    NULL DEFAULT NULL COMMENT '表单布局  1：一列   2：两列',
    `datasource_id`  bigint(20)                                                    NULL DEFAULT NULL COMMENT '数据源ID',
    `baseclass_id`   bigint(20)                                                    NULL DEFAULT NULL COMMENT '基类ID',
    `create_time`    datetime                                                      NULL DEFAULT NULL COMMENT '创建时间',
    PRIMARY KEY (`group_id`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 1
  CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_general_ci COMMENT = '文件生成组记录表'
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of file_gen_group
-- ----------------------------

-- ----------------------------
-- Table structure for gen_base_class
-- ----------------------------
DROP TABLE IF EXISTS `gen_base_class`;
CREATE TABLE `gen_base_class`
(
    `id`           bigint(20)                                                    NOT NULL AUTO_INCREMENT COMMENT 'id',
    `package_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '基类包名',
    `code`         varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '基类编码',
    `fields`       varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '基类字段，多个用英文逗号分隔',
    `remark`       varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
    `create_time`  datetime                                                      NULL DEFAULT NULL COMMENT '创建时间',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 1
  CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_general_ci COMMENT = '基类管理'
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gen_base_class
-- ----------------------------
INSERT INTO `gen_base_class`
VALUES (1, 'net.maku.framework.mybatis.entity', 'BaseEntity',
        'id,creator,create_time,updater,update_time,version,deleted', '使用该基类，则需要表里有这些字段',
        '2023-06-30 10:25:16');

-- ----------------------------
-- Table structure for datasource_info
-- ----------------------------
DROP TABLE IF EXISTS `datasource_info`;
CREATE TABLE `datasource_info`
(
    `id`          bigint(20)                                                    NOT NULL AUTO_INCREMENT COMMENT 'id',
    `db_type`     varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '数据库类型',
    `conn_name`   varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '连接名',
    `conn_url`    varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'URL',
    `username`    varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户名',
    `password`    varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '密码',
    `create_time` datetime                                                      NULL DEFAULT NULL COMMENT '创建时间',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 1
  CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_general_ci COMMENT = '数据源管理'
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of datasource_info
-- ----------------------------
INSERT INTO `datasource_info`
VALUES (1, 'MySQL', 'lancoo',
        'jdbc:mysql://192.168.129.82:3306/lgdb_exam_management?useUnicode=true&characterEncoding=UTF-8&useSSL=true&serverTimezone=GMT%2B8',
        'root', 'LancooECP', '2023-08-01 09:34:10');

-- ----------------------------
-- Table structure for gen_field_type
-- ----------------------------
DROP TABLE IF EXISTS `gen_field_type`;
CREATE TABLE `gen_field_type`
(
    `id`           bigint(20)                                                    NOT NULL AUTO_INCREMENT COMMENT 'id',
    `column_type`  varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '字段类型',
    `attr_type`    varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '属性类型',
    `package_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '属性包名',
    `create_time`  datetime                                                      NULL DEFAULT NULL COMMENT '创建时间',
    PRIMARY KEY (`id`) USING BTREE,
    UNIQUE INDEX `column_type` (`column_type`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 1
  CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_general_ci COMMENT = '字段类型管理'
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gen_field_type
-- ----------------------------
INSERT INTO `gen_field_type`
VALUES (1, 'datetime', 'Date', 'java.util.Date', '2023-06-30 10:25:16');
INSERT INTO `gen_field_type`
VALUES (2, 'date', 'Date', 'java.util.Date', '2023-06-30 10:25:16');
INSERT INTO `gen_field_type`
VALUES (3, 'tinyint', 'Integer', NULL, '2023-06-30 10:25:16');
INSERT INTO `gen_field_type`
VALUES (4, 'smallint', 'Integer', NULL, '2023-06-30 10:25:16');
INSERT INTO `gen_field_type`
VALUES (5, 'mediumint', 'Integer', NULL, '2023-06-30 10:25:16');
INSERT INTO `gen_field_type`
VALUES (6, 'int', 'Integer', NULL, '2023-06-30 10:25:16');
INSERT INTO `gen_field_type`
VALUES (7, 'integer', 'Integer', NULL, '2023-06-30 10:25:16');
INSERT INTO `gen_field_type`
VALUES (8, 'bigint', 'Long', NULL, '2023-06-30 10:25:16');
INSERT INTO `gen_field_type`
VALUES (9, 'float', 'Float', NULL, '2023-06-30 10:25:16');
INSERT INTO `gen_field_type`
VALUES (10, 'double', 'Double', NULL, '2023-06-30 10:25:16');
INSERT INTO `gen_field_type`
VALUES (11, 'decimal', 'BigDecimal', 'java.math.BigDecimal', '2023-06-30 10:25:16');
INSERT INTO `gen_field_type`
VALUES (12, 'bit', 'Boolean', NULL, '2023-06-30 10:25:16');
INSERT INTO `gen_field_type`
VALUES (13, 'char', 'String', NULL, '2023-06-30 10:25:16');
INSERT INTO `gen_field_type`
VALUES (14, 'varchar', 'String', NULL, '2023-06-30 10:25:16');
INSERT INTO `gen_field_type`
VALUES (15, 'tinytext', 'String', NULL, '2023-06-30 10:25:16');
INSERT INTO `gen_field_type`
VALUES (16, 'text', 'String', NULL, '2023-06-30 10:25:16');
INSERT INTO `gen_field_type`
VALUES (17, 'mediumtext', 'String', NULL, '2023-06-30 10:25:16');
INSERT INTO `gen_field_type`
VALUES (18, 'longtext', 'String', NULL, '2023-06-30 10:25:16');
INSERT INTO `gen_field_type`
VALUES (19, 'timestamp', 'Date', 'java.util.Date', '2023-06-30 10:25:16');
INSERT INTO `gen_field_type`
VALUES (20, 'NUMBER', 'Integer', NULL, '2023-06-30 10:25:16');
INSERT INTO `gen_field_type`
VALUES (21, 'BINARY_INTEGER', 'Integer', NULL, '2023-06-30 10:25:16');
INSERT INTO `gen_field_type`
VALUES (22, 'BINARY_FLOAT', 'Float', NULL, '2023-06-30 10:25:16');
INSERT INTO `gen_field_type`
VALUES (23, 'BINARY_DOUBLE', 'Double', NULL, '2023-06-30 10:25:16');
INSERT INTO `gen_field_type`
VALUES (24, 'VARCHAR2', 'String', NULL, '2023-06-30 10:25:16');
INSERT INTO `gen_field_type`
VALUES (25, 'NVARCHAR', 'String', NULL, '2023-06-30 10:25:16');
INSERT INTO `gen_field_type`
VALUES (26, 'NVARCHAR2', 'String', NULL, '2023-06-30 10:25:16');
INSERT INTO `gen_field_type`
VALUES (27, 'CLOB', 'String', NULL, '2023-06-30 10:25:16');
INSERT INTO `gen_field_type`
VALUES (28, 'int8', 'Long', NULL, '2023-06-30 10:25:16');
INSERT INTO `gen_field_type`
VALUES (29, 'int4', 'Integer', NULL, '2023-06-30 10:25:16');
INSERT INTO `gen_field_type`
VALUES (30, 'int2', 'Integer', NULL, '2023-06-30 10:25:16');
INSERT INTO `gen_field_type`
VALUES (31, 'numeric', 'BigDecimal', 'java.math.BigDecimal', '2023-06-30 10:25:16');

-- ----------------------------
-- Table structure for gen_project_modify
-- ----------------------------
DROP TABLE IF EXISTS `gen_project_modify`;
CREATE TABLE `gen_project_modify`
(
    `id`                     bigint(20)                                                    NOT NULL AUTO_INCREMENT COMMENT 'id',
    `project_name`           varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '项目名',
    `project_code`           varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '项目标识',
    `project_package`        varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '项目包名',
    `project_path`           varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '项目路径',
    `modify_project_name`    varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '变更项目名',
    `modify_project_code`    varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '变更标识',
    `modify_project_package` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '变更包名',
    `exclusions`             varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '排除文件',
    `modify_suffix`          varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '变更文件',
    `modify_tmp_path`        varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '变更临时路径',
    `create_time`            datetime                                                      NULL DEFAULT NULL COMMENT '创建时间',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 1
  CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_general_ci COMMENT = '项目名变更'
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gen_project_modify
-- ----------------------------
INSERT INTO `gen_project_modify`
VALUES (1, 'maku-boot', 'maku', 'net.maku', 'D:/makunet/maku-boot', 'baba-boot', 'baba', 'com.baba',
        '.git,.idea,target,logs', 'java,xml,yml,txt', NULL, '2023-06-30 10:25:16');
INSERT INTO `gen_project_modify`
VALUES (2, 'maku-cloud', 'maku', 'net.maku', 'D:/makunet/maku-cloud', 'baba-cloud', 'baba', 'com.baba',
        '.git,.idea,target,logs', 'java,xml,yml,txt', NULL, '2023-06-30 10:25:16');

-- ----------------------------
-- Table structure for gen_table
-- ----------------------------
DROP TABLE IF EXISTS `gen_table`;
CREATE TABLE `gen_table`
(
    `id`             bigint(20)                                                    NOT NULL AUTO_INCREMENT COMMENT 'id',
    `table_name`     varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '表名',
    `class_name`     varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '类名',
    `table_comment`  varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '说明',
    `author`         varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '作者',
    `email`          varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '邮箱',
    `package_name`   varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '项目包名',
    `version`        varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '项目版本号',
    `generator_type` tinyint(4)                                                    NULL DEFAULT NULL COMMENT '生成方式  0：zip压缩包   1：自定义目录',
    `backend_path`   varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '后端生成路径',
    `frontend_path`  varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '前端生成路径',
    `module_name`    varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '模块名',
    `function_name`  varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '功能名',
    `form_layout`    tinyint(4)                                                    NULL DEFAULT NULL COMMENT '表单布局  1：一列   2：两列',
    `datasource_id`  bigint(20)                                                    NULL DEFAULT NULL COMMENT '数据源ID',
    `baseclass_id`   bigint(20)                                                    NULL DEFAULT NULL COMMENT '基类ID',
    `create_time`    datetime                                                      NULL DEFAULT NULL COMMENT '创建时间',
    PRIMARY KEY (`id`) USING BTREE,
    UNIQUE INDEX `table_name` (`table_name`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 1
  CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_general_ci COMMENT = '代码生成表'
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gen_table
-- ----------------------------
INSERT INTO `gen_table`
VALUES (25, 'field_info', 'FieldSpec', '字段信息表', 'vonlinee', 'vonlinee@163.com', 'io.devpl', '1.0.0', 1, 'backend',
        'frontend', 'service', 'spec', 1, 0, NULL, '2023-07-30 20:44:06');
INSERT INTO `gen_table`
VALUES (26, 'msg_center_send_history', 'MsgCenterSendHistory', '消息中心发送历史表', 'vonlinee', 'vonlinee@163.com',
        'io.devpl', '1.0.0', 1, 'backend', 'frontend', 'devpl', 'history', 1, 1, NULL, '2023-08-01 09:52:40');
INSERT INTO `gen_table`
VALUES (27, 'project', 'Project', '项目信息表', 'vonlinee', 'vonlinee@163.com', 'io.devpl', '1.0.0', 0, 'backend',
        'frontend', 'devpl', 'project', 1, 0, NULL, '2023-08-05 20:21:59');
INSERT INTO `gen_table`
VALUES (28, 'province_city_district', 'ProvinceCityDistrict', '省市县数据表', 'vonlinee', 'vonlinee@163.com',
        'io.devpl', '1.0.0', 0, 'backend', 'frontend', 'devpl', 'district', 1, 0, NULL, '2023-08-05 20:21:59');
INSERT INTO `gen_table`
VALUES (29, 'table_file_generation', 'TableFileGeneration', '表文件生成记录表', 'vonlinee', 'vonlinee@163.com',
        'io.devpl', '1.0.0', 0, 'backend', 'frontend', 'devpl', 'generation', 1, 0, NULL, '2023-08-05 20:21:59');

-- ----------------------------
-- Table structure for gen_table_field
-- ----------------------------
DROP TABLE IF EXISTS `gen_table_field`;
CREATE TABLE `gen_table_field`
(
    `id`              bigint(20)                                                    NOT NULL AUTO_INCREMENT COMMENT 'id',
    `table_id`        bigint(20)                                                    NULL DEFAULT NULL COMMENT '表ID',
    `field_name`      varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '字段名称',
    `field_type`      varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '字段类型',
    `field_comment`   varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '字段说明',
    `attr_name`       varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '属性名',
    `attr_type`       varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '属性类型',
    `package_name`    varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '属性包名',
    `sort`            int(11)                                                       NULL DEFAULT NULL COMMENT '排序',
    `auto_fill`       varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci  NULL DEFAULT NULL COMMENT '自动填充  DEFAULT、INSERT、UPDATE、INSERT_UPDATE',
    `primary_key`     tinyint(4)                                                    NULL DEFAULT NULL COMMENT '主键 0：否  1：是',
    `base_field`      tinyint(4)                                                    NULL DEFAULT NULL COMMENT '基类字段 0：否  1：是',
    `form_item`       tinyint(4)                                                    NULL DEFAULT NULL COMMENT '表单项 0：否  1：是',
    `form_required`   tinyint(4)                                                    NULL DEFAULT NULL COMMENT '表单必填 0：否  1：是',
    `form_type`       varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '表单类型',
    `form_dict`       varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '表单字典类型',
    `form_validator`  varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '表单效验',
    `grid_item`       tinyint(4)                                                    NULL DEFAULT NULL COMMENT '列表项 0：否  1：是',
    `grid_sort`       tinyint(4)                                                    NULL DEFAULT NULL COMMENT '列表排序 0：否  1：是',
    `query_item`      tinyint(4)                                                    NULL DEFAULT NULL COMMENT '查询项 0：否  1：是',
    `query_type`      varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '查询方式',
    `query_form_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '查询表单类型',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 1
  CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_general_ci COMMENT = '代码生成表字段'
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gen_table_field
-- ----------------------------
INSERT INTO `gen_table_field`
VALUES (69, 25, 'field_id', 'varchar', '字段ID', 'fieldId', 'String', NULL, 0, 'DEFAULT', 1, 0, 1, 0, 'text', NULL,
        NULL, 1, 0, 0, '=', 'text');
INSERT INTO `gen_table_field`
VALUES (70, 25, 'field_name', 'varchar', '字段名', 'fieldName', 'String', NULL, 1, 'DEFAULT', 0, 0, 1, 0, 'text', NULL,
        NULL, 1, 0, 0, '=', 'text');
INSERT INTO `gen_table_field`
VALUES (71, 25, 'data_type', 'varchar', '数据类型', 'dataType', 'String', NULL, 2, 'DEFAULT', 0, 0, 1, 0, 'text', NULL,
        NULL, 1, 0, 0, '=', 'text');
INSERT INTO `gen_table_field`
VALUES (72, 25, 'description', 'varchar', '描述信息', 'description', 'String', NULL, 3, 'DEFAULT', 0, 0, 1, 0, 'text',
        NULL, NULL, 1, 0, 0, '=', 'text');
INSERT INTO `gen_table_field`
VALUES (73, 25, 'field_value', 'varchar', '默认值', 'fieldValue', 'String', NULL, 4, 'DEFAULT', 0, 0, 1, 0, 'text',
        NULL, NULL, 1, 0, 0, '=', 'text');
INSERT INTO `gen_table_field`
VALUES (74, 26, 'id', 'bigint', '自增主键ID', 'id', 'Long', NULL, 0, 'INSERT', 1, 0, 1, 0, 'text', NULL, NULL, 1, 0, 0,
        '=', 'text');
INSERT INTO `gen_table_field`
VALUES (75, 26, 'msg_id', 'varchar', '唯一消息ID', 'msgId', 'String', NULL, 1, 'DEFAULT', 0, 0, 1, 0, 'text', NULL,
        NULL, 1, 0, 0, '=', 'text');
INSERT INTO `gen_table_field`
VALUES (76, 26, 'exam_id', 'varchar', '考试id', 'examId', 'String', NULL, 2, 'DEFAULT', 0, 0, 1, 0, 'text', NULL, NULL,
        1, 0, 0, '=', 'text');
INSERT INTO `gen_table_field`
VALUES (77, 26, 'scene_code', 'varchar', '消息发送场景', 'sceneCode', 'String', NULL, 3, 'DEFAULT', 0, 0, 1, 0, 'text',
        NULL, NULL, 1, 0, 0, '=', 'text');
INSERT INTO `gen_table_field`
VALUES (78, 26, 'receiver', 'json', '消息接收者', 'receiver', 'Object', NULL, 4, 'DEFAULT', 0, 0, 1, 0, 'text', NULL,
        NULL, 1, 0, 0, '=', 'text');
INSERT INTO `gen_table_field`
VALUES (79, 26, 'deleted', 'tinyint', '是否删除', 'deleted', 'Integer', NULL, 5, 'DEFAULT', 0, 0, 1, 0, 'text', NULL,
        NULL, 1, 0, 0, '=', 'text');
INSERT INTO `gen_table_field`
VALUES (80, 26, 'create_time', 'datetime', '创建时间', 'createTime', 'Date', 'java.util.Date', 6, 'DEFAULT', 0, 0, 1, 0,
        'text', NULL, NULL, 1, 0, 0, '=', 'text');
INSERT INTO `gen_table_field`
VALUES (81, 26, 'update_time', 'datetime', '更新时间', 'updateTime', 'Date', 'java.util.Date', 7, 'DEFAULT', 0, 0, 1, 0,
        'text', NULL, NULL, 1, 0, 0, '=', 'text');
INSERT INTO `gen_table_field`
VALUES (82, 27, 'project_id', 'varchar', '项目ID', 'projectId', 'String', NULL, 0, 'DEFAULT', 0, 0, 1, 0, 'text', NULL,
        NULL, 1, 0, 0, '=', 'text');
INSERT INTO `gen_table_field`
VALUES (83, 28, 'id', 'int', '地区代码', 'id', 'Integer', NULL, 0, 'DEFAULT', 1, 0, 1, 0, 'text', NULL, NULL, 1, 0, 0,
        '=', 'text');
INSERT INTO `gen_table_field`
VALUES (84, 28, 'pid', 'int', '当前地区的上一级地区代码', 'pid', 'Integer', NULL, 1, 'DEFAULT', 0, 0, 1, 0, 'text',
        NULL, NULL, 1, 0, 0, '=', 'text');
INSERT INTO `gen_table_field`
VALUES (85, 28, 'name', 'varchar', '地区名称', 'name', 'String', NULL, 2, 'DEFAULT', 0, 0, 1, 0, 'text', NULL, NULL, 1,
        0, 0, '=', 'text');
INSERT INTO `gen_table_field`
VALUES (86, 29, 'pid', 'bigint', '主键ID', 'pid', 'Long', NULL, 0, 'DEFAULT', 1, 0, 1, 0, 'text', NULL, NULL, 1, 0, 0,
        '=', 'text');
INSERT INTO `gen_table_field`
VALUES (87, 29, 'table_id', 'bigint', '表ID', 'tableId', 'Long', NULL, 1, 'DEFAULT', 0, 0, 1, 0, 'text', NULL, NULL, 1,
        0, 0, '=', 'text');
INSERT INTO `gen_table_field`
VALUES (88, 29, 'template_id', 'bigint', '模板ID', 'templateId', 'Long', NULL, 2, 'DEFAULT', 0, 0, 1, 0, 'text', NULL,
        NULL, 1, 0, 0, '=', 'text');
INSERT INTO `gen_table_field`
VALUES (89, 29, 'file_name', 'varchar', '文件名称', 'fileName', 'String', NULL, 3, 'DEFAULT', 0, 0, 1, 0, 'text', NULL,
        NULL, 1, 0, 0, '=', 'text');
INSERT INTO `gen_table_field`
VALUES (90, 29, 'save_path', 'varchar', '保存路径', 'savePath', 'String', NULL, 4, 'DEFAULT', 0, 0, 1, 0, 'text', NULL,
        NULL, 1, 0, 0, '=', 'text');

-- ----------------------------
-- Table structure for gen_test_student
-- ----------------------------
DROP TABLE IF EXISTS `gen_test_student`;
CREATE TABLE `gen_test_student`
(
    `id`          bigint(20)                                                   NOT NULL AUTO_INCREMENT COMMENT '学生ID',
    `name`        varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '姓名',
    `gender`      tinyint(4)                                                   NULL DEFAULT NULL COMMENT '性别',
    `age`         int(11)                                                      NULL DEFAULT NULL COMMENT '年龄',
    `class_name`  varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '班级',
    `version`     int(11)                                                      NULL DEFAULT NULL COMMENT '版本号',
    `deleted`     tinyint(4)                                                   NULL DEFAULT NULL COMMENT '删除标识',
    `creator`     bigint(20)                                                   NULL DEFAULT NULL COMMENT '创建者',
    `create_time` datetime                                                     NULL DEFAULT NULL COMMENT '创建时间',
    `updater`     bigint(20)                                                   NULL DEFAULT NULL COMMENT '更新者',
    `update_time` datetime                                                     NULL DEFAULT NULL COMMENT '更新时间',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 1
  CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_general_ci COMMENT = '测试2'
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gen_test_student
-- ----------------------------

-- ----------------------------
-- Table structure for generator_config
-- ----------------------------
DROP TABLE IF EXISTS `generator_config`;
CREATE TABLE `generator_config`
(
    `name`  text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
    `value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL
) ENGINE = InnoDB
  CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_general_ci COMMENT = '代码生成配置信息'
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of generator_config
-- ----------------------------
INSERT INTO `generator_config`
VALUES ('蓝鸽',
        '{\"name\":\"蓝鸽\",\"projectRootFolder\":\"D:\\\\Temp\",\"parentPackage\":\"com.lancoo.campuspotrait\",\"entityPackageName\":\"entity\",\"entityPackageFolder\":\"src/main/java\",\"mapperPackageName\":\"mapper\",\"mapperFolder\":\"src/main/java\",\"mapperXmlPackage\":\"mapping\",\"mapperXmlFolder\":\"src/main/resources\",\"authors\":null,\"projectLayout\":null}');

-- ----------------------------
-- Table structure for input_history
-- ----------------------------
DROP TABLE IF EXISTS `input_history`;
CREATE TABLE `input_history`
(
    `pid`        bigint(20) UNSIGNED                                           NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    `item_key`   varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '输入位置',
    `item_value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '输入值',
    PRIMARY KEY (`pid`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 1
  CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_general_ci COMMENT = '输入历史'
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of input_history
-- ----------------------------

-- ----------------------------
-- Table structure for project
-- ----------------------------
DROP TABLE IF EXISTS `project`;
CREATE TABLE `project`
(
    `project_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '项目ID'
) ENGINE = InnoDB
  CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_general_ci COMMENT = '项目信息表'
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of project
-- ----------------------------

-- ----------------------------
-- Table structure for province_city_district
-- ----------------------------
DROP TABLE IF EXISTS `province_city_district`;
CREATE TABLE `province_city_district`
(
    `id`   int(11)                                                NOT NULL COMMENT '地区代码',
    `pid`  int(11)                                                NULL DEFAULT NULL COMMENT '当前地区的上一级地区代码',
    `name` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '地区名称',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  CHARACTER SET = utf8
  COLLATE = utf8_general_ci COMMENT = '省市县数据表'
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of province_city_district
-- ----------------------------
INSERT INTO `province_city_district`
VALUES (11, 0, '北京');
INSERT INTO `province_city_district`
VALUES (12, 0, '天津');
INSERT INTO `province_city_district`
VALUES (13, 0, '河北');
INSERT INTO `province_city_district`
VALUES (14, 0, '山西');
INSERT INTO `province_city_district`
VALUES (15, 0, '内蒙古');
INSERT INTO `province_city_district`
VALUES (21, 0, '辽宁');
INSERT INTO `province_city_district`
VALUES (22, 0, '吉林');
INSERT INTO `province_city_district`
VALUES (23, 0, '黑龙江');
INSERT INTO `province_city_district`
VALUES (31, 0, '上海');
INSERT INTO `province_city_district`
VALUES (32, 0, '江苏');
INSERT INTO `province_city_district`
VALUES (33, 0, '浙江');
INSERT INTO `province_city_district`
VALUES (34, 0, '安徽');
INSERT INTO `province_city_district`
VALUES (35, 0, '福建');
INSERT INTO `province_city_district`
VALUES (36, 0, '江西');
INSERT INTO `province_city_district`
VALUES (37, 0, '山东');
INSERT INTO `province_city_district`
VALUES (41, 0, '河南');
INSERT INTO `province_city_district`
VALUES (42, 0, '湖北');
INSERT INTO `province_city_district`
VALUES (43, 0, '湖南');
INSERT INTO `province_city_district`
VALUES (44, 0, '广东');
INSERT INTO `province_city_district`
VALUES (45, 0, '广西');
INSERT INTO `province_city_district`
VALUES (46, 0, '海南');
INSERT INTO `province_city_district`
VALUES (50, 0, '重庆');
INSERT INTO `province_city_district`
VALUES (51, 0, '四川');
INSERT INTO `province_city_district`
VALUES (52, 0, '贵州');
INSERT INTO `province_city_district`
VALUES (53, 0, '云南');
INSERT INTO `province_city_district`
VALUES (54, 0, '西藏');
INSERT INTO `province_city_district`
VALUES (61, 0, '陕西');
INSERT INTO `province_city_district`
VALUES (62, 0, '甘肃');
INSERT INTO `province_city_district`
VALUES (63, 0, '青海');
INSERT INTO `province_city_district`
VALUES (64, 0, '宁夏');
INSERT INTO `province_city_district`
VALUES (65, 0, '新疆');
INSERT INTO `province_city_district`
VALUES (71, 0, '台湾');
INSERT INTO `province_city_district`
VALUES (81, 0, '香港');
INSERT INTO `province_city_district`
VALUES (91, 0, '澳门');
INSERT INTO `province_city_district`
VALUES (1101, 11, '北京市辖');
INSERT INTO `province_city_district`
VALUES (1102, 11, '北京县辖');
INSERT INTO `province_city_district`
VALUES (1201, 12, '天津市辖');
INSERT INTO `province_city_district`
VALUES (1202, 12, '天津县辖');
INSERT INTO `province_city_district`
VALUES (1301, 13, '石家庄');
INSERT INTO `province_city_district`
VALUES (1302, 13, '唐山');
INSERT INTO `province_city_district`
VALUES (1303, 13, '秦皇岛');
INSERT INTO `province_city_district`
VALUES (1304, 13, '邯郸');
INSERT INTO `province_city_district`
VALUES (1305, 13, '邢台');
INSERT INTO `province_city_district`
VALUES (1306, 13, '保定');
INSERT INTO `province_city_district`
VALUES (1307, 13, '张家口');
INSERT INTO `province_city_district`
VALUES (1308, 13, '承德');
INSERT INTO `province_city_district`
VALUES (1309, 13, '沧州');
INSERT INTO `province_city_district`
VALUES (1310, 13, '廊坊');
INSERT INTO `province_city_district`
VALUES (1311, 13, '衡水');
INSERT INTO `province_city_district`
VALUES (1401, 14, '太原');
INSERT INTO `province_city_district`
VALUES (1402, 14, '大同');
INSERT INTO `province_city_district`
VALUES (1403, 14, '阳泉');
INSERT INTO `province_city_district`
VALUES (1404, 14, '长治');
INSERT INTO `province_city_district`
VALUES (1405, 14, '晋城');
INSERT INTO `province_city_district`
VALUES (1406, 14, '朔州');
INSERT INTO `province_city_district`
VALUES (1407, 14, '晋中');
INSERT INTO `province_city_district`
VALUES (1408, 14, '运城');
INSERT INTO `province_city_district`
VALUES (1409, 14, '忻州');
INSERT INTO `province_city_district`
VALUES (1410, 14, '临汾');
INSERT INTO `province_city_district`
VALUES (1423, 14, '吕梁地区');
INSERT INTO `province_city_district`
VALUES (1501, 15, '呼和浩特');
INSERT INTO `province_city_district`
VALUES (1502, 15, '包头');
INSERT INTO `province_city_district`
VALUES (1503, 15, '乌海');
INSERT INTO `province_city_district`
VALUES (1504, 15, '赤峰');
INSERT INTO `province_city_district`
VALUES (1505, 15, '通辽');
INSERT INTO `province_city_district`
VALUES (1521, 15, '呼伦贝尔盟');
INSERT INTO `province_city_district`
VALUES (1522, 15, '兴安盟');
INSERT INTO `province_city_district`
VALUES (1525, 15, '锡林郭勒盟');
INSERT INTO `province_city_district`
VALUES (1526, 15, '乌兰察布盟');
INSERT INTO `province_city_district`
VALUES (1527, 15, '伊克昭盟');
INSERT INTO `province_city_district`
VALUES (1528, 15, '巴彦淖尔盟');
INSERT INTO `province_city_district`
VALUES (1529, 15, '阿拉善盟');
INSERT INTO `province_city_district`
VALUES (2101, 21, '沈阳');
INSERT INTO `province_city_district`
VALUES (2102, 21, '大连');
INSERT INTO `province_city_district`
VALUES (2103, 21, '鞍山');
INSERT INTO `province_city_district`
VALUES (2104, 21, '抚顺');
INSERT INTO `province_city_district`
VALUES (2105, 21, '本溪');
INSERT INTO `province_city_district`
VALUES (2106, 21, '丹东');
INSERT INTO `province_city_district`
VALUES (2107, 21, '锦州');
INSERT INTO `province_city_district`
VALUES (2108, 21, '营口');
INSERT INTO `province_city_district`
VALUES (2109, 21, '阜新');
INSERT INTO `province_city_district`
VALUES (2110, 21, '辽阳');
INSERT INTO `province_city_district`
VALUES (2111, 21, '盘锦');
INSERT INTO `province_city_district`
VALUES (2112, 21, '铁岭');
INSERT INTO `province_city_district`
VALUES (2113, 21, '朝阳');
INSERT INTO `province_city_district`
VALUES (2114, 21, '葫芦岛');
INSERT INTO `province_city_district`
VALUES (2201, 22, '长春');
INSERT INTO `province_city_district`
VALUES (2202, 22, '吉林');
INSERT INTO `province_city_district`
VALUES (2203, 22, '四平');
INSERT INTO `province_city_district`
VALUES (2204, 22, '辽源');
INSERT INTO `province_city_district`
VALUES (2205, 22, '通化');
INSERT INTO `province_city_district`
VALUES (2206, 22, '白山');
INSERT INTO `province_city_district`
VALUES (2207, 22, '松原');
INSERT INTO `province_city_district`
VALUES (2208, 22, '白城');
INSERT INTO `province_city_district`
VALUES (2224, 22, '延边朝鲜族自治州');
INSERT INTO `province_city_district`
VALUES (2301, 23, '哈尔滨');
INSERT INTO `province_city_district`
VALUES (2302, 23, '齐齐哈尔');
INSERT INTO `province_city_district`
VALUES (2303, 23, '鸡西');
INSERT INTO `province_city_district`
VALUES (2304, 23, '鹤岗');
INSERT INTO `province_city_district`
VALUES (2305, 23, '双鸭山');
INSERT INTO `province_city_district`
VALUES (2306, 23, '大庆');
INSERT INTO `province_city_district`
VALUES (2307, 23, '伊春');
INSERT INTO `province_city_district`
VALUES (2308, 23, '佳木斯');
INSERT INTO `province_city_district`
VALUES (2309, 23, '七台河');
INSERT INTO `province_city_district`
VALUES (2310, 23, '牡丹江');
INSERT INTO `province_city_district`
VALUES (2311, 23, '黑河');
INSERT INTO `province_city_district`
VALUES (2312, 23, '绥化');
INSERT INTO `province_city_district`
VALUES (2327, 23, '大兴安岭地区');
INSERT INTO `province_city_district`
VALUES (3101, 31, '上海市辖');
INSERT INTO `province_city_district`
VALUES (3102, 31, '上海县辖');
INSERT INTO `province_city_district`
VALUES (3201, 32, '南京');
INSERT INTO `province_city_district`
VALUES (3202, 32, '无锡');
INSERT INTO `province_city_district`
VALUES (3203, 32, '徐州');
INSERT INTO `province_city_district`
VALUES (3204, 32, '常州');
INSERT INTO `province_city_district`
VALUES (3205, 32, '苏州');
INSERT INTO `province_city_district`
VALUES (3206, 32, '南通');
INSERT INTO `province_city_district`
VALUES (3207, 32, '连云港');
INSERT INTO `province_city_district`
VALUES (3208, 32, '淮安');
INSERT INTO `province_city_district`
VALUES (3209, 32, '盐城');
INSERT INTO `province_city_district`
VALUES (3210, 32, '扬州');
INSERT INTO `province_city_district`
VALUES (3211, 32, '镇江');
INSERT INTO `province_city_district`
VALUES (3212, 32, '泰州');
INSERT INTO `province_city_district`
VALUES (3213, 32, '宿迁');
INSERT INTO `province_city_district`
VALUES (3301, 33, '杭州');
INSERT INTO `province_city_district`
VALUES (3302, 33, '宁波');
INSERT INTO `province_city_district`
VALUES (3303, 33, '温州');
INSERT INTO `province_city_district`
VALUES (3304, 33, '嘉兴');
INSERT INTO `province_city_district`
VALUES (3305, 33, '湖州');
INSERT INTO `province_city_district`
VALUES (3306, 33, '绍兴');
INSERT INTO `province_city_district`
VALUES (3307, 33, '金华');
INSERT INTO `province_city_district`
VALUES (3308, 33, '衢州');
INSERT INTO `province_city_district`
VALUES (3309, 33, '舟山');
INSERT INTO `province_city_district`
VALUES (3310, 33, '台州');
INSERT INTO `province_city_district`
VALUES (3311, 33, '丽水');
INSERT INTO `province_city_district`
VALUES (3401, 34, '合肥');
INSERT INTO `province_city_district`
VALUES (3402, 34, '芜湖');
INSERT INTO `province_city_district`
VALUES (3403, 34, '蚌埠');
INSERT INTO `province_city_district`
VALUES (3404, 34, '淮南');
INSERT INTO `province_city_district`
VALUES (3405, 34, '马鞍山');
INSERT INTO `province_city_district`
VALUES (3406, 34, '淮北');
INSERT INTO `province_city_district`
VALUES (3407, 34, '铜陵');
INSERT INTO `province_city_district`
VALUES (3408, 34, '安庆');
INSERT INTO `province_city_district`
VALUES (3410, 34, '黄山');
INSERT INTO `province_city_district`
VALUES (3411, 34, '滁州');
INSERT INTO `province_city_district`
VALUES (3412, 34, '阜阳');
INSERT INTO `province_city_district`
VALUES (3413, 34, '宿州');
INSERT INTO `province_city_district`
VALUES (3414, 34, '巢湖');
INSERT INTO `province_city_district`
VALUES (3415, 34, '六安');
INSERT INTO `province_city_district`
VALUES (3416, 34, '亳州');
INSERT INTO `province_city_district`
VALUES (3417, 34, '池州');
INSERT INTO `province_city_district`
VALUES (3418, 34, '宣城');
INSERT INTO `province_city_district`
VALUES (3501, 35, '福州');
INSERT INTO `province_city_district`
VALUES (3502, 35, '厦门');
INSERT INTO `province_city_district`
VALUES (3503, 35, '莆田');
INSERT INTO `province_city_district`
VALUES (3504, 35, '三明');
INSERT INTO `province_city_district`
VALUES (3505, 35, '泉州');
INSERT INTO `province_city_district`
VALUES (3506, 35, '漳州');
INSERT INTO `province_city_district`
VALUES (3507, 35, '南平');
INSERT INTO `province_city_district`
VALUES (3508, 35, '龙岩');
INSERT INTO `province_city_district`
VALUES (3509, 35, '宁德');
INSERT INTO `province_city_district`
VALUES (3601, 36, '南昌');
INSERT INTO `province_city_district`
VALUES (3602, 36, '景德镇');
INSERT INTO `province_city_district`
VALUES (3603, 36, '萍乡');
INSERT INTO `province_city_district`
VALUES (3604, 36, '九江');
INSERT INTO `province_city_district`
VALUES (3605, 36, '新余');
INSERT INTO `province_city_district`
VALUES (3606, 36, '鹰潭');
INSERT INTO `province_city_district`
VALUES (3607, 36, '赣州');
INSERT INTO `province_city_district`
VALUES (3608, 36, '吉安');
INSERT INTO `province_city_district`
VALUES (3609, 36, '宜春');
INSERT INTO `province_city_district`
VALUES (3610, 36, '抚州');
INSERT INTO `province_city_district`
VALUES (3611, 36, '上饶');
INSERT INTO `province_city_district`
VALUES (3701, 37, '济南');
INSERT INTO `province_city_district`
VALUES (3702, 37, '青岛');
INSERT INTO `province_city_district`
VALUES (3703, 37, '淄博');
INSERT INTO `province_city_district`
VALUES (3704, 37, '枣庄');
INSERT INTO `province_city_district`
VALUES (3705, 37, '东营');
INSERT INTO `province_city_district`
VALUES (3706, 37, '烟台');
INSERT INTO `province_city_district`
VALUES (3707, 37, '潍坊');
INSERT INTO `province_city_district`
VALUES (3708, 37, '济宁');
INSERT INTO `province_city_district`
VALUES (3709, 37, '泰安');
INSERT INTO `province_city_district`
VALUES (3710, 37, '威海');
INSERT INTO `province_city_district`
VALUES (3711, 37, '日照');
INSERT INTO `province_city_district`
VALUES (3712, 37, '莱芜');
INSERT INTO `province_city_district`
VALUES (3713, 37, '临沂');
INSERT INTO `province_city_district`
VALUES (3714, 37, '德州');
INSERT INTO `province_city_district`
VALUES (3715, 37, '聊城');
INSERT INTO `province_city_district`
VALUES (3716, 37, '滨州');
INSERT INTO `province_city_district`
VALUES (3717, 37, '菏泽');
INSERT INTO `province_city_district`
VALUES (4101, 41, '郑州');
INSERT INTO `province_city_district`
VALUES (4102, 41, '开封');
INSERT INTO `province_city_district`
VALUES (4103, 41, '洛阳');
INSERT INTO `province_city_district`
VALUES (4104, 41, '平顶山');
INSERT INTO `province_city_district`
VALUES (4105, 41, '安阳');
INSERT INTO `province_city_district`
VALUES (4106, 41, '鹤壁');
INSERT INTO `province_city_district`
VALUES (4107, 41, '新乡');
INSERT INTO `province_city_district`
VALUES (4108, 41, '焦作');
INSERT INTO `province_city_district`
VALUES (4109, 41, '濮阳');
INSERT INTO `province_city_district`
VALUES (4110, 41, '许昌');
INSERT INTO `province_city_district`
VALUES (4111, 41, '漯河');
INSERT INTO `province_city_district`
VALUES (4112, 41, '三门峡');
INSERT INTO `province_city_district`
VALUES (4113, 41, '南阳');
INSERT INTO `province_city_district`
VALUES (4114, 41, '商丘');
INSERT INTO `province_city_district`
VALUES (4115, 41, '信阳');
INSERT INTO `province_city_district`
VALUES (4116, 41, '周口');
INSERT INTO `province_city_district`
VALUES (4117, 41, '驻马店');
INSERT INTO `province_city_district`
VALUES (4201, 42, '武汉');
INSERT INTO `province_city_district`
VALUES (4202, 42, '黄石');
INSERT INTO `province_city_district`
VALUES (4203, 42, '十堰');
INSERT INTO `province_city_district`
VALUES (4205, 42, '宜昌');
INSERT INTO `province_city_district`
VALUES (4206, 42, '襄樊');
INSERT INTO `province_city_district`
VALUES (4207, 42, '鄂州');
INSERT INTO `province_city_district`
VALUES (4208, 42, '荆门');
INSERT INTO `province_city_district`
VALUES (4209, 42, '孝感');
INSERT INTO `province_city_district`
VALUES (4210, 42, '荆州');
INSERT INTO `province_city_district`
VALUES (4211, 42, '黄冈');
INSERT INTO `province_city_district`
VALUES (4212, 42, '咸宁');
INSERT INTO `province_city_district`
VALUES (4213, 42, '随州');
INSERT INTO `province_city_district`
VALUES (4228, 42, '恩施土家族苗族自治州');
INSERT INTO `province_city_district`
VALUES (4290, 42, '省直辖行政单位');
INSERT INTO `province_city_district`
VALUES (4301, 43, '长沙');
INSERT INTO `province_city_district`
VALUES (4302, 43, '株洲');
INSERT INTO `province_city_district`
VALUES (4303, 43, '湘潭');
INSERT INTO `province_city_district`
VALUES (4304, 43, '衡阳');
INSERT INTO `province_city_district`
VALUES (4305, 43, '邵阳');
INSERT INTO `province_city_district`
VALUES (4306, 43, '岳阳');
INSERT INTO `province_city_district`
VALUES (4307, 43, '常德');
INSERT INTO `province_city_district`
VALUES (4308, 43, '张家界');
INSERT INTO `province_city_district`
VALUES (4309, 43, '益阳');
INSERT INTO `province_city_district`
VALUES (4310, 43, '郴州');
INSERT INTO `province_city_district`
VALUES (4311, 43, '永州');
INSERT INTO `province_city_district`
VALUES (4312, 43, '怀化');
INSERT INTO `province_city_district`
VALUES (4313, 43, '娄底');
INSERT INTO `province_city_district`
VALUES (4331, 43, '湘西土家族苗族自治州');
INSERT INTO `province_city_district`
VALUES (4401, 44, '广州');
INSERT INTO `province_city_district`
VALUES (4402, 44, '韶关');
INSERT INTO `province_city_district`
VALUES (4403, 44, '深圳');
INSERT INTO `province_city_district`
VALUES (4404, 44, '珠海');
INSERT INTO `province_city_district`
VALUES (4405, 44, '汕头');
INSERT INTO `province_city_district`
VALUES (4406, 44, '佛山');
INSERT INTO `province_city_district`
VALUES (4407, 44, '江门');
INSERT INTO `province_city_district`
VALUES (4408, 44, '湛江');
INSERT INTO `province_city_district`
VALUES (4409, 44, '茂名');
INSERT INTO `province_city_district`
VALUES (4412, 44, '肇庆');
INSERT INTO `province_city_district`
VALUES (4413, 44, '惠州');
INSERT INTO `province_city_district`
VALUES (4414, 44, '梅州');
INSERT INTO `province_city_district`
VALUES (4415, 44, '汕尾');
INSERT INTO `province_city_district`
VALUES (4416, 44, '河源');
INSERT INTO `province_city_district`
VALUES (4417, 44, '阳江');
INSERT INTO `province_city_district`
VALUES (4418, 44, '清远');
INSERT INTO `province_city_district`
VALUES (4419, 44, '东莞');
INSERT INTO `province_city_district`
VALUES (4420, 44, '中山');
INSERT INTO `province_city_district`
VALUES (4451, 44, '潮州');
INSERT INTO `province_city_district`
VALUES (4452, 44, '揭阳');
INSERT INTO `province_city_district`
VALUES (4453, 44, '云浮');
INSERT INTO `province_city_district`
VALUES (4501, 45, '南宁');
INSERT INTO `province_city_district`
VALUES (4502, 45, '柳州');
INSERT INTO `province_city_district`
VALUES (4503, 45, '桂林');
INSERT INTO `province_city_district`
VALUES (4504, 45, '梧州');
INSERT INTO `province_city_district`
VALUES (4505, 45, '北海');
INSERT INTO `province_city_district`
VALUES (4506, 45, '防城港');
INSERT INTO `province_city_district`
VALUES (4507, 45, '钦州');
INSERT INTO `province_city_district`
VALUES (4508, 45, '贵港');
INSERT INTO `province_city_district`
VALUES (4509, 45, '玉林');
INSERT INTO `province_city_district`
VALUES (4521, 45, '南宁地区');
INSERT INTO `province_city_district`
VALUES (4522, 45, '柳州地区');
INSERT INTO `province_city_district`
VALUES (4524, 45, '贺州地区');
INSERT INTO `province_city_district`
VALUES (4526, 45, '百色地区');
INSERT INTO `province_city_district`
VALUES (4527, 45, '河池地区');
INSERT INTO `province_city_district`
VALUES (4601, 46, '海南');
INSERT INTO `province_city_district`
VALUES (4602, 46, '海口');
INSERT INTO `province_city_district`
VALUES (4603, 46, '三亚');
INSERT INTO `province_city_district`
VALUES (5001, 50, '重庆市辖');
INSERT INTO `province_city_district`
VALUES (5002, 50, '重庆县辖');
INSERT INTO `province_city_district`
VALUES (5003, 50, '重庆县级');
INSERT INTO `province_city_district`
VALUES (5101, 51, '成都');
INSERT INTO `province_city_district`
VALUES (5103, 51, '自贡');
INSERT INTO `province_city_district`
VALUES (5104, 51, '攀枝花');
INSERT INTO `province_city_district`
VALUES (5105, 51, '泸州');
INSERT INTO `province_city_district`
VALUES (5106, 51, '德阳');
INSERT INTO `province_city_district`
VALUES (5107, 51, '绵阳');
INSERT INTO `province_city_district`
VALUES (5108, 51, '广元');
INSERT INTO `province_city_district`
VALUES (5109, 51, '遂宁');
INSERT INTO `province_city_district`
VALUES (5110, 51, '内江');
INSERT INTO `province_city_district`
VALUES (5111, 51, '乐山');
INSERT INTO `province_city_district`
VALUES (5113, 51, '南充');
INSERT INTO `province_city_district`
VALUES (5114, 51, '眉山');
INSERT INTO `province_city_district`
VALUES (5115, 51, '宜宾');
INSERT INTO `province_city_district`
VALUES (5116, 51, '广安');
INSERT INTO `province_city_district`
VALUES (5117, 51, '达州');
INSERT INTO `province_city_district`
VALUES (5118, 51, '雅安');
INSERT INTO `province_city_district`
VALUES (5119, 51, '巴中');
INSERT INTO `province_city_district`
VALUES (5120, 51, '资阳');
INSERT INTO `province_city_district`
VALUES (5132, 51, '阿坝藏族羌族自治州');
INSERT INTO `province_city_district`
VALUES (5133, 51, '甘孜藏族自治州');
INSERT INTO `province_city_district`
VALUES (5134, 51, '凉山彝族自治州');
INSERT INTO `province_city_district`
VALUES (5201, 52, '贵阳');
INSERT INTO `province_city_district`
VALUES (5202, 52, '六盘水');
INSERT INTO `province_city_district`
VALUES (5203, 52, '遵义');
INSERT INTO `province_city_district`
VALUES (5204, 52, '安顺');
INSERT INTO `province_city_district`
VALUES (5222, 52, '铜仁地区');
INSERT INTO `province_city_district`
VALUES (5223, 52, '黔西南布依族苗族自治');
INSERT INTO `province_city_district`
VALUES (5224, 52, '毕节地区');
INSERT INTO `province_city_district`
VALUES (5226, 52, '黔东南苗族侗族自治州');
INSERT INTO `province_city_district`
VALUES (5227, 52, '黔南布依族苗族自治州');
INSERT INTO `province_city_district`
VALUES (5301, 53, '昆明');
INSERT INTO `province_city_district`
VALUES (5303, 53, '曲靖');
INSERT INTO `province_city_district`
VALUES (5304, 53, '玉溪');
INSERT INTO `province_city_district`
VALUES (5305, 53, '保山');
INSERT INTO `province_city_district`
VALUES (5321, 53, '昭通地区');
INSERT INTO `province_city_district`
VALUES (5323, 53, '楚雄彝族自治州');
INSERT INTO `province_city_district`
VALUES (5325, 53, '红河哈尼族彝族自治州');
INSERT INTO `province_city_district`
VALUES (5326, 53, '文山壮族苗族自治州');
INSERT INTO `province_city_district`
VALUES (5327, 53, '思茅地区');
INSERT INTO `province_city_district`
VALUES (5328, 53, '西双版纳傣族自治州');
INSERT INTO `province_city_district`
VALUES (5329, 53, '大理白族自治州');
INSERT INTO `province_city_district`
VALUES (5331, 53, '德宏傣族景颇族自治州');
INSERT INTO `province_city_district`
VALUES (5332, 53, '丽江地区');
INSERT INTO `province_city_district`
VALUES (5333, 53, '怒江傈僳族自治州');
INSERT INTO `province_city_district`
VALUES (5334, 53, '迪庆藏族自治州');
INSERT INTO `province_city_district`
VALUES (5335, 53, '临沧地区');
INSERT INTO `province_city_district`
VALUES (5401, 54, '拉萨');
INSERT INTO `province_city_district`
VALUES (5421, 54, '昌都地区');
INSERT INTO `province_city_district`
VALUES (5422, 54, '山南地区');
INSERT INTO `province_city_district`
VALUES (5423, 54, '日喀则地区');
INSERT INTO `province_city_district`
VALUES (5424, 54, '那曲地区');
INSERT INTO `province_city_district`
VALUES (5425, 54, '阿里地区');
INSERT INTO `province_city_district`
VALUES (5426, 54, '林芝地区');
INSERT INTO `province_city_district`
VALUES (6101, 61, '西安');
INSERT INTO `province_city_district`
VALUES (6102, 61, '铜川');
INSERT INTO `province_city_district`
VALUES (6103, 61, '宝鸡');
INSERT INTO `province_city_district`
VALUES (6104, 61, '咸阳');
INSERT INTO `province_city_district`
VALUES (6105, 61, '渭南');
INSERT INTO `province_city_district`
VALUES (6106, 61, '延安');
INSERT INTO `province_city_district`
VALUES (6107, 61, '汉中');
INSERT INTO `province_city_district`
VALUES (6108, 61, '榆林');
INSERT INTO `province_city_district`
VALUES (6109, 61, '安康');
INSERT INTO `province_city_district`
VALUES (6125, 61, '商洛地区');
INSERT INTO `province_city_district`
VALUES (6201, 62, '兰州');
INSERT INTO `province_city_district`
VALUES (6202, 62, '嘉峪关');
INSERT INTO `province_city_district`
VALUES (6203, 62, '金昌');
INSERT INTO `province_city_district`
VALUES (6204, 62, '白银');
INSERT INTO `province_city_district`
VALUES (6205, 62, '天水');
INSERT INTO `province_city_district`
VALUES (6221, 62, '酒泉地区');
INSERT INTO `province_city_district`
VALUES (6222, 62, '张掖地区');
INSERT INTO `province_city_district`
VALUES (6223, 62, '武威地区');
INSERT INTO `province_city_district`
VALUES (6224, 62, '定西地区');
INSERT INTO `province_city_district`
VALUES (6226, 62, '陇南地区');
INSERT INTO `province_city_district`
VALUES (6227, 62, '平凉地区');
INSERT INTO `province_city_district`
VALUES (6228, 62, '庆阳地区');
INSERT INTO `province_city_district`
VALUES (6229, 62, '临夏回族自治州');
INSERT INTO `province_city_district`
VALUES (6230, 62, '甘南藏族自治州');
INSERT INTO `province_city_district`
VALUES (6301, 63, '西宁');
INSERT INTO `province_city_district`
VALUES (6321, 63, '海东地区');
INSERT INTO `province_city_district`
VALUES (6322, 63, '海北藏族自治州');
INSERT INTO `province_city_district`
VALUES (6323, 63, '黄南藏族自治州');
INSERT INTO `province_city_district`
VALUES (6325, 63, '海南藏族自治州');
INSERT INTO `province_city_district`
VALUES (6326, 63, '果洛藏族自治州');
INSERT INTO `province_city_district`
VALUES (6327, 63, '玉树藏族自治州');
INSERT INTO `province_city_district`
VALUES (6328, 63, '海西蒙古族藏族自治州');
INSERT INTO `province_city_district`
VALUES (6401, 64, '银川');
INSERT INTO `province_city_district`
VALUES (6402, 64, '石嘴山');
INSERT INTO `province_city_district`
VALUES (6403, 64, '吴忠');
INSERT INTO `province_city_district`
VALUES (6422, 64, '固原地区');
INSERT INTO `province_city_district`
VALUES (6501, 65, '乌鲁木齐');
INSERT INTO `province_city_district`
VALUES (6502, 65, '克拉玛依');
INSERT INTO `province_city_district`
VALUES (6521, 65, '吐鲁番地区');
INSERT INTO `province_city_district`
VALUES (6522, 65, '哈密地区');
INSERT INTO `province_city_district`
VALUES (6523, 65, '昌吉回族自治州');
INSERT INTO `province_city_district`
VALUES (6527, 65, '博尔塔拉蒙古自治州');
INSERT INTO `province_city_district`
VALUES (6528, 65, '巴音郭楞蒙古自治州');
INSERT INTO `province_city_district`
VALUES (6529, 65, '阿克苏地区');
INSERT INTO `province_city_district`
VALUES (6530, 65, '克孜勒苏柯尔克孜自治');
INSERT INTO `province_city_district`
VALUES (6531, 65, '喀什地区');
INSERT INTO `province_city_district`
VALUES (6532, 65, '和田地区');
INSERT INTO `province_city_district`
VALUES (6540, 65, '伊犁哈萨克自治州');
INSERT INTO `province_city_district`
VALUES (6541, 65, '伊犁地区');
INSERT INTO `province_city_district`
VALUES (6542, 65, '塔城地区');
INSERT INTO `province_city_district`
VALUES (6543, 65, '阿勒泰地区');
INSERT INTO `province_city_district`
VALUES (6590, 65, '省直辖行政单位');
INSERT INTO `province_city_district`
VALUES (7101, 71, '台湾市辖');
INSERT INTO `province_city_district`
VALUES (8101, 81, '香港特区');
INSERT INTO `province_city_district`
VALUES (9101, 91, '澳门特区');
INSERT INTO `province_city_district`
VALUES (110101, 1101, '东城区');
INSERT INTO `province_city_district`
VALUES (110102, 1101, '西城区');
INSERT INTO `province_city_district`
VALUES (110103, 1101, '崇文区');
INSERT INTO `province_city_district`
VALUES (110104, 1101, '宣武区');
INSERT INTO `province_city_district`
VALUES (110105, 1101, '朝阳区');
INSERT INTO `province_city_district`
VALUES (110106, 1101, '丰台区');
INSERT INTO `province_city_district`
VALUES (110107, 1101, '石景山区');
INSERT INTO `province_city_district`
VALUES (110108, 1101, '海淀区');
INSERT INTO `province_city_district`
VALUES (110109, 1101, '门头沟区');
INSERT INTO `province_city_district`
VALUES (110111, 1101, '房山区');
INSERT INTO `province_city_district`
VALUES (110112, 1101, '通州区');
INSERT INTO `province_city_district`
VALUES (110113, 1101, '顺义区');
INSERT INTO `province_city_district`
VALUES (110114, 1101, '昌平区');
INSERT INTO `province_city_district`
VALUES (110224, 1102, '大兴县');
INSERT INTO `province_city_district`
VALUES (110226, 1102, '平谷县');
INSERT INTO `province_city_district`
VALUES (110227, 1102, '怀柔县');
INSERT INTO `province_city_district`
VALUES (110228, 1102, '密云县');
INSERT INTO `province_city_district`
VALUES (110229, 1102, '延庆县');
INSERT INTO `province_city_district`
VALUES (120101, 1201, '和平区');
INSERT INTO `province_city_district`
VALUES (120102, 1201, '河东区');
INSERT INTO `province_city_district`
VALUES (120103, 1201, '河西区');
INSERT INTO `province_city_district`
VALUES (120104, 1201, '南开区');
INSERT INTO `province_city_district`
VALUES (120105, 1201, '河北区');
INSERT INTO `province_city_district`
VALUES (120106, 1201, '红桥区');
INSERT INTO `province_city_district`
VALUES (120107, 1201, '塘沽区');
INSERT INTO `province_city_district`
VALUES (120108, 1201, '汉沽区');
INSERT INTO `province_city_district`
VALUES (120109, 1201, '大港区');
INSERT INTO `province_city_district`
VALUES (120110, 1201, '东丽区');
INSERT INTO `province_city_district`
VALUES (120111, 1201, '西青区');
INSERT INTO `province_city_district`
VALUES (120112, 1201, '津南区');
INSERT INTO `province_city_district`
VALUES (120113, 1201, '北辰区');
INSERT INTO `province_city_district`
VALUES (120114, 1201, '武清区');
INSERT INTO `province_city_district`
VALUES (120221, 1202, '宁河县');
INSERT INTO `province_city_district`
VALUES (120223, 1202, '静海县');
INSERT INTO `province_city_district`
VALUES (120224, 1202, '宝坻县');
INSERT INTO `province_city_district`
VALUES (120225, 1202, '蓟  县');
INSERT INTO `province_city_district`
VALUES (130101, 1301, '市辖区');
INSERT INTO `province_city_district`
VALUES (130102, 1301, '长安区');
INSERT INTO `province_city_district`
VALUES (130103, 1301, '桥东区');
INSERT INTO `province_city_district`
VALUES (130104, 1301, '桥西区');
INSERT INTO `province_city_district`
VALUES (130105, 1301, '新华区');
INSERT INTO `province_city_district`
VALUES (130106, 1301, '郊  区');
INSERT INTO `province_city_district`
VALUES (130107, 1301, '井陉矿区');
INSERT INTO `province_city_district`
VALUES (130121, 1301, '井陉县');
INSERT INTO `province_city_district`
VALUES (130123, 1301, '正定县');
INSERT INTO `province_city_district`
VALUES (130124, 1301, '栾城县');
INSERT INTO `province_city_district`
VALUES (130125, 1301, '行唐县');
INSERT INTO `province_city_district`
VALUES (130126, 1301, '灵寿县');
INSERT INTO `province_city_district`
VALUES (130127, 1301, '高邑县');
INSERT INTO `province_city_district`
VALUES (130128, 1301, '深泽县');
INSERT INTO `province_city_district`
VALUES (130129, 1301, '赞皇县');
INSERT INTO `province_city_district`
VALUES (130130, 1301, '无极县');
INSERT INTO `province_city_district`
VALUES (130131, 1301, '平山县');
INSERT INTO `province_city_district`
VALUES (130132, 1301, '元氏县');
INSERT INTO `province_city_district`
VALUES (130133, 1301, '赵  县');
INSERT INTO `province_city_district`
VALUES (130181, 1301, '辛集市');
INSERT INTO `province_city_district`
VALUES (130182, 1301, '藁城市');
INSERT INTO `province_city_district`
VALUES (130183, 1301, '晋州市');
INSERT INTO `province_city_district`
VALUES (130184, 1301, '新乐市');
INSERT INTO `province_city_district`
VALUES (130185, 1301, '鹿泉市');
INSERT INTO `province_city_district`
VALUES (130201, 1302, '市辖区');
INSERT INTO `province_city_district`
VALUES (130202, 1302, '路南区');
INSERT INTO `province_city_district`
VALUES (130203, 1302, '路北区');
INSERT INTO `province_city_district`
VALUES (130204, 1302, '古冶区');
INSERT INTO `province_city_district`
VALUES (130205, 1302, '开平区');
INSERT INTO `province_city_district`
VALUES (130206, 1302, '新  区');
INSERT INTO `province_city_district`
VALUES (130221, 1302, '丰润县');
INSERT INTO `province_city_district`
VALUES (130223, 1302, '滦  县');
INSERT INTO `province_city_district`
VALUES (130224, 1302, '滦南县');
INSERT INTO `province_city_district`
VALUES (130225, 1302, '乐亭县');
INSERT INTO `province_city_district`
VALUES (130227, 1302, '迁西县');
INSERT INTO `province_city_district`
VALUES (130229, 1302, '玉田县');
INSERT INTO `province_city_district`
VALUES (130230, 1302, '唐海县');
INSERT INTO `province_city_district`
VALUES (130281, 1302, '遵化市');
INSERT INTO `province_city_district`
VALUES (130282, 1302, '丰南市');
INSERT INTO `province_city_district`
VALUES (130283, 1302, '迁安市');
INSERT INTO `province_city_district`
VALUES (130301, 1303, '市辖区');
INSERT INTO `province_city_district`
VALUES (130302, 1303, '海港区');
INSERT INTO `province_city_district`
VALUES (130303, 1303, '山海关区');
INSERT INTO `province_city_district`
VALUES (130304, 1303, '北戴河区');
INSERT INTO `province_city_district`
VALUES (130321, 1303, '青龙满族自治县');
INSERT INTO `province_city_district`
VALUES (130322, 1303, '昌黎县');
INSERT INTO `province_city_district`
VALUES (130323, 1303, '抚宁县');
INSERT INTO `province_city_district`
VALUES (130324, 1303, '卢龙县');
INSERT INTO `province_city_district`
VALUES (130401, 1304, '市辖区');
INSERT INTO `province_city_district`
VALUES (130402, 1304, '邯山区');
INSERT INTO `province_city_district`
VALUES (130403, 1304, '丛台区');
INSERT INTO `province_city_district`
VALUES (130404, 1304, '复兴区');
INSERT INTO `province_city_district`
VALUES (130406, 1304, '峰峰矿区');
INSERT INTO `province_city_district`
VALUES (130421, 1304, '邯郸县');
INSERT INTO `province_city_district`
VALUES (130423, 1304, '临漳县');
INSERT INTO `province_city_district`
VALUES (130424, 1304, '成安县');
INSERT INTO `province_city_district`
VALUES (130425, 1304, '大名县');
INSERT INTO `province_city_district`
VALUES (130426, 1304, '涉  县');
INSERT INTO `province_city_district`
VALUES (130427, 1304, '磁  县');
INSERT INTO `province_city_district`
VALUES (130428, 1304, '肥乡县');
INSERT INTO `province_city_district`
VALUES (130429, 1304, '永年县');
INSERT INTO `province_city_district`
VALUES (130430, 1304, '邱  县');
INSERT INTO `province_city_district`
VALUES (130431, 1304, '鸡泽县');
INSERT INTO `province_city_district`
VALUES (130432, 1304, '广平县');
INSERT INTO `province_city_district`
VALUES (130433, 1304, '馆陶县');
INSERT INTO `province_city_district`
VALUES (130434, 1304, '魏  县');
INSERT INTO `province_city_district`
VALUES (130435, 1304, '曲周县');
INSERT INTO `province_city_district`
VALUES (130481, 1304, '武安市');
INSERT INTO `province_city_district`
VALUES (130501, 1305, '市辖区');
INSERT INTO `province_city_district`
VALUES (130502, 1305, '桥东区');
INSERT INTO `province_city_district`
VALUES (130503, 1305, '桥西区');
INSERT INTO `province_city_district`
VALUES (130521, 1305, '邢台县');
INSERT INTO `province_city_district`
VALUES (130522, 1305, '临城县');
INSERT INTO `province_city_district`
VALUES (130523, 1305, '内丘县');
INSERT INTO `province_city_district`
VALUES (130524, 1305, '柏乡县');
INSERT INTO `province_city_district`
VALUES (130525, 1305, '隆尧县');
INSERT INTO `province_city_district`
VALUES (130526, 1305, '任  县');
INSERT INTO `province_city_district`
VALUES (130527, 1305, '南和县');
INSERT INTO `province_city_district`
VALUES (130528, 1305, '宁晋县');
INSERT INTO `province_city_district`
VALUES (130529, 1305, '巨鹿县');
INSERT INTO `province_city_district`
VALUES (130530, 1305, '新河县');
INSERT INTO `province_city_district`
VALUES (130531, 1305, '广宗县');
INSERT INTO `province_city_district`
VALUES (130532, 1305, '平乡县');
INSERT INTO `province_city_district`
VALUES (130533, 1305, '威  县');
INSERT INTO `province_city_district`
VALUES (130534, 1305, '清河县');
INSERT INTO `province_city_district`
VALUES (130535, 1305, '临西县');
INSERT INTO `province_city_district`
VALUES (130581, 1305, '南宫市');
INSERT INTO `province_city_district`
VALUES (130582, 1305, '沙河市');
INSERT INTO `province_city_district`
VALUES (130601, 1306, '市辖区');
INSERT INTO `province_city_district`
VALUES (130602, 1306, '新市区');
INSERT INTO `province_city_district`
VALUES (130603, 1306, '北市区');
INSERT INTO `province_city_district`
VALUES (130604, 1306, '南市区');
INSERT INTO `province_city_district`
VALUES (130621, 1306, '满城县');
INSERT INTO `province_city_district`
VALUES (130622, 1306, '清苑县');
INSERT INTO `province_city_district`
VALUES (130623, 1306, '涞水县');
INSERT INTO `province_city_district`
VALUES (130624, 1306, '阜平县');
INSERT INTO `province_city_district`
VALUES (130625, 1306, '徐水县');
INSERT INTO `province_city_district`
VALUES (130626, 1306, '定兴县');
INSERT INTO `province_city_district`
VALUES (130627, 1306, '唐  县');
INSERT INTO `province_city_district`
VALUES (130628, 1306, '高阳县');
INSERT INTO `province_city_district`
VALUES (130629, 1306, '容城县');
INSERT INTO `province_city_district`
VALUES (130630, 1306, '涞源县');
INSERT INTO `province_city_district`
VALUES (130631, 1306, '望都县');
INSERT INTO `province_city_district`
VALUES (130632, 1306, '安新县');
INSERT INTO `province_city_district`
VALUES (130633, 1306, '易  县');
INSERT INTO `province_city_district`
VALUES (130634, 1306, '曲阳县');
INSERT INTO `province_city_district`
VALUES (130635, 1306, '蠡  县');
INSERT INTO `province_city_district`
VALUES (130636, 1306, '顺平县');
INSERT INTO `province_city_district`
VALUES (130637, 1306, '博野县');
INSERT INTO `province_city_district`
VALUES (130638, 1306, '雄  县');
INSERT INTO `province_city_district`
VALUES (130681, 1306, '涿州市');
INSERT INTO `province_city_district`
VALUES (130682, 1306, '定州市');
INSERT INTO `province_city_district`
VALUES (130683, 1306, '安国市');
INSERT INTO `province_city_district`
VALUES (130684, 1306, '高碑店市');
INSERT INTO `province_city_district`
VALUES (130701, 1307, '市辖区');
INSERT INTO `province_city_district`
VALUES (130702, 1307, '桥东区');
INSERT INTO `province_city_district`
VALUES (130703, 1307, '桥西区');
INSERT INTO `province_city_district`
VALUES (130705, 1307, '宣化区');
INSERT INTO `province_city_district`
VALUES (130706, 1307, '下花园区');
INSERT INTO `province_city_district`
VALUES (130721, 1307, '宣化县');
INSERT INTO `province_city_district`
VALUES (130722, 1307, '张北县');
INSERT INTO `province_city_district`
VALUES (130723, 1307, '康保县');
INSERT INTO `province_city_district`
VALUES (130724, 1307, '沽源县');
INSERT INTO `province_city_district`
VALUES (130725, 1307, '尚义县');
INSERT INTO `province_city_district`
VALUES (130726, 1307, '蔚  县');
INSERT INTO `province_city_district`
VALUES (130727, 1307, '阳原县');
INSERT INTO `province_city_district`
VALUES (130728, 1307, '怀安县');
INSERT INTO `province_city_district`
VALUES (130729, 1307, '万全县');
INSERT INTO `province_city_district`
VALUES (130730, 1307, '怀来县');
INSERT INTO `province_city_district`
VALUES (130731, 1307, '涿鹿县');
INSERT INTO `province_city_district`
VALUES (130732, 1307, '赤城县');
INSERT INTO `province_city_district`
VALUES (130733, 1307, '崇礼县');
INSERT INTO `province_city_district`
VALUES (130801, 1308, '市辖区');
INSERT INTO `province_city_district`
VALUES (130802, 1308, '双桥区');
INSERT INTO `province_city_district`
VALUES (130803, 1308, '双滦区');
INSERT INTO `province_city_district`
VALUES (130804, 1308, '鹰手营子矿区');
INSERT INTO `province_city_district`
VALUES (130821, 1308, '承德县');
INSERT INTO `province_city_district`
VALUES (130822, 1308, '兴隆县');
INSERT INTO `province_city_district`
VALUES (130823, 1308, '平泉县');
INSERT INTO `province_city_district`
VALUES (130824, 1308, '滦平县');
INSERT INTO `province_city_district`
VALUES (130825, 1308, '隆化县');
INSERT INTO `province_city_district`
VALUES (130826, 1308, '丰宁满族自治县');
INSERT INTO `province_city_district`
VALUES (130827, 1308, '宽城满族自治县');
INSERT INTO `province_city_district`
VALUES (130828, 1308, '围场满族蒙古族自治县');
INSERT INTO `province_city_district`
VALUES (130901, 1309, '市辖区');
INSERT INTO `province_city_district`
VALUES (130902, 1309, '新华区');
INSERT INTO `province_city_district`
VALUES (130903, 1309, '运河区');
INSERT INTO `province_city_district`
VALUES (130921, 1309, '沧  县');
INSERT INTO `province_city_district`
VALUES (130922, 1309, '青  县');
INSERT INTO `province_city_district`
VALUES (130923, 1309, '东光县');
INSERT INTO `province_city_district`
VALUES (130924, 1309, '海兴县');
INSERT INTO `province_city_district`
VALUES (130925, 1309, '盐山县');
INSERT INTO `province_city_district`
VALUES (130926, 1309, '肃宁县');
INSERT INTO `province_city_district`
VALUES (130927, 1309, '南皮县');
INSERT INTO `province_city_district`
VALUES (130928, 1309, '吴桥县');
INSERT INTO `province_city_district`
VALUES (130929, 1309, '献  县');
INSERT INTO `province_city_district`
VALUES (130930, 1309, '孟村回族自治县');
INSERT INTO `province_city_district`
VALUES (130981, 1309, '泊头市');
INSERT INTO `province_city_district`
VALUES (130982, 1309, '任丘市');
INSERT INTO `province_city_district`
VALUES (130983, 1309, '黄骅市');
INSERT INTO `province_city_district`
VALUES (130984, 1309, '河间市');
INSERT INTO `province_city_district`
VALUES (131001, 1310, '市辖区');
INSERT INTO `province_city_district`
VALUES (131002, 1310, '安次区');
INSERT INTO `province_city_district`
VALUES (131003, 1310, '廊坊市广阳区');
INSERT INTO `province_city_district`
VALUES (131022, 1310, '固安县');
INSERT INTO `province_city_district`
VALUES (131023, 1310, '永清县');
INSERT INTO `province_city_district`
VALUES (131024, 1310, '香河县');
INSERT INTO `province_city_district`
VALUES (131025, 1310, '大城县');
INSERT INTO `province_city_district`
VALUES (131026, 1310, '文安县');
INSERT INTO `province_city_district`
VALUES (131028, 1310, '大厂回族自治县');
INSERT INTO `province_city_district`
VALUES (131081, 1310, '霸州市');
INSERT INTO `province_city_district`
VALUES (131082, 1310, '三河市');
INSERT INTO `province_city_district`
VALUES (131101, 1311, '市辖区');
INSERT INTO `province_city_district`
VALUES (131102, 1311, '桃城区');
INSERT INTO `province_city_district`
VALUES (131121, 1311, '枣强县');
INSERT INTO `province_city_district`
VALUES (131122, 1311, '武邑县');
INSERT INTO `province_city_district`
VALUES (131123, 1311, '武强县');
INSERT INTO `province_city_district`
VALUES (131124, 1311, '饶阳县');
INSERT INTO `province_city_district`
VALUES (131125, 1311, '安平县');
INSERT INTO `province_city_district`
VALUES (131126, 1311, '故城县');
INSERT INTO `province_city_district`
VALUES (131127, 1311, '景  县');
INSERT INTO `province_city_district`
VALUES (131128, 1311, '阜城县');
INSERT INTO `province_city_district`
VALUES (131181, 1311, '冀州市');
INSERT INTO `province_city_district`
VALUES (131182, 1311, '深州市');
INSERT INTO `province_city_district`
VALUES (140101, 1401, '市辖区');
INSERT INTO `province_city_district`
VALUES (140105, 1401, '小店区');
INSERT INTO `province_city_district`
VALUES (140106, 1401, '迎泽区');
INSERT INTO `province_city_district`
VALUES (140107, 1401, '杏花岭区');
INSERT INTO `province_city_district`
VALUES (140108, 1401, '尖草坪区');
INSERT INTO `province_city_district`
VALUES (140109, 1401, '万柏林区');
INSERT INTO `province_city_district`
VALUES (140110, 1401, '晋源区');
INSERT INTO `province_city_district`
VALUES (140121, 1401, '清徐县');
INSERT INTO `province_city_district`
VALUES (140122, 1401, '阳曲县');
INSERT INTO `province_city_district`
VALUES (140123, 1401, '娄烦县');
INSERT INTO `province_city_district`
VALUES (140181, 1401, '古交市');
INSERT INTO `province_city_district`
VALUES (140201, 1402, '市辖区');
INSERT INTO `province_city_district`
VALUES (140202, 1402, '城  区');
INSERT INTO `province_city_district`
VALUES (140203, 1402, '矿  区');
INSERT INTO `province_city_district`
VALUES (140211, 1402, '南郊区');
INSERT INTO `province_city_district`
VALUES (140212, 1402, '新荣区');
INSERT INTO `province_city_district`
VALUES (140221, 1402, '阳高县');
INSERT INTO `province_city_district`
VALUES (140222, 1402, '天镇县');
INSERT INTO `province_city_district`
VALUES (140223, 1402, '广灵县');
INSERT INTO `province_city_district`
VALUES (140224, 1402, '灵丘县');
INSERT INTO `province_city_district`
VALUES (140225, 1402, '浑源县');
INSERT INTO `province_city_district`
VALUES (140226, 1402, '左云县');
INSERT INTO `province_city_district`
VALUES (140227, 1402, '大同县');
INSERT INTO `province_city_district`
VALUES (140301, 1403, '市辖区');
INSERT INTO `province_city_district`
VALUES (140302, 1403, '城  区');
INSERT INTO `province_city_district`
VALUES (140303, 1403, '矿  区');
INSERT INTO `province_city_district`
VALUES (140311, 1403, '郊  区');
INSERT INTO `province_city_district`
VALUES (140321, 1403, '平定县');
INSERT INTO `province_city_district`
VALUES (140322, 1403, '盂  县');
INSERT INTO `province_city_district`
VALUES (140401, 1404, '市辖区');
INSERT INTO `province_city_district`
VALUES (140402, 1404, '城  区');
INSERT INTO `province_city_district`
VALUES (140411, 1404, '郊  区');
INSERT INTO `province_city_district`
VALUES (140421, 1404, '长治县');
INSERT INTO `province_city_district`
VALUES (140423, 1404, '襄垣县');
INSERT INTO `province_city_district`
VALUES (140424, 1404, '屯留县');
INSERT INTO `province_city_district`
VALUES (140425, 1404, '平顺县');
INSERT INTO `province_city_district`
VALUES (140426, 1404, '黎城县');
INSERT INTO `province_city_district`
VALUES (140427, 1404, '壶关县');
INSERT INTO `province_city_district`
VALUES (140428, 1404, '长子县');
INSERT INTO `province_city_district`
VALUES (140429, 1404, '武乡县');
INSERT INTO `province_city_district`
VALUES (140430, 1404, '沁  县');
INSERT INTO `province_city_district`
VALUES (140431, 1404, '沁源县');
INSERT INTO `province_city_district`
VALUES (140481, 1404, '潞城市');
INSERT INTO `province_city_district`
VALUES (140501, 1405, '市辖区');
INSERT INTO `province_city_district`
VALUES (140502, 1405, '城  区');
INSERT INTO `province_city_district`
VALUES (140521, 1405, '沁水县');
INSERT INTO `province_city_district`
VALUES (140522, 1405, '阳城县');
INSERT INTO `province_city_district`
VALUES (140524, 1405, '陵川县');
INSERT INTO `province_city_district`
VALUES (140525, 1405, '泽州县');
INSERT INTO `province_city_district`
VALUES (140581, 1405, '高平市');
INSERT INTO `province_city_district`
VALUES (140601, 1406, '市辖区');
INSERT INTO `province_city_district`
VALUES (140602, 1406, '朔城区');
INSERT INTO `province_city_district`
VALUES (140603, 1406, '平鲁区');
INSERT INTO `province_city_district`
VALUES (140621, 1406, '山阴县');
INSERT INTO `province_city_district`
VALUES (140622, 1406, '应  县');
INSERT INTO `province_city_district`
VALUES (140623, 1406, '右玉县');
INSERT INTO `province_city_district`
VALUES (140624, 1406, '怀仁县');
INSERT INTO `province_city_district`
VALUES (140701, 1407, '市辖区');
INSERT INTO `province_city_district`
VALUES (140702, 1407, '榆次区');
INSERT INTO `province_city_district`
VALUES (140721, 1407, '榆社县');
INSERT INTO `province_city_district`
VALUES (140722, 1407, '左权县');
INSERT INTO `province_city_district`
VALUES (140723, 1407, '和顺县');
INSERT INTO `province_city_district`
VALUES (140724, 1407, '昔阳县');
INSERT INTO `province_city_district`
VALUES (140725, 1407, '寿阳县');
INSERT INTO `province_city_district`
VALUES (140726, 1407, '太谷县');
INSERT INTO `province_city_district`
VALUES (140727, 1407, '祁  县');
INSERT INTO `province_city_district`
VALUES (140728, 1407, '平遥县');
INSERT INTO `province_city_district`
VALUES (140729, 1407, '灵石县');
INSERT INTO `province_city_district`
VALUES (140781, 1407, '介休市');
INSERT INTO `province_city_district`
VALUES (140801, 1408, '市辖区');
INSERT INTO `province_city_district`
VALUES (140802, 1408, '盐湖区');
INSERT INTO `province_city_district`
VALUES (140821, 1408, '临猗县');
INSERT INTO `province_city_district`
VALUES (140822, 1408, '万荣县');
INSERT INTO `province_city_district`
VALUES (140823, 1408, '闻喜县');
INSERT INTO `province_city_district`
VALUES (140824, 1408, '稷山县');
INSERT INTO `province_city_district`
VALUES (140825, 1408, '新绛县');
INSERT INTO `province_city_district`
VALUES (140826, 1408, '绛  县');
INSERT INTO `province_city_district`
VALUES (140827, 1408, '垣曲县');
INSERT INTO `province_city_district`
VALUES (140828, 1408, '夏  县');
INSERT INTO `province_city_district`
VALUES (140829, 1408, '平陆县');
INSERT INTO `province_city_district`
VALUES (140830, 1408, '芮城县');
INSERT INTO `province_city_district`
VALUES (140881, 1408, '永济市');
INSERT INTO `province_city_district`
VALUES (140882, 1408, '河津市');
INSERT INTO `province_city_district`
VALUES (140901, 1409, '市辖区');
INSERT INTO `province_city_district`
VALUES (140902, 1409, '忻府区');
INSERT INTO `province_city_district`
VALUES (140921, 1409, '定襄县');
INSERT INTO `province_city_district`
VALUES (140922, 1409, '五台县');
INSERT INTO `province_city_district`
VALUES (140923, 1409, '代  县');
INSERT INTO `province_city_district`
VALUES (140924, 1409, '繁峙县');
INSERT INTO `province_city_district`
VALUES (140925, 1409, '宁武县');
INSERT INTO `province_city_district`
VALUES (140926, 1409, '静乐县');
INSERT INTO `province_city_district`
VALUES (140927, 1409, '神池县');
INSERT INTO `province_city_district`
VALUES (140928, 1409, '五寨县');
INSERT INTO `province_city_district`
VALUES (140929, 1409, '岢岚县');
INSERT INTO `province_city_district`
VALUES (140930, 1409, '河曲县');
INSERT INTO `province_city_district`
VALUES (140931, 1409, '保德县');
INSERT INTO `province_city_district`
VALUES (140932, 1409, '偏关县');
INSERT INTO `province_city_district`
VALUES (140981, 1409, '原平市');
INSERT INTO `province_city_district`
VALUES (141001, 1410, '市辖区');
INSERT INTO `province_city_district`
VALUES (141002, 1410, '尧都区');
INSERT INTO `province_city_district`
VALUES (141021, 1410, '曲沃县');
INSERT INTO `province_city_district`
VALUES (141022, 1410, '翼城县');
INSERT INTO `province_city_district`
VALUES (141023, 1410, '襄汾县');
INSERT INTO `province_city_district`
VALUES (141024, 1410, '洪洞县');
INSERT INTO `province_city_district`
VALUES (141025, 1410, '古  县');
INSERT INTO `province_city_district`
VALUES (141026, 1410, '安泽县');
INSERT INTO `province_city_district`
VALUES (141027, 1410, '浮山县');
INSERT INTO `province_city_district`
VALUES (141028, 1410, '吉  县');
INSERT INTO `province_city_district`
VALUES (141029, 1410, '乡宁县');
INSERT INTO `province_city_district`
VALUES (141030, 1410, '大宁县');
INSERT INTO `province_city_district`
VALUES (141031, 1410, '隰  县');
INSERT INTO `province_city_district`
VALUES (141032, 1410, '永和县');
INSERT INTO `province_city_district`
VALUES (141033, 1410, '蒲  县');
INSERT INTO `province_city_district`
VALUES (141034, 1410, '汾西县');
INSERT INTO `province_city_district`
VALUES (141081, 1410, '侯马市');
INSERT INTO `province_city_district`
VALUES (141082, 1410, '霍州市');
INSERT INTO `province_city_district`
VALUES (142301, 1423, '孝义市');
INSERT INTO `province_city_district`
VALUES (142302, 1423, '离石市');
INSERT INTO `province_city_district`
VALUES (142303, 1423, '汾阳市');
INSERT INTO `province_city_district`
VALUES (142322, 1423, '文水县');
INSERT INTO `province_city_district`
VALUES (142323, 1423, '交城县');
INSERT INTO `province_city_district`
VALUES (142325, 1423, '兴  县');
INSERT INTO `province_city_district`
VALUES (142326, 1423, '临  县');
INSERT INTO `province_city_district`
VALUES (142327, 1423, '柳林县');
INSERT INTO `province_city_district`
VALUES (142328, 1423, '石楼县');
INSERT INTO `province_city_district`
VALUES (142329, 1423, '岚  县');
INSERT INTO `province_city_district`
VALUES (142330, 1423, '方山县');
INSERT INTO `province_city_district`
VALUES (142332, 1423, '中阳县');
INSERT INTO `province_city_district`
VALUES (142333, 1423, '交口县');
INSERT INTO `province_city_district`
VALUES (150101, 1501, '市辖区');
INSERT INTO `province_city_district`
VALUES (150102, 1501, '新城区');
INSERT INTO `province_city_district`
VALUES (150103, 1501, '回民区');
INSERT INTO `province_city_district`
VALUES (150104, 1501, '玉泉区');
INSERT INTO `province_city_district`
VALUES (150105, 1501, '赛罕区');
INSERT INTO `province_city_district`
VALUES (150121, 1501, '土默特左旗');
INSERT INTO `province_city_district`
VALUES (150122, 1501, '托克托县');
INSERT INTO `province_city_district`
VALUES (150123, 1501, '和林格尔县');
INSERT INTO `province_city_district`
VALUES (150124, 1501, '清水河县');
INSERT INTO `province_city_district`
VALUES (150125, 1501, '武川县');
INSERT INTO `province_city_district`
VALUES (150201, 1502, '市辖区');
INSERT INTO `province_city_district`
VALUES (150202, 1502, '东河区');
INSERT INTO `province_city_district`
VALUES (150203, 1502, '昆都伦区');
INSERT INTO `province_city_district`
VALUES (150204, 1502, '青山区');
INSERT INTO `province_city_district`
VALUES (150205, 1502, '石拐区');
INSERT INTO `province_city_district`
VALUES (150206, 1502, '白云矿区');
INSERT INTO `province_city_district`
VALUES (150207, 1502, '九原区');
INSERT INTO `province_city_district`
VALUES (150221, 1502, '土默特右旗');
INSERT INTO `province_city_district`
VALUES (150222, 1502, '固阳县');
INSERT INTO `province_city_district`
VALUES (150223, 1502, '达尔罕茂明安联合旗');
INSERT INTO `province_city_district`
VALUES (150301, 1503, '市辖区');
INSERT INTO `province_city_district`
VALUES (150302, 1503, '海勃湾区');
INSERT INTO `province_city_district`
VALUES (150303, 1503, '海南区');
INSERT INTO `province_city_district`
VALUES (150304, 1503, '乌达区');
INSERT INTO `province_city_district`
VALUES (150401, 1504, '市辖区');
INSERT INTO `province_city_district`
VALUES (150402, 1504, '红山区');
INSERT INTO `province_city_district`
VALUES (150403, 1504, '元宝山区');
INSERT INTO `province_city_district`
VALUES (150404, 1504, '松山区');
INSERT INTO `province_city_district`
VALUES (150421, 1504, '阿鲁科尔沁旗');
INSERT INTO `province_city_district`
VALUES (150422, 1504, '巴林左旗');
INSERT INTO `province_city_district`
VALUES (150423, 1504, '巴林右旗');
INSERT INTO `province_city_district`
VALUES (150424, 1504, '林西县');
INSERT INTO `province_city_district`
VALUES (150425, 1504, '克什克腾旗');
INSERT INTO `province_city_district`
VALUES (150426, 1504, '翁牛特旗');
INSERT INTO `province_city_district`
VALUES (150428, 1504, '喀喇沁旗');
INSERT INTO `province_city_district`
VALUES (150429, 1504, '宁城县');
INSERT INTO `province_city_district`
VALUES (150430, 1504, '敖汉旗');
INSERT INTO `province_city_district`
VALUES (150501, 1505, '市辖区');
INSERT INTO `province_city_district`
VALUES (150502, 1505, '科尔沁区');
INSERT INTO `province_city_district`
VALUES (150521, 1505, '科尔沁左翼中旗');
INSERT INTO `province_city_district`
VALUES (150522, 1505, '科尔沁左翼后旗');
INSERT INTO `province_city_district`
VALUES (150523, 1505, '开鲁县');
INSERT INTO `province_city_district`
VALUES (150524, 1505, '库伦旗');
INSERT INTO `province_city_district`
VALUES (150525, 1505, '奈曼旗');
INSERT INTO `province_city_district`
VALUES (150526, 1505, '扎鲁特旗');
INSERT INTO `province_city_district`
VALUES (150581, 1505, '霍林郭勒市');
INSERT INTO `province_city_district`
VALUES (152101, 1521, '海拉尔市');
INSERT INTO `province_city_district`
VALUES (152102, 1521, '满洲里市');
INSERT INTO `province_city_district`
VALUES (152103, 1521, '扎兰屯市');
INSERT INTO `province_city_district`
VALUES (152104, 1521, '牙克石市');
INSERT INTO `province_city_district`
VALUES (152105, 1521, '根河市');
INSERT INTO `province_city_district`
VALUES (152106, 1521, '额尔古纳市');
INSERT INTO `province_city_district`
VALUES (152122, 1521, '阿荣旗');
INSERT INTO `province_city_district`
VALUES (152123, 1521, '莫力达瓦达斡尔族自治');
INSERT INTO `province_city_district`
VALUES (152127, 1521, '鄂伦春自治旗');
INSERT INTO `province_city_district`
VALUES (152128, 1521, '鄂温克族自治旗');
INSERT INTO `province_city_district`
VALUES (152129, 1521, '新巴尔虎右旗');
INSERT INTO `province_city_district`
VALUES (152130, 1521, '新巴尔虎左旗');
INSERT INTO `province_city_district`
VALUES (152131, 1521, '陈巴尔虎旗');
INSERT INTO `province_city_district`
VALUES (152201, 1522, '乌兰浩特市');
INSERT INTO `province_city_district`
VALUES (152202, 1522, '阿尔山市');
INSERT INTO `province_city_district`
VALUES (152221, 1522, '科尔沁右翼前旗');
INSERT INTO `province_city_district`
VALUES (152222, 1522, '科尔沁右翼中旗');
INSERT INTO `province_city_district`
VALUES (152223, 1522, '扎赉特旗');
INSERT INTO `province_city_district`
VALUES (152224, 1522, '突泉县');
INSERT INTO `province_city_district`
VALUES (152501, 1525, '二连浩特市');
INSERT INTO `province_city_district`
VALUES (152502, 1525, '锡林浩特市');
INSERT INTO `province_city_district`
VALUES (152522, 1525, '阿巴嘎旗');
INSERT INTO `province_city_district`
VALUES (152523, 1525, '苏尼特左旗');
INSERT INTO `province_city_district`
VALUES (152524, 1525, '苏尼特右旗');
INSERT INTO `province_city_district`
VALUES (152525, 1525, '东乌珠穆沁旗');
INSERT INTO `province_city_district`
VALUES (152526, 1525, '西乌珠穆沁旗');
INSERT INTO `province_city_district`
VALUES (152527, 1525, '太仆寺旗');
INSERT INTO `province_city_district`
VALUES (152528, 1525, '镶黄旗');
INSERT INTO `province_city_district`
VALUES (152529, 1525, '正镶白旗');
INSERT INTO `province_city_district`
VALUES (152530, 1525, '正蓝旗');
INSERT INTO `province_city_district`
VALUES (152531, 1525, '多伦县');
INSERT INTO `province_city_district`
VALUES (152601, 1526, '集宁市');
INSERT INTO `province_city_district`
VALUES (152602, 1526, '丰镇市');
INSERT INTO `province_city_district`
VALUES (152624, 1526, '卓资县');
INSERT INTO `province_city_district`
VALUES (152625, 1526, '化德县');
INSERT INTO `province_city_district`
VALUES (152626, 1526, '商都县');
INSERT INTO `province_city_district`
VALUES (152627, 1526, '兴和县');
INSERT INTO `province_city_district`
VALUES (152629, 1526, '凉城县');
INSERT INTO `province_city_district`
VALUES (152630, 1526, '察哈尔右翼前旗');
INSERT INTO `province_city_district`
VALUES (152631, 1526, '察哈尔右翼中旗');
INSERT INTO `province_city_district`
VALUES (152632, 1526, '察哈尔右翼后旗');
INSERT INTO `province_city_district`
VALUES (152634, 1526, '四子王旗');
INSERT INTO `province_city_district`
VALUES (152701, 1527, '东胜市');
INSERT INTO `province_city_district`
VALUES (152722, 1527, '达拉特旗');
INSERT INTO `province_city_district`
VALUES (152723, 1527, '准格尔旗');
INSERT INTO `province_city_district`
VALUES (152724, 1527, '鄂托克前旗');
INSERT INTO `province_city_district`
VALUES (152725, 1527, '鄂托克旗');
INSERT INTO `province_city_district`
VALUES (152726, 1527, '杭锦旗');
INSERT INTO `province_city_district`
VALUES (152727, 1527, '乌审旗');
INSERT INTO `province_city_district`
VALUES (152728, 1527, '伊金霍洛旗');
INSERT INTO `province_city_district`
VALUES (152801, 1528, '临河市');
INSERT INTO `province_city_district`
VALUES (152822, 1528, '五原县');
INSERT INTO `province_city_district`
VALUES (152823, 1528, '磴口县');
INSERT INTO `province_city_district`
VALUES (152824, 1528, '乌拉特前旗');
INSERT INTO `province_city_district`
VALUES (152825, 1528, '乌拉特中旗');
INSERT INTO `province_city_district`
VALUES (152826, 1528, '乌拉特后旗');
INSERT INTO `province_city_district`
VALUES (152827, 1528, '杭锦后旗');
INSERT INTO `province_city_district`
VALUES (152921, 1529, '阿拉善左旗');
INSERT INTO `province_city_district`
VALUES (152922, 1529, '阿拉善右旗');
INSERT INTO `province_city_district`
VALUES (152923, 1529, '额济纳旗');
INSERT INTO `province_city_district`
VALUES (210101, 2101, '市辖区');
INSERT INTO `province_city_district`
VALUES (210102, 2101, '和平区');
INSERT INTO `province_city_district`
VALUES (210103, 2101, '沈河区');
INSERT INTO `province_city_district`
VALUES (210104, 2101, '大东区');
INSERT INTO `province_city_district`
VALUES (210105, 2101, '皇姑区');
INSERT INTO `province_city_district`
VALUES (210106, 2101, '铁西区');
INSERT INTO `province_city_district`
VALUES (210111, 2101, '苏家屯区');
INSERT INTO `province_city_district`
VALUES (210112, 2101, '东陵区');
INSERT INTO `province_city_district`
VALUES (210113, 2101, '新城子区');
INSERT INTO `province_city_district`
VALUES (210114, 2101, '于洪区');
INSERT INTO `province_city_district`
VALUES (210122, 2101, '辽中县');
INSERT INTO `province_city_district`
VALUES (210123, 2101, '康平县');
INSERT INTO `province_city_district`
VALUES (210124, 2101, '法库县');
INSERT INTO `province_city_district`
VALUES (210181, 2101, '新民市');
INSERT INTO `province_city_district`
VALUES (210201, 2102, '市辖区');
INSERT INTO `province_city_district`
VALUES (210202, 2102, '中山区');
INSERT INTO `province_city_district`
VALUES (210203, 2102, '西岗区');
INSERT INTO `province_city_district`
VALUES (210204, 2102, '沙河口区');
INSERT INTO `province_city_district`
VALUES (210211, 2102, '甘井子区');
INSERT INTO `province_city_district`
VALUES (210212, 2102, '旅顺口区');
INSERT INTO `province_city_district`
VALUES (210213, 2102, '金州区');
INSERT INTO `province_city_district`
VALUES (210224, 2102, '长海县');
INSERT INTO `province_city_district`
VALUES (210281, 2102, '瓦房店市');
INSERT INTO `province_city_district`
VALUES (210282, 2102, '普兰店市');
INSERT INTO `province_city_district`
VALUES (210283, 2102, '庄河市');
INSERT INTO `province_city_district`
VALUES (210301, 2103, '市辖区');
INSERT INTO `province_city_district`
VALUES (210302, 2103, '铁东区');
INSERT INTO `province_city_district`
VALUES (210303, 2103, '铁西区');
INSERT INTO `province_city_district`
VALUES (210304, 2103, '立山区');
INSERT INTO `province_city_district`
VALUES (210311, 2103, '千山区');
INSERT INTO `province_city_district`
VALUES (210321, 2103, '台安县');
INSERT INTO `province_city_district`
VALUES (210323, 2103, '岫岩满族自治县');
INSERT INTO `province_city_district`
VALUES (210381, 2103, '海城市');
INSERT INTO `province_city_district`
VALUES (210401, 2104, '市辖区');
INSERT INTO `province_city_district`
VALUES (210402, 2104, '新抚区');
INSERT INTO `province_city_district`
VALUES (210403, 2104, '东洲区');
INSERT INTO `province_city_district`
VALUES (210404, 2104, '望花区');
INSERT INTO `province_city_district`
VALUES (210411, 2104, '顺城区');
INSERT INTO `province_city_district`
VALUES (210421, 2104, '抚顺县');
INSERT INTO `province_city_district`
VALUES (210422, 2104, '新宾满族自治县');
INSERT INTO `province_city_district`
VALUES (210423, 2104, '清原满族自治县');
INSERT INTO `province_city_district`
VALUES (210501, 2105, '市辖区');
INSERT INTO `province_city_district`
VALUES (210502, 2105, '平山区');
INSERT INTO `province_city_district`
VALUES (210503, 2105, '溪湖区');
INSERT INTO `province_city_district`
VALUES (210504, 2105, '明山区');
INSERT INTO `province_city_district`
VALUES (210505, 2105, '南芬区');
INSERT INTO `province_city_district`
VALUES (210521, 2105, '本溪满族自治县');
INSERT INTO `province_city_district`
VALUES (210522, 2105, '桓仁满族自治县');
INSERT INTO `province_city_district`
VALUES (210601, 2106, '市辖区');
INSERT INTO `province_city_district`
VALUES (210602, 2106, '元宝区');
INSERT INTO `province_city_district`
VALUES (210603, 2106, '振兴区');
INSERT INTO `province_city_district`
VALUES (210604, 2106, '振安区');
INSERT INTO `province_city_district`
VALUES (210624, 2106, '宽甸满族自治县');
INSERT INTO `province_city_district`
VALUES (210681, 2106, '东港市');
INSERT INTO `province_city_district`
VALUES (210682, 2106, '凤城市');
INSERT INTO `province_city_district`
VALUES (210701, 2107, '市辖区');
INSERT INTO `province_city_district`
VALUES (210702, 2107, '古塔区');
INSERT INTO `province_city_district`
VALUES (210703, 2107, '凌河区');
INSERT INTO `province_city_district`
VALUES (210711, 2107, '太和区');
INSERT INTO `province_city_district`
VALUES (210726, 2107, '黑山县');
INSERT INTO `province_city_district`
VALUES (210727, 2107, '义  县');
INSERT INTO `province_city_district`
VALUES (210781, 2107, '凌海市');
INSERT INTO `province_city_district`
VALUES (210782, 2107, '北宁市');
INSERT INTO `province_city_district`
VALUES (210801, 2108, '市辖区');
INSERT INTO `province_city_district`
VALUES (210802, 2108, '站前区');
INSERT INTO `province_city_district`
VALUES (210803, 2108, '西市区');
INSERT INTO `province_city_district`
VALUES (210804, 2108, '鲅鱼圈区');
INSERT INTO `province_city_district`
VALUES (210811, 2108, '老边区');
INSERT INTO `province_city_district`
VALUES (210881, 2108, '盖州市');
INSERT INTO `province_city_district`
VALUES (210882, 2108, '大石桥市');
INSERT INTO `province_city_district`
VALUES (210901, 2109, '市辖区');
INSERT INTO `province_city_district`
VALUES (210902, 2109, '海州区');
INSERT INTO `province_city_district`
VALUES (210903, 2109, '新邱区');
INSERT INTO `province_city_district`
VALUES (210904, 2109, '太平区');
INSERT INTO `province_city_district`
VALUES (210905, 2109, '清河门区');
INSERT INTO `province_city_district`
VALUES (210911, 2109, '细河区');
INSERT INTO `province_city_district`
VALUES (210921, 2109, '阜新蒙古族自治县');
INSERT INTO `province_city_district`
VALUES (210922, 2109, '彰武县');
INSERT INTO `province_city_district`
VALUES (211001, 2110, '市辖区');
INSERT INTO `province_city_district`
VALUES (211002, 2110, '白塔区');
INSERT INTO `province_city_district`
VALUES (211003, 2110, '文圣区');
INSERT INTO `province_city_district`
VALUES (211004, 2110, '宏伟区');
INSERT INTO `province_city_district`
VALUES (211005, 2110, '弓长岭区');
INSERT INTO `province_city_district`
VALUES (211011, 2110, '太子河区');
INSERT INTO `province_city_district`
VALUES (211021, 2110, '辽阳县');
INSERT INTO `province_city_district`
VALUES (211081, 2110, '灯塔市');
INSERT INTO `province_city_district`
VALUES (211101, 2111, '市辖区');
INSERT INTO `province_city_district`
VALUES (211102, 2111, '双台子区');
INSERT INTO `province_city_district`
VALUES (211103, 2111, '兴隆台区');
INSERT INTO `province_city_district`
VALUES (211121, 2111, '大洼县');
INSERT INTO `province_city_district`
VALUES (211122, 2111, '盘山县');
INSERT INTO `province_city_district`
VALUES (211201, 2112, '市辖区');
INSERT INTO `province_city_district`
VALUES (211202, 2112, '银州区');
INSERT INTO `province_city_district`
VALUES (211204, 2112, '清河区');
INSERT INTO `province_city_district`
VALUES (211221, 2112, '铁岭县');
INSERT INTO `province_city_district`
VALUES (211223, 2112, '西丰县');
INSERT INTO `province_city_district`
VALUES (211224, 2112, '昌图县');
INSERT INTO `province_city_district`
VALUES (211281, 2112, '铁法市');
INSERT INTO `province_city_district`
VALUES (211282, 2112, '开原市');
INSERT INTO `province_city_district`
VALUES (211301, 2113, '市辖区');
INSERT INTO `province_city_district`
VALUES (211302, 2113, '双塔区');
INSERT INTO `province_city_district`
VALUES (211303, 2113, '龙城区');
INSERT INTO `province_city_district`
VALUES (211321, 2113, '朝阳县');
INSERT INTO `province_city_district`
VALUES (211322, 2113, '建平县');
INSERT INTO `province_city_district`
VALUES (211324, 2113, '喀喇沁左翼蒙古族自治');
INSERT INTO `province_city_district`
VALUES (211381, 2113, '北票市');
INSERT INTO `province_city_district`
VALUES (211382, 2113, '凌源市');
INSERT INTO `province_city_district`
VALUES (211401, 2114, '市辖区');
INSERT INTO `province_city_district`
VALUES (211402, 2114, '连山区');
INSERT INTO `province_city_district`
VALUES (211403, 2114, '龙港区');
INSERT INTO `province_city_district`
VALUES (211404, 2114, '南票区');
INSERT INTO `province_city_district`
VALUES (211421, 2114, '绥中县');
INSERT INTO `province_city_district`
VALUES (211422, 2114, '建昌县');
INSERT INTO `province_city_district`
VALUES (211481, 2114, '兴城市');
INSERT INTO `province_city_district`
VALUES (220101, 2201, '市辖区');
INSERT INTO `province_city_district`
VALUES (220102, 2201, '南关区');
INSERT INTO `province_city_district`
VALUES (220103, 2201, '宽城区');
INSERT INTO `province_city_district`
VALUES (220104, 2201, '朝阳区');
INSERT INTO `province_city_district`
VALUES (220105, 2201, '二道区');
INSERT INTO `province_city_district`
VALUES (220106, 2201, '绿园区');
INSERT INTO `province_city_district`
VALUES (220112, 2201, '双阳区');
INSERT INTO `province_city_district`
VALUES (220122, 2201, '农安县');
INSERT INTO `province_city_district`
VALUES (220181, 2201, '九台市');
INSERT INTO `province_city_district`
VALUES (220182, 2201, '榆树市');
INSERT INTO `province_city_district`
VALUES (220183, 2201, '德惠市');
INSERT INTO `province_city_district`
VALUES (220201, 2202, '市辖区');
INSERT INTO `province_city_district`
VALUES (220202, 2202, '昌邑区');
INSERT INTO `province_city_district`
VALUES (220203, 2202, '龙潭区');
INSERT INTO `province_city_district`
VALUES (220204, 2202, '船营区');
INSERT INTO `province_city_district`
VALUES (220211, 2202, '丰满区');
INSERT INTO `province_city_district`
VALUES (220221, 2202, '永吉县');
INSERT INTO `province_city_district`
VALUES (220281, 2202, '蛟河市');
INSERT INTO `province_city_district`
VALUES (220282, 2202, '桦甸市');
INSERT INTO `province_city_district`
VALUES (220283, 2202, '舒兰市');
INSERT INTO `province_city_district`
VALUES (220284, 2202, '磐石市');
INSERT INTO `province_city_district`
VALUES (220301, 2203, '市辖区');
INSERT INTO `province_city_district`
VALUES (220302, 2203, '铁西区');
INSERT INTO `province_city_district`
VALUES (220303, 2203, '铁东区');
INSERT INTO `province_city_district`
VALUES (220322, 2203, '梨树县');
INSERT INTO `province_city_district`
VALUES (220323, 2203, '伊通满族自治县');
INSERT INTO `province_city_district`
VALUES (220381, 2203, '公主岭市');
INSERT INTO `province_city_district`
VALUES (220382, 2203, '双辽市');
INSERT INTO `province_city_district`
VALUES (220401, 2204, '市辖区');
INSERT INTO `province_city_district`
VALUES (220402, 2204, '龙山区');
INSERT INTO `province_city_district`
VALUES (220403, 2204, '西安区');
INSERT INTO `province_city_district`
VALUES (220421, 2204, '东丰县');
INSERT INTO `province_city_district`
VALUES (220422, 2204, '东辽县');
INSERT INTO `province_city_district`
VALUES (220501, 2205, '市辖区');
INSERT INTO `province_city_district`
VALUES (220502, 2205, '东昌区');
INSERT INTO `province_city_district`
VALUES (220503, 2205, '二道江区');
INSERT INTO `province_city_district`
VALUES (220521, 2205, '通化县');
INSERT INTO `province_city_district`
VALUES (220523, 2205, '辉南县');
INSERT INTO `province_city_district`
VALUES (220524, 2205, '柳河县');
INSERT INTO `province_city_district`
VALUES (220581, 2205, '梅河口市');
INSERT INTO `province_city_district`
VALUES (220582, 2205, '集安市');
INSERT INTO `province_city_district`
VALUES (220601, 2206, '市辖区');
INSERT INTO `province_city_district`
VALUES (220602, 2206, '八道江区');
INSERT INTO `province_city_district`
VALUES (220621, 2206, '抚松县');
INSERT INTO `province_city_district`
VALUES (220622, 2206, '靖宇县');
INSERT INTO `province_city_district`
VALUES (220623, 2206, '长白朝鲜族自治县');
INSERT INTO `province_city_district`
VALUES (220625, 2206, '江源县');
INSERT INTO `province_city_district`
VALUES (220681, 2206, '临江市');
INSERT INTO `province_city_district`
VALUES (220701, 2207, '市辖区');
INSERT INTO `province_city_district`
VALUES (220702, 2207, '宁江区');
INSERT INTO `province_city_district`
VALUES (220721, 2207, '前郭尔罗斯蒙古族自治');
INSERT INTO `province_city_district`
VALUES (220722, 2207, '长岭县');
INSERT INTO `province_city_district`
VALUES (220723, 2207, '乾安县');
INSERT INTO `province_city_district`
VALUES (220724, 2207, '扶余县');
INSERT INTO `province_city_district`
VALUES (220801, 2208, '市辖区');
INSERT INTO `province_city_district`
VALUES (220802, 2208, '洮北区');
INSERT INTO `province_city_district`
VALUES (220821, 2208, '镇赉县');
INSERT INTO `province_city_district`
VALUES (220822, 2208, '通榆县');
INSERT INTO `province_city_district`
VALUES (220881, 2208, '洮南市');
INSERT INTO `province_city_district`
VALUES (220882, 2208, '大安市');
INSERT INTO `province_city_district`
VALUES (222401, 2224, '延吉市');
INSERT INTO `province_city_district`
VALUES (222402, 2224, '图们市');
INSERT INTO `province_city_district`
VALUES (222403, 2224, '敦化市');
INSERT INTO `province_city_district`
VALUES (222404, 2224, '珲春市');
INSERT INTO `province_city_district`
VALUES (222405, 2224, '龙井市');
INSERT INTO `province_city_district`
VALUES (222406, 2224, '和龙市');
INSERT INTO `province_city_district`
VALUES (222424, 2224, '汪清县');
INSERT INTO `province_city_district`
VALUES (222426, 2224, '安图县');
INSERT INTO `province_city_district`
VALUES (230101, 2301, '市辖区');
INSERT INTO `province_city_district`
VALUES (230102, 2301, '道里区');
INSERT INTO `province_city_district`
VALUES (230103, 2301, '南岗区');
INSERT INTO `province_city_district`
VALUES (230104, 2301, '道外区');
INSERT INTO `province_city_district`
VALUES (230105, 2301, '太平区');
INSERT INTO `province_city_district`
VALUES (230106, 2301, '香坊区');
INSERT INTO `province_city_district`
VALUES (230107, 2301, '动力区');
INSERT INTO `province_city_district`
VALUES (230108, 2301, '平房区');
INSERT INTO `province_city_district`
VALUES (230121, 2301, '呼兰县');
INSERT INTO `province_city_district`
VALUES (230123, 2301, '依兰县');
INSERT INTO `province_city_district`
VALUES (230124, 2301, '方正县');
INSERT INTO `province_city_district`
VALUES (230125, 2301, '宾  县');
INSERT INTO `province_city_district`
VALUES (230126, 2301, '巴彦县');
INSERT INTO `province_city_district`
VALUES (230127, 2301, '木兰县');
INSERT INTO `province_city_district`
VALUES (230128, 2301, '通河县');
INSERT INTO `province_city_district`
VALUES (230129, 2301, '延寿县');
INSERT INTO `province_city_district`
VALUES (230181, 2301, '阿城市');
INSERT INTO `province_city_district`
VALUES (230182, 2301, '双城市');
INSERT INTO `province_city_district`
VALUES (230183, 2301, '尚志市');
INSERT INTO `province_city_district`
VALUES (230184, 2301, '五常市');
INSERT INTO `province_city_district`
VALUES (230201, 2302, '市辖区');
INSERT INTO `province_city_district`
VALUES (230202, 2302, '龙沙区');
INSERT INTO `province_city_district`
VALUES (230203, 2302, '建华区');
INSERT INTO `province_city_district`
VALUES (230204, 2302, '铁锋区');
INSERT INTO `province_city_district`
VALUES (230205, 2302, '昂昂溪区');
INSERT INTO `province_city_district`
VALUES (230206, 2302, '富拉尔基区');
INSERT INTO `province_city_district`
VALUES (230207, 2302, '碾子山区');
INSERT INTO `province_city_district`
VALUES (230208, 2302, '梅里斯达斡尔族区');
INSERT INTO `province_city_district`
VALUES (230221, 2302, '龙江县');
INSERT INTO `province_city_district`
VALUES (230223, 2302, '依安县');
INSERT INTO `province_city_district`
VALUES (230224, 2302, '泰来县');
INSERT INTO `province_city_district`
VALUES (230225, 2302, '甘南县');
INSERT INTO `province_city_district`
VALUES (230227, 2302, '富裕县');
INSERT INTO `province_city_district`
VALUES (230229, 2302, '克山县');
INSERT INTO `province_city_district`
VALUES (230230, 2302, '克东县');
INSERT INTO `province_city_district`
VALUES (230231, 2302, '拜泉县');
INSERT INTO `province_city_district`
VALUES (230281, 2302, '讷河市');
INSERT INTO `province_city_district`
VALUES (230301, 2303, '市辖区');
INSERT INTO `province_city_district`
VALUES (230302, 2303, '鸡冠区');
INSERT INTO `province_city_district`
VALUES (230303, 2303, '恒山区');
INSERT INTO `province_city_district`
VALUES (230304, 2303, '滴道区');
INSERT INTO `province_city_district`
VALUES (230305, 2303, '梨树区');
INSERT INTO `province_city_district`
VALUES (230306, 2303, '城子河区');
INSERT INTO `province_city_district`
VALUES (230307, 2303, '麻山区');
INSERT INTO `province_city_district`
VALUES (230321, 2303, '鸡东县');
INSERT INTO `province_city_district`
VALUES (230381, 2303, '虎林市');
INSERT INTO `province_city_district`
VALUES (230382, 2303, '密山市');
INSERT INTO `province_city_district`
VALUES (230401, 2304, '市辖区');
INSERT INTO `province_city_district`
VALUES (230402, 2304, '向阳区');
INSERT INTO `province_city_district`
VALUES (230403, 2304, '工农区');
INSERT INTO `province_city_district`
VALUES (230404, 2304, '南山区');
INSERT INTO `province_city_district`
VALUES (230405, 2304, '兴安区');
INSERT INTO `province_city_district`
VALUES (230406, 2304, '东山区');
INSERT INTO `province_city_district`
VALUES (230407, 2304, '兴山区');
INSERT INTO `province_city_district`
VALUES (230421, 2304, '萝北县');
INSERT INTO `province_city_district`
VALUES (230422, 2304, '绥滨县');
INSERT INTO `province_city_district`
VALUES (230501, 2305, '市辖区');
INSERT INTO `province_city_district`
VALUES (230502, 2305, '尖山区');
INSERT INTO `province_city_district`
VALUES (230503, 2305, '岭东区');
INSERT INTO `province_city_district`
VALUES (230505, 2305, '四方台区');
INSERT INTO `province_city_district`
VALUES (230506, 2305, '宝山区');
INSERT INTO `province_city_district`
VALUES (230521, 2305, '集贤县');
INSERT INTO `province_city_district`
VALUES (230522, 2305, '友谊县');
INSERT INTO `province_city_district`
VALUES (230523, 2305, '宝清县');
INSERT INTO `province_city_district`
VALUES (230524, 2305, '饶河县');
INSERT INTO `province_city_district`
VALUES (230601, 2306, '市辖区');
INSERT INTO `province_city_district`
VALUES (230602, 2306, '萨尔图区');
INSERT INTO `province_city_district`
VALUES (230603, 2306, '龙凤区');
INSERT INTO `province_city_district`
VALUES (230604, 2306, '让胡路区');
INSERT INTO `province_city_district`
VALUES (230605, 2306, '红岗区');
INSERT INTO `province_city_district`
VALUES (230606, 2306, '大同区');
INSERT INTO `province_city_district`
VALUES (230621, 2306, '肇州县');
INSERT INTO `province_city_district`
VALUES (230622, 2306, '肇源县');
INSERT INTO `province_city_district`
VALUES (230623, 2306, '林甸县');
INSERT INTO `province_city_district`
VALUES (230624, 2306, '杜尔伯特蒙古族自治县');
INSERT INTO `province_city_district`
VALUES (230701, 2307, '市辖区');
INSERT INTO `province_city_district`
VALUES (230702, 2307, '伊春区');
INSERT INTO `province_city_district`
VALUES (230703, 2307, '南岔区');
INSERT INTO `province_city_district`
VALUES (230704, 2307, '友好区');
INSERT INTO `province_city_district`
VALUES (230705, 2307, '西林区');
INSERT INTO `province_city_district`
VALUES (230706, 2307, '翠峦区');
INSERT INTO `province_city_district`
VALUES (230707, 2307, '新青区');
INSERT INTO `province_city_district`
VALUES (230708, 2307, '美溪区');
INSERT INTO `province_city_district`
VALUES (230709, 2307, '金山屯区');
INSERT INTO `province_city_district`
VALUES (230710, 2307, '五营区');
INSERT INTO `province_city_district`
VALUES (230711, 2307, '乌马河区');
INSERT INTO `province_city_district`
VALUES (230712, 2307, '汤旺河区');
INSERT INTO `province_city_district`
VALUES (230713, 2307, '带岭区');
INSERT INTO `province_city_district`
VALUES (230714, 2307, '乌伊岭区');
INSERT INTO `province_city_district`
VALUES (230715, 2307, '红星区');
INSERT INTO `province_city_district`
VALUES (230716, 2307, '上甘岭区');
INSERT INTO `province_city_district`
VALUES (230722, 2307, '嘉荫县');
INSERT INTO `province_city_district`
VALUES (230781, 2307, '铁力市');
INSERT INTO `province_city_district`
VALUES (230801, 2308, '市辖区');
INSERT INTO `province_city_district`
VALUES (230802, 2308, '永红区');
INSERT INTO `province_city_district`
VALUES (230803, 2308, '向阳区');
INSERT INTO `province_city_district`
VALUES (230804, 2308, '前进区');
INSERT INTO `province_city_district`
VALUES (230805, 2308, '东风区');
INSERT INTO `province_city_district`
VALUES (230811, 2308, '郊  区');
INSERT INTO `province_city_district`
VALUES (230822, 2308, '桦南县');
INSERT INTO `province_city_district`
VALUES (230826, 2308, '桦川县');
INSERT INTO `province_city_district`
VALUES (230828, 2308, '汤原县');
INSERT INTO `province_city_district`
VALUES (230833, 2308, '抚远县');
INSERT INTO `province_city_district`
VALUES (230881, 2308, '同江市');
INSERT INTO `province_city_district`
VALUES (230882, 2308, '富锦市');
INSERT INTO `province_city_district`
VALUES (230901, 2309, '市辖区');
INSERT INTO `province_city_district`
VALUES (230902, 2309, '新兴区');
INSERT INTO `province_city_district`
VALUES (230903, 2309, '桃山区');
INSERT INTO `province_city_district`
VALUES (230904, 2309, '茄子河区');
INSERT INTO `province_city_district`
VALUES (230921, 2309, '勃利县');
INSERT INTO `province_city_district`
VALUES (231001, 2310, '市辖区');
INSERT INTO `province_city_district`
VALUES (231002, 2310, '东安区');
INSERT INTO `province_city_district`
VALUES (231003, 2310, '阳明区');
INSERT INTO `province_city_district`
VALUES (231004, 2310, '爱民区');
INSERT INTO `province_city_district`
VALUES (231005, 2310, '西安区');
INSERT INTO `province_city_district`
VALUES (231024, 2310, '东宁县');
INSERT INTO `province_city_district`
VALUES (231025, 2310, '林口县');
INSERT INTO `province_city_district`
VALUES (231081, 2310, '绥芬河市');
INSERT INTO `province_city_district`
VALUES (231083, 2310, '海林市');
INSERT INTO `province_city_district`
VALUES (231084, 2310, '宁安市');
INSERT INTO `province_city_district`
VALUES (231085, 2310, '穆棱市');
INSERT INTO `province_city_district`
VALUES (231101, 2311, '市辖区');
INSERT INTO `province_city_district`
VALUES (231102, 2311, '爱辉区');
INSERT INTO `province_city_district`
VALUES (231121, 2311, '嫩江县');
INSERT INTO `province_city_district`
VALUES (231123, 2311, '逊克县');
INSERT INTO `province_city_district`
VALUES (231124, 2311, '孙吴县');
INSERT INTO `province_city_district`
VALUES (231181, 2311, '北安市');
INSERT INTO `province_city_district`
VALUES (231182, 2311, '五大连池市');
INSERT INTO `province_city_district`
VALUES (231201, 2312, '市辖区');
INSERT INTO `province_city_district`
VALUES (231202, 2312, '北林区');
INSERT INTO `province_city_district`
VALUES (231221, 2312, '望奎县');
INSERT INTO `province_city_district`
VALUES (231222, 2312, '兰西县');
INSERT INTO `province_city_district`
VALUES (231223, 2312, '青冈县');
INSERT INTO `province_city_district`
VALUES (231224, 2312, '庆安县');
INSERT INTO `province_city_district`
VALUES (231225, 2312, '明水县');
INSERT INTO `province_city_district`
VALUES (231226, 2312, '绥棱县');
INSERT INTO `province_city_district`
VALUES (231281, 2312, '安达市');
INSERT INTO `province_city_district`
VALUES (231282, 2312, '肇东市');
INSERT INTO `province_city_district`
VALUES (231283, 2312, '海伦市');
INSERT INTO `province_city_district`
VALUES (232721, 2327, '呼玛县');
INSERT INTO `province_city_district`
VALUES (232722, 2327, '塔河县');
INSERT INTO `province_city_district`
VALUES (232723, 2327, '漠河县');
INSERT INTO `province_city_district`
VALUES (310101, 3101, '黄浦区');
INSERT INTO `province_city_district`
VALUES (310103, 3101, '卢湾区');
INSERT INTO `province_city_district`
VALUES (310104, 3101, '徐汇区');
INSERT INTO `province_city_district`
VALUES (310105, 3101, '长宁区');
INSERT INTO `province_city_district`
VALUES (310106, 3101, '静安区');
INSERT INTO `province_city_district`
VALUES (310107, 3101, '普陀区');
INSERT INTO `province_city_district`
VALUES (310108, 3101, '闸北区');
INSERT INTO `province_city_district`
VALUES (310109, 3101, '虹口区');
INSERT INTO `province_city_district`
VALUES (310110, 3101, '杨浦区');
INSERT INTO `province_city_district`
VALUES (310112, 3101, '闵行区');
INSERT INTO `province_city_district`
VALUES (310113, 3101, '宝山区');
INSERT INTO `province_city_district`
VALUES (310114, 3101, '嘉定区');
INSERT INTO `province_city_district`
VALUES (310115, 3101, '浦东新区');
INSERT INTO `province_city_district`
VALUES (310116, 3101, '金山区');
INSERT INTO `province_city_district`
VALUES (310117, 3101, '松江区');
INSERT INTO `province_city_district`
VALUES (310118, 3101, '青浦区');
INSERT INTO `province_city_district`
VALUES (310225, 3102, '南汇县');
INSERT INTO `province_city_district`
VALUES (310226, 3102, '奉贤县');
INSERT INTO `province_city_district`
VALUES (310230, 3102, '崇明县');
INSERT INTO `province_city_district`
VALUES (320101, 3201, '市辖区');
INSERT INTO `province_city_district`
VALUES (320102, 3201, '玄武区');
INSERT INTO `province_city_district`
VALUES (320103, 3201, '白下区');
INSERT INTO `province_city_district`
VALUES (320104, 3201, '秦淮区');
INSERT INTO `province_city_district`
VALUES (320105, 3201, '建邺区');
INSERT INTO `province_city_district`
VALUES (320106, 3201, '鼓楼区');
INSERT INTO `province_city_district`
VALUES (320107, 3201, '下关区');
INSERT INTO `province_city_district`
VALUES (320111, 3201, '浦口区');
INSERT INTO `province_city_district`
VALUES (320112, 3201, '大厂区');
INSERT INTO `province_city_district`
VALUES (320113, 3201, '栖霞区');
INSERT INTO `province_city_district`
VALUES (320114, 3201, '雨花台区');
INSERT INTO `province_city_district`
VALUES (320115, 3201, '江宁区');
INSERT INTO `province_city_district`
VALUES (320122, 3201, '江浦县');
INSERT INTO `province_city_district`
VALUES (320123, 3201, '六合县');
INSERT INTO `province_city_district`
VALUES (320124, 3201, '溧水县');
INSERT INTO `province_city_district`
VALUES (320125, 3201, '高淳县');
INSERT INTO `province_city_district`
VALUES (320201, 3202, '市辖区');
INSERT INTO `province_city_district`
VALUES (320202, 3202, '崇安区');
INSERT INTO `province_city_district`
VALUES (320203, 3202, '南长区');
INSERT INTO `province_city_district`
VALUES (320204, 3202, '北塘区');
INSERT INTO `province_city_district`
VALUES (320205, 3202, '锡山区');
INSERT INTO `province_city_district`
VALUES (320206, 3202, '惠山区');
INSERT INTO `province_city_district`
VALUES (320211, 3202, '滨湖区');
INSERT INTO `province_city_district`
VALUES (320281, 3202, '江阴市');
INSERT INTO `province_city_district`
VALUES (320282, 3202, '宜兴市');
INSERT INTO `province_city_district`
VALUES (320301, 3203, '市辖区');
INSERT INTO `province_city_district`
VALUES (320302, 3203, '鼓楼区');
INSERT INTO `province_city_district`
VALUES (320303, 3203, '云龙区');
INSERT INTO `province_city_district`
VALUES (320304, 3203, '九里区');
INSERT INTO `province_city_district`
VALUES (320305, 3203, '贾汪区');
INSERT INTO `province_city_district`
VALUES (320311, 3203, '泉山区');
INSERT INTO `province_city_district`
VALUES (320321, 3203, '丰  县');
INSERT INTO `province_city_district`
VALUES (320322, 3203, '沛  县');
INSERT INTO `province_city_district`
VALUES (320323, 3203, '铜山县');
INSERT INTO `province_city_district`
VALUES (320324, 3203, '睢宁县');
INSERT INTO `province_city_district`
VALUES (320381, 3203, '新沂市');
INSERT INTO `province_city_district`
VALUES (320382, 3203, '邳州市');
INSERT INTO `province_city_district`
VALUES (320401, 3204, '市辖区');
INSERT INTO `province_city_district`
VALUES (320402, 3204, '天宁区');
INSERT INTO `province_city_district`
VALUES (320404, 3204, '钟楼区');
INSERT INTO `province_city_district`
VALUES (320405, 3204, '戚墅堰区');
INSERT INTO `province_city_district`
VALUES (320411, 3204, '郊  区');
INSERT INTO `province_city_district`
VALUES (320481, 3204, '溧阳市');
INSERT INTO `province_city_district`
VALUES (320482, 3204, '金坛市');
INSERT INTO `province_city_district`
VALUES (320483, 3204, '武进市');
INSERT INTO `province_city_district`
VALUES (320501, 3205, '市辖区');
INSERT INTO `province_city_district`
VALUES (320502, 3205, '沧浪区');
INSERT INTO `province_city_district`
VALUES (320503, 3205, '平江区');
INSERT INTO `province_city_district`
VALUES (320504, 3205, '金阊区');
INSERT INTO `province_city_district`
VALUES (320505, 3205, '虎丘区');
INSERT INTO `province_city_district`
VALUES (320506, 3205, '吴中区');
INSERT INTO `province_city_district`
VALUES (320507, 3205, '相城区');
INSERT INTO `province_city_district`
VALUES (320581, 3205, '常熟市');
INSERT INTO `province_city_district`
VALUES (320582, 3205, '张家港市');
INSERT INTO `province_city_district`
VALUES (320583, 3205, '昆山市');
INSERT INTO `province_city_district`
VALUES (320584, 3205, '吴江市');
INSERT INTO `province_city_district`
VALUES (320585, 3205, '太仓市');
INSERT INTO `province_city_district`
VALUES (320601, 3206, '市辖区');
INSERT INTO `province_city_district`
VALUES (320602, 3206, '崇川区');
INSERT INTO `province_city_district`
VALUES (320611, 3206, '港闸区');
INSERT INTO `province_city_district`
VALUES (320621, 3206, '海安县');
INSERT INTO `province_city_district`
VALUES (320623, 3206, '如东县');
INSERT INTO `province_city_district`
VALUES (320681, 3206, '启东市');
INSERT INTO `province_city_district`
VALUES (320682, 3206, '如皋市');
INSERT INTO `province_city_district`
VALUES (320683, 3206, '通州市');
INSERT INTO `province_city_district`
VALUES (320684, 3206, '海门市');
INSERT INTO `province_city_district`
VALUES (320701, 3207, '市辖区');
INSERT INTO `province_city_district`
VALUES (320703, 3207, '连云区');
INSERT INTO `province_city_district`
VALUES (320704, 3207, '云台区');
INSERT INTO `province_city_district`
VALUES (320705, 3207, '新浦区');
INSERT INTO `province_city_district`
VALUES (320706, 3207, '海州区');
INSERT INTO `province_city_district`
VALUES (320721, 3207, '赣榆县');
INSERT INTO `province_city_district`
VALUES (320722, 3207, '东海县');
INSERT INTO `province_city_district`
VALUES (320723, 3207, '灌云县');
INSERT INTO `province_city_district`
VALUES (320724, 3207, '灌南县');
INSERT INTO `province_city_district`
VALUES (320801, 3208, '市辖区');
INSERT INTO `province_city_district`
VALUES (320802, 3208, '清河区');
INSERT INTO `province_city_district`
VALUES (320803, 3208, '楚州区');
INSERT INTO `province_city_district`
VALUES (320804, 3208, '淮阴区');
INSERT INTO `province_city_district`
VALUES (320811, 3208, '清浦区');
INSERT INTO `province_city_district`
VALUES (320826, 3208, '涟水县');
INSERT INTO `province_city_district`
VALUES (320829, 3208, '洪泽县');
INSERT INTO `province_city_district`
VALUES (320830, 3208, '盱眙县');
INSERT INTO `province_city_district`
VALUES (320831, 3208, '金湖县');
INSERT INTO `province_city_district`
VALUES (320901, 3209, '市辖区');
INSERT INTO `province_city_district`
VALUES (320902, 3209, '城  区');
INSERT INTO `province_city_district`
VALUES (320921, 3209, '响水县');
INSERT INTO `province_city_district`
VALUES (320922, 3209, '滨海县');
INSERT INTO `province_city_district`
VALUES (320923, 3209, '阜宁县');
INSERT INTO `province_city_district`
VALUES (320924, 3209, '射阳县');
INSERT INTO `province_city_district`
VALUES (320925, 3209, '建湖县');
INSERT INTO `province_city_district`
VALUES (320928, 3209, '盐都县');
INSERT INTO `province_city_district`
VALUES (320981, 3209, '东台市');
INSERT INTO `province_city_district`
VALUES (320982, 3209, '大丰市');
INSERT INTO `province_city_district`
VALUES (321001, 3210, '市辖区');
INSERT INTO `province_city_district`
VALUES (321002, 3210, '广陵区');
INSERT INTO `province_city_district`
VALUES (321003, 3210, '邗江区');
INSERT INTO `province_city_district`
VALUES (321011, 3210, '郊  区');
INSERT INTO `province_city_district`
VALUES (321023, 3210, '宝应县');
INSERT INTO `province_city_district`
VALUES (321081, 3210, '仪征市');
INSERT INTO `province_city_district`
VALUES (321084, 3210, '高邮市');
INSERT INTO `province_city_district`
VALUES (321088, 3210, '江都市');
INSERT INTO `province_city_district`
VALUES (321101, 3211, '市辖区');
INSERT INTO `province_city_district`
VALUES (321102, 3211, '京口区');
INSERT INTO `province_city_district`
VALUES (321111, 3211, '润州区');
INSERT INTO `province_city_district`
VALUES (321121, 3211, '丹徒县');
INSERT INTO `province_city_district`
VALUES (321181, 3211, '丹阳市');
INSERT INTO `province_city_district`
VALUES (321182, 3211, '扬中市');
INSERT INTO `province_city_district`
VALUES (321183, 3211, '句容市');
INSERT INTO `province_city_district`
VALUES (321201, 3212, '市辖区');
INSERT INTO `province_city_district`
VALUES (321202, 3212, '海陵区');
INSERT INTO `province_city_district`
VALUES (321203, 3212, '高港区');
INSERT INTO `province_city_district`
VALUES (321281, 3212, '兴化市');
INSERT INTO `province_city_district`
VALUES (321282, 3212, '靖江市');
INSERT INTO `province_city_district`
VALUES (321283, 3212, '泰兴市');
INSERT INTO `province_city_district`
VALUES (321284, 3212, '姜堰市');
INSERT INTO `province_city_district`
VALUES (321301, 3213, '市辖区');
INSERT INTO `province_city_district`
VALUES (321302, 3213, '宿城区');
INSERT INTO `province_city_district`
VALUES (321321, 3213, '宿豫县');
INSERT INTO `province_city_district`
VALUES (321322, 3213, '沭阳县');
INSERT INTO `province_city_district`
VALUES (321323, 3213, '泗阳县');
INSERT INTO `province_city_district`
VALUES (321324, 3213, '泗洪县');
INSERT INTO `province_city_district`
VALUES (330101, 3301, '市辖区');
INSERT INTO `province_city_district`
VALUES (330102, 3301, '上城区');
INSERT INTO `province_city_district`
VALUES (330103, 3301, '下城区');
INSERT INTO `province_city_district`
VALUES (330104, 3301, '江干区');
INSERT INTO `province_city_district`
VALUES (330105, 3301, '拱墅区');
INSERT INTO `province_city_district`
VALUES (330106, 3301, '西湖区');
INSERT INTO `province_city_district`
VALUES (330108, 3301, '滨江区');
INSERT INTO `province_city_district`
VALUES (330122, 3301, '桐庐县');
INSERT INTO `province_city_district`
VALUES (330127, 3301, '淳安县');
INSERT INTO `province_city_district`
VALUES (330181, 3301, '萧山市');
INSERT INTO `province_city_district`
VALUES (330182, 3301, '建德市');
INSERT INTO `province_city_district`
VALUES (330183, 3301, '富阳市');
INSERT INTO `province_city_district`
VALUES (330184, 3301, '余杭市');
INSERT INTO `province_city_district`
VALUES (330185, 3301, '临安市');
INSERT INTO `province_city_district`
VALUES (330201, 3302, '市辖区');
INSERT INTO `province_city_district`
VALUES (330203, 3302, '海曙区');
INSERT INTO `province_city_district`
VALUES (330204, 3302, '江东区');
INSERT INTO `province_city_district`
VALUES (330205, 3302, '江北区');
INSERT INTO `province_city_district`
VALUES (330206, 3302, '北仑区');
INSERT INTO `province_city_district`
VALUES (330211, 3302, '镇海区');
INSERT INTO `province_city_district`
VALUES (330225, 3302, '象山县');
INSERT INTO `province_city_district`
VALUES (330226, 3302, '宁海县');
INSERT INTO `province_city_district`
VALUES (330227, 3302, '鄞  县');
INSERT INTO `province_city_district`
VALUES (330281, 3302, '余姚市');
INSERT INTO `province_city_district`
VALUES (330282, 3302, '慈溪市');
INSERT INTO `province_city_district`
VALUES (330283, 3302, '奉化市');
INSERT INTO `province_city_district`
VALUES (330301, 3303, '市辖区');
INSERT INTO `province_city_district`
VALUES (330302, 3303, '鹿城区');
INSERT INTO `province_city_district`
VALUES (330303, 3303, '龙湾区');
INSERT INTO `province_city_district`
VALUES (330304, 3303, '瓯海区');
INSERT INTO `province_city_district`
VALUES (330322, 3303, '洞头县');
INSERT INTO `province_city_district`
VALUES (330324, 3303, '永嘉县');
INSERT INTO `province_city_district`
VALUES (330326, 3303, '平阳县');
INSERT INTO `province_city_district`
VALUES (330327, 3303, '苍南县');
INSERT INTO `province_city_district`
VALUES (330328, 3303, '文成县');
INSERT INTO `province_city_district`
VALUES (330329, 3303, '泰顺县');
INSERT INTO `province_city_district`
VALUES (330381, 3303, '瑞安市');
INSERT INTO `province_city_district`
VALUES (330382, 3303, '乐清市');
INSERT INTO `province_city_district`
VALUES (330401, 3304, '市辖区');
INSERT INTO `province_city_district`
VALUES (330402, 3304, '秀城区');
INSERT INTO `province_city_district`
VALUES (330411, 3304, '秀洲区');
INSERT INTO `province_city_district`
VALUES (330421, 3304, '嘉善县');
INSERT INTO `province_city_district`
VALUES (330424, 3304, '海盐县');
INSERT INTO `province_city_district`
VALUES (330481, 3304, '海宁市');
INSERT INTO `province_city_district`
VALUES (330482, 3304, '平湖市');
INSERT INTO `province_city_district`
VALUES (330483, 3304, '桐乡市');
INSERT INTO `province_city_district`
VALUES (330501, 3305, '市辖区');
INSERT INTO `province_city_district`
VALUES (330521, 3305, '德清县');
INSERT INTO `province_city_district`
VALUES (330522, 3305, '长兴县');
INSERT INTO `province_city_district`
VALUES (330523, 3305, '安吉县');
INSERT INTO `province_city_district`
VALUES (330601, 3306, '市辖区');
INSERT INTO `province_city_district`
VALUES (330602, 3306, '越城区');
INSERT INTO `province_city_district`
VALUES (330621, 3306, '绍兴县');
INSERT INTO `province_city_district`
VALUES (330624, 3306, '新昌县');
INSERT INTO `province_city_district`
VALUES (330681, 3306, '诸暨市');
INSERT INTO `province_city_district`
VALUES (330682, 3306, '上虞市');
INSERT INTO `province_city_district`
VALUES (330683, 3306, '嵊州市');
INSERT INTO `province_city_district`
VALUES (330701, 3307, '市辖区');
INSERT INTO `province_city_district`
VALUES (330702, 3307, '婺城区');
INSERT INTO `province_city_district`
VALUES (330703, 3307, '金东区');
INSERT INTO `province_city_district`
VALUES (330723, 3307, '武义县');
INSERT INTO `province_city_district`
VALUES (330726, 3307, '浦江县');
INSERT INTO `province_city_district`
VALUES (330727, 3307, '磐安县');
INSERT INTO `province_city_district`
VALUES (330781, 3307, '兰溪市');
INSERT INTO `province_city_district`
VALUES (330782, 3307, '义乌市');
INSERT INTO `province_city_district`
VALUES (330783, 3307, '东阳市');
INSERT INTO `province_city_district`
VALUES (330784, 3307, '永康市');
INSERT INTO `province_city_district`
VALUES (330801, 3308, '市辖区');
INSERT INTO `province_city_district`
VALUES (330802, 3308, '柯城区');
INSERT INTO `province_city_district`
VALUES (330821, 3308, '衢  县');
INSERT INTO `province_city_district`
VALUES (330822, 3308, '常山县');
INSERT INTO `province_city_district`
VALUES (330824, 3308, '开化县');
INSERT INTO `province_city_district`
VALUES (330825, 3308, '龙游县');
INSERT INTO `province_city_district`
VALUES (330881, 3308, '江山市');
INSERT INTO `province_city_district`
VALUES (330901, 3309, '市辖区');
INSERT INTO `province_city_district`
VALUES (330902, 3309, '定海区');
INSERT INTO `province_city_district`
VALUES (330903, 3309, '普陀区');
INSERT INTO `province_city_district`
VALUES (330921, 3309, '岱山县');
INSERT INTO `province_city_district`
VALUES (330922, 3309, '嵊泗县');
INSERT INTO `province_city_district`
VALUES (331001, 3310, '市辖区');
INSERT INTO `province_city_district`
VALUES (331002, 3310, '椒江区');
INSERT INTO `province_city_district`
VALUES (331003, 3310, '黄岩区');
INSERT INTO `province_city_district`
VALUES (331004, 3310, '路桥区');
INSERT INTO `province_city_district`
VALUES (331021, 3310, '玉环县');
INSERT INTO `province_city_district`
VALUES (331022, 3310, '三门县');
INSERT INTO `province_city_district`
VALUES (331023, 3310, '天台县');
INSERT INTO `province_city_district`
VALUES (331024, 3310, '仙居县');
INSERT INTO `province_city_district`
VALUES (331081, 3310, '温岭市');
INSERT INTO `province_city_district`
VALUES (331082, 3310, '临海市');
INSERT INTO `province_city_district`
VALUES (331101, 3311, '市辖区');
INSERT INTO `province_city_district`
VALUES (331102, 3311, '莲都区');
INSERT INTO `province_city_district`
VALUES (331121, 3311, '青田县');
INSERT INTO `province_city_district`
VALUES (331122, 3311, '缙云县');
INSERT INTO `province_city_district`
VALUES (331123, 3311, '遂昌县');
INSERT INTO `province_city_district`
VALUES (331124, 3311, '松阳县');
INSERT INTO `province_city_district`
VALUES (331125, 3311, '云和县');
INSERT INTO `province_city_district`
VALUES (331126, 3311, '庆元县');
INSERT INTO `province_city_district`
VALUES (331127, 3311, '景宁畲族自治县');
INSERT INTO `province_city_district`
VALUES (331181, 3311, '龙泉市');
INSERT INTO `province_city_district`
VALUES (340101, 3401, '市辖区');
INSERT INTO `province_city_district`
VALUES (340102, 3401, '东市区');
INSERT INTO `province_city_district`
VALUES (340103, 3401, '中市区');
INSERT INTO `province_city_district`
VALUES (340104, 3401, '西市区');
INSERT INTO `province_city_district`
VALUES (340111, 3401, '郊  区');
INSERT INTO `province_city_district`
VALUES (340121, 3401, '长丰县');
INSERT INTO `province_city_district`
VALUES (340122, 3401, '肥东县');
INSERT INTO `province_city_district`
VALUES (340123, 3401, '肥西县');
INSERT INTO `province_city_district`
VALUES (340201, 3402, '市辖区');
INSERT INTO `province_city_district`
VALUES (340202, 3402, '镜湖区');
INSERT INTO `province_city_district`
VALUES (340203, 3402, '马塘区');
INSERT INTO `province_city_district`
VALUES (340204, 3402, '新芜区');
INSERT INTO `province_city_district`
VALUES (340207, 3402, '鸠江区');
INSERT INTO `province_city_district`
VALUES (340221, 3402, '芜湖县');
INSERT INTO `province_city_district`
VALUES (340222, 3402, '繁昌县');
INSERT INTO `province_city_district`
VALUES (340223, 3402, '南陵县');
INSERT INTO `province_city_district`
VALUES (340301, 3403, '市辖区');
INSERT INTO `province_city_district`
VALUES (340302, 3403, '东市区');
INSERT INTO `province_city_district`
VALUES (340303, 3403, '中市区');
INSERT INTO `province_city_district`
VALUES (340304, 3403, '西市区');
INSERT INTO `province_city_district`
VALUES (340311, 3403, '郊  区');
INSERT INTO `province_city_district`
VALUES (340321, 3403, '怀远县');
INSERT INTO `province_city_district`
VALUES (340322, 3403, '五河县');
INSERT INTO `province_city_district`
VALUES (340323, 3403, '固镇县');
INSERT INTO `province_city_district`
VALUES (340401, 3404, '市辖区');
INSERT INTO `province_city_district`
VALUES (340402, 3404, '大通区');
INSERT INTO `province_city_district`
VALUES (340403, 3404, '田家庵区');
INSERT INTO `province_city_district`
VALUES (340404, 3404, '谢家集区');
INSERT INTO `province_city_district`
VALUES (340405, 3404, '八公山区');
INSERT INTO `province_city_district`
VALUES (340406, 3404, '潘集区');
INSERT INTO `province_city_district`
VALUES (340421, 3404, '凤台县');
INSERT INTO `province_city_district`
VALUES (340501, 3405, '市辖区');
INSERT INTO `province_city_district`
VALUES (340502, 3405, '金家庄区');
INSERT INTO `province_city_district`
VALUES (340503, 3405, '花山区');
INSERT INTO `province_city_district`
VALUES (340504, 3405, '雨山区');
INSERT INTO `province_city_district`
VALUES (340505, 3405, '向山区');
INSERT INTO `province_city_district`
VALUES (340521, 3405, '当涂县');
INSERT INTO `province_city_district`
VALUES (340601, 3406, '市辖区');
INSERT INTO `province_city_district`
VALUES (340602, 3406, '杜集区');
INSERT INTO `province_city_district`
VALUES (340603, 3406, '相山区');
INSERT INTO `province_city_district`
VALUES (340604, 3406, '烈山区');
INSERT INTO `province_city_district`
VALUES (340621, 3406, '濉溪县');
INSERT INTO `province_city_district`
VALUES (340701, 3407, '市辖区');
INSERT INTO `province_city_district`
VALUES (340702, 3407, '铜官山区');
INSERT INTO `province_city_district`
VALUES (340703, 3407, '狮子山区');
INSERT INTO `province_city_district`
VALUES (340711, 3407, '郊  区');
INSERT INTO `province_city_district`
VALUES (340721, 3407, '铜陵县');
INSERT INTO `province_city_district`
VALUES (340801, 3408, '市辖区');
INSERT INTO `province_city_district`
VALUES (340802, 3408, '迎江区');
INSERT INTO `province_city_district`
VALUES (340803, 3408, '大观区');
INSERT INTO `province_city_district`
VALUES (340811, 3408, '郊  区');
INSERT INTO `province_city_district`
VALUES (340822, 3408, '怀宁县');
INSERT INTO `province_city_district`
VALUES (340823, 3408, '枞阳县');
INSERT INTO `province_city_district`
VALUES (340824, 3408, '潜山县');
INSERT INTO `province_city_district`
VALUES (340825, 3408, '太湖县');
INSERT INTO `province_city_district`
VALUES (340826, 3408, '宿松县');
INSERT INTO `province_city_district`
VALUES (340827, 3408, '望江县');
INSERT INTO `province_city_district`
VALUES (340828, 3408, '岳西县');
INSERT INTO `province_city_district`
VALUES (340881, 3408, '桐城市');
INSERT INTO `province_city_district`
VALUES (341001, 3410, '市辖区');
INSERT INTO `province_city_district`
VALUES (341002, 3410, '屯溪区');
INSERT INTO `province_city_district`
VALUES (341003, 3410, '黄山区');
INSERT INTO `province_city_district`
VALUES (341004, 3410, '徽州区');
INSERT INTO `province_city_district`
VALUES (341021, 3410, '歙  县');
INSERT INTO `province_city_district`
VALUES (341022, 3410, '休宁县');
INSERT INTO `province_city_district`
VALUES (341023, 3410, '黟  县');
INSERT INTO `province_city_district`
VALUES (341024, 3410, '祁门县');
INSERT INTO `province_city_district`
VALUES (341101, 3411, '市辖区');
INSERT INTO `province_city_district`
VALUES (341102, 3411, '琅琊区');
INSERT INTO `province_city_district`
VALUES (341103, 3411, '南谯区');
INSERT INTO `province_city_district`
VALUES (341122, 3411, '来安县');
INSERT INTO `province_city_district`
VALUES (341124, 3411, '全椒县');
INSERT INTO `province_city_district`
VALUES (341125, 3411, '定远县');
INSERT INTO `province_city_district`
VALUES (341126, 3411, '凤阳县');
INSERT INTO `province_city_district`
VALUES (341181, 3411, '天长市');
INSERT INTO `province_city_district`
VALUES (341182, 3411, '明光市');
INSERT INTO `province_city_district`
VALUES (341201, 3412, '市辖区');
INSERT INTO `province_city_district`
VALUES (341202, 3412, '颍州区');
INSERT INTO `province_city_district`
VALUES (341203, 3412, '颍东区');
INSERT INTO `province_city_district`
VALUES (341204, 3412, '颍泉区');
INSERT INTO `province_city_district`
VALUES (341221, 3412, '临泉县');
INSERT INTO `province_city_district`
VALUES (341222, 3412, '太和县');
INSERT INTO `province_city_district`
VALUES (341225, 3412, '阜南县');
INSERT INTO `province_city_district`
VALUES (341226, 3412, '颍上县');
INSERT INTO `province_city_district`
VALUES (341282, 3412, '界首市');
INSERT INTO `province_city_district`
VALUES (341301, 3413, '市辖区');
INSERT INTO `province_city_district`
VALUES (341302, 3413, '墉桥区');
INSERT INTO `province_city_district`
VALUES (341321, 3413, '砀山县');
INSERT INTO `province_city_district`
VALUES (341322, 3413, '萧  县');
INSERT INTO `province_city_district`
VALUES (341323, 3413, '灵璧县');
INSERT INTO `province_city_district`
VALUES (341324, 3413, '泗  县');
INSERT INTO `province_city_district`
VALUES (341401, 3414, '市辖区');
INSERT INTO `province_city_district`
VALUES (341402, 3414, '居巢区');
INSERT INTO `province_city_district`
VALUES (341421, 3414, '庐江县');
INSERT INTO `province_city_district`
VALUES (341422, 3414, '无为县');
INSERT INTO `province_city_district`
VALUES (341423, 3414, '含山县');
INSERT INTO `province_city_district`
VALUES (341424, 3414, '和  县');
INSERT INTO `province_city_district`
VALUES (341501, 3415, '市辖区');
INSERT INTO `province_city_district`
VALUES (341502, 3415, '金安区');
INSERT INTO `province_city_district`
VALUES (341503, 3415, '裕安区');
INSERT INTO `province_city_district`
VALUES (341521, 3415, '寿  县');
INSERT INTO `province_city_district`
VALUES (341522, 3415, '霍邱县');
INSERT INTO `province_city_district`
VALUES (341523, 3415, '舒城县');
INSERT INTO `province_city_district`
VALUES (341524, 3415, '金寨县');
INSERT INTO `province_city_district`
VALUES (341525, 3415, '霍山县');
INSERT INTO `province_city_district`
VALUES (341601, 3416, '市辖区');
INSERT INTO `province_city_district`
VALUES (341602, 3416, '谯城区');
INSERT INTO `province_city_district`
VALUES (341621, 3416, '涡阳县');
INSERT INTO `province_city_district`
VALUES (341622, 3416, '蒙城县');
INSERT INTO `province_city_district`
VALUES (341623, 3416, '利辛县');
INSERT INTO `province_city_district`
VALUES (341701, 3417, '市辖区');
INSERT INTO `province_city_district`
VALUES (341702, 3417, '贵池区');
INSERT INTO `province_city_district`
VALUES (341721, 3417, '东至县');
INSERT INTO `province_city_district`
VALUES (341722, 3417, '石台县');
INSERT INTO `province_city_district`
VALUES (341723, 3417, '青阳县');
INSERT INTO `province_city_district`
VALUES (341801, 3418, '市辖区');
INSERT INTO `province_city_district`
VALUES (341802, 3418, '宣州区');
INSERT INTO `province_city_district`
VALUES (341821, 3418, '郎溪县');
INSERT INTO `province_city_district`
VALUES (341822, 3418, '广德县');
INSERT INTO `province_city_district`
VALUES (341823, 3418, '泾  县');
INSERT INTO `province_city_district`
VALUES (341824, 3418, '绩溪县');
INSERT INTO `province_city_district`
VALUES (341825, 3418, '旌德县');
INSERT INTO `province_city_district`
VALUES (341881, 3418, '宁国市');
INSERT INTO `province_city_district`
VALUES (350101, 3501, '市辖区');
INSERT INTO `province_city_district`
VALUES (350102, 3501, '鼓楼区');
INSERT INTO `province_city_district`
VALUES (350103, 3501, '台江区');
INSERT INTO `province_city_district`
VALUES (350104, 3501, '仓山区');
INSERT INTO `province_city_district`
VALUES (350105, 3501, '马尾区');
INSERT INTO `province_city_district`
VALUES (350111, 3501, '晋安区');
INSERT INTO `province_city_district`
VALUES (350121, 3501, '闽侯县');
INSERT INTO `province_city_district`
VALUES (350122, 3501, '连江县');
INSERT INTO `province_city_district`
VALUES (350123, 3501, '罗源县');
INSERT INTO `province_city_district`
VALUES (350124, 3501, '闽清县');
INSERT INTO `province_city_district`
VALUES (350125, 3501, '永泰县');
INSERT INTO `province_city_district`
VALUES (350128, 3501, '平潭县');
INSERT INTO `province_city_district`
VALUES (350181, 3501, '福清市');
INSERT INTO `province_city_district`
VALUES (350182, 3501, '长乐市');
INSERT INTO `province_city_district`
VALUES (350201, 3502, '市辖区');
INSERT INTO `province_city_district`
VALUES (350202, 3502, '鼓浪屿区');
INSERT INTO `province_city_district`
VALUES (350203, 3502, '思明区');
INSERT INTO `province_city_district`
VALUES (350204, 3502, '开元区');
INSERT INTO `province_city_district`
VALUES (350205, 3502, '杏林区');
INSERT INTO `province_city_district`
VALUES (350206, 3502, '湖里区');
INSERT INTO `province_city_district`
VALUES (350211, 3502, '集美区');
INSERT INTO `province_city_district`
VALUES (350212, 3502, '同安区');
INSERT INTO `province_city_district`
VALUES (350301, 3503, '市辖区');
INSERT INTO `province_city_district`
VALUES (350302, 3503, '城厢区');
INSERT INTO `province_city_district`
VALUES (350303, 3503, '涵江区');
INSERT INTO `province_city_district`
VALUES (350321, 3503, '莆田县');
INSERT INTO `province_city_district`
VALUES (350322, 3503, '仙游县');
INSERT INTO `province_city_district`
VALUES (350401, 3504, '市辖区');
INSERT INTO `province_city_district`
VALUES (350402, 3504, '梅列区');
INSERT INTO `province_city_district`
VALUES (350403, 3504, '三元区');
INSERT INTO `province_city_district`
VALUES (350421, 3504, '明溪县');
INSERT INTO `province_city_district`
VALUES (350423, 3504, '清流县');
INSERT INTO `province_city_district`
VALUES (350424, 3504, '宁化县');
INSERT INTO `province_city_district`
VALUES (350425, 3504, '大田县');
INSERT INTO `province_city_district`
VALUES (350426, 3504, '尤溪县');
INSERT INTO `province_city_district`
VALUES (350427, 3504, '沙  县');
INSERT INTO `province_city_district`
VALUES (350428, 3504, '将乐县');
INSERT INTO `province_city_district`
VALUES (350429, 3504, '泰宁县');
INSERT INTO `province_city_district`
VALUES (350430, 3504, '建宁县');
INSERT INTO `province_city_district`
VALUES (350481, 3504, '永安市');
INSERT INTO `province_city_district`
VALUES (350501, 3505, '市辖区');
INSERT INTO `province_city_district`
VALUES (350502, 3505, '鲤城区');
INSERT INTO `province_city_district`
VALUES (350503, 3505, '丰泽区');
INSERT INTO `province_city_district`
VALUES (350504, 3505, '洛江区');
INSERT INTO `province_city_district`
VALUES (350505, 3505, '泉港区');
INSERT INTO `province_city_district`
VALUES (350521, 3505, '惠安县');
INSERT INTO `province_city_district`
VALUES (350524, 3505, '安溪县');
INSERT INTO `province_city_district`
VALUES (350525, 3505, '永春县');
INSERT INTO `province_city_district`
VALUES (350526, 3505, '德化县');
INSERT INTO `province_city_district`
VALUES (350527, 3505, '金门县');
INSERT INTO `province_city_district`
VALUES (350581, 3505, '石狮市');
INSERT INTO `province_city_district`
VALUES (350582, 3505, '晋江市');
INSERT INTO `province_city_district`
VALUES (350583, 3505, '南安市');
INSERT INTO `province_city_district`
VALUES (350601, 3506, '市辖区');
INSERT INTO `province_city_district`
VALUES (350602, 3506, '芗城区');
INSERT INTO `province_city_district`
VALUES (350603, 3506, '龙文区');
INSERT INTO `province_city_district`
VALUES (350622, 3506, '云霄县');
INSERT INTO `province_city_district`
VALUES (350623, 3506, '漳浦县');
INSERT INTO `province_city_district`
VALUES (350624, 3506, '诏安县');
INSERT INTO `province_city_district`
VALUES (350625, 3506, '长泰县');
INSERT INTO `province_city_district`
VALUES (350626, 3506, '东山县');
INSERT INTO `province_city_district`
VALUES (350627, 3506, '南靖县');
INSERT INTO `province_city_district`
VALUES (350628, 3506, '平和县');
INSERT INTO `province_city_district`
VALUES (350629, 3506, '华安县');
INSERT INTO `province_city_district`
VALUES (350681, 3506, '龙海市');
INSERT INTO `province_city_district`
VALUES (350701, 3507, '市辖区');
INSERT INTO `province_city_district`
VALUES (350702, 3507, '延平区');
INSERT INTO `province_city_district`
VALUES (350721, 3507, '顺昌县');
INSERT INTO `province_city_district`
VALUES (350722, 3507, '浦城县');
INSERT INTO `province_city_district`
VALUES (350723, 3507, '光泽县');
INSERT INTO `province_city_district`
VALUES (350724, 3507, '松溪县');
INSERT INTO `province_city_district`
VALUES (350725, 3507, '政和县');
INSERT INTO `province_city_district`
VALUES (350781, 3507, '邵武市');
INSERT INTO `province_city_district`
VALUES (350782, 3507, '武夷山市');
INSERT INTO `province_city_district`
VALUES (350783, 3507, '建瓯市');
INSERT INTO `province_city_district`
VALUES (350784, 3507, '建阳市');
INSERT INTO `province_city_district`
VALUES (350801, 3508, '市辖区');
INSERT INTO `province_city_district`
VALUES (350802, 3508, '新罗区');
INSERT INTO `province_city_district`
VALUES (350821, 3508, '长汀县');
INSERT INTO `province_city_district`
VALUES (350822, 3508, '永定县');
INSERT INTO `province_city_district`
VALUES (350823, 3508, '上杭县');
INSERT INTO `province_city_district`
VALUES (350824, 3508, '武平县');
INSERT INTO `province_city_district`
VALUES (350825, 3508, '连城县');
INSERT INTO `province_city_district`
VALUES (350881, 3508, '漳平市');
INSERT INTO `province_city_district`
VALUES (350901, 3509, '市辖区');
INSERT INTO `province_city_district`
VALUES (350902, 3509, '蕉城区');
INSERT INTO `province_city_district`
VALUES (350921, 3509, '霞浦县');
INSERT INTO `province_city_district`
VALUES (350922, 3509, '古田县');
INSERT INTO `province_city_district`
VALUES (350923, 3509, '屏南县');
INSERT INTO `province_city_district`
VALUES (350924, 3509, '寿宁县');
INSERT INTO `province_city_district`
VALUES (350925, 3509, '周宁县');
INSERT INTO `province_city_district`
VALUES (350926, 3509, '柘荣县');
INSERT INTO `province_city_district`
VALUES (350981, 3509, '福安市');
INSERT INTO `province_city_district`
VALUES (350982, 3509, '福鼎市');
INSERT INTO `province_city_district`
VALUES (360101, 3601, '市辖区');
INSERT INTO `province_city_district`
VALUES (360102, 3601, '东湖区');
INSERT INTO `province_city_district`
VALUES (360103, 3601, '西湖区');
INSERT INTO `province_city_district`
VALUES (360104, 3601, '青云谱区');
INSERT INTO `province_city_district`
VALUES (360105, 3601, '湾里区');
INSERT INTO `province_city_district`
VALUES (360111, 3601, '郊  区');
INSERT INTO `province_city_district`
VALUES (360121, 3601, '南昌县');
INSERT INTO `province_city_district`
VALUES (360122, 3601, '新建县');
INSERT INTO `province_city_district`
VALUES (360123, 3601, '安义县');
INSERT INTO `province_city_district`
VALUES (360124, 3601, '进贤县');
INSERT INTO `province_city_district`
VALUES (360201, 3602, '市辖区');
INSERT INTO `province_city_district`
VALUES (360202, 3602, '昌江区');
INSERT INTO `province_city_district`
VALUES (360203, 3602, '珠山区');
INSERT INTO `province_city_district`
VALUES (360222, 3602, '浮梁县');
INSERT INTO `province_city_district`
VALUES (360281, 3602, '乐平市');
INSERT INTO `province_city_district`
VALUES (360301, 3603, '市辖区');
INSERT INTO `province_city_district`
VALUES (360302, 3603, '安源区');
INSERT INTO `province_city_district`
VALUES (360313, 3603, '湘东区');
INSERT INTO `province_city_district`
VALUES (360321, 3603, '莲花县');
INSERT INTO `province_city_district`
VALUES (360322, 3603, '上栗县');
INSERT INTO `province_city_district`
VALUES (360323, 3603, '芦溪县');
INSERT INTO `province_city_district`
VALUES (360401, 3604, '市辖区');
INSERT INTO `province_city_district`
VALUES (360402, 3604, '庐山区');
INSERT INTO `province_city_district`
VALUES (360403, 3604, '浔阳区');
INSERT INTO `province_city_district`
VALUES (360421, 3604, '九江县');
INSERT INTO `province_city_district`
VALUES (360423, 3604, '武宁县');
INSERT INTO `province_city_district`
VALUES (360424, 3604, '修水县');
INSERT INTO `province_city_district`
VALUES (360425, 3604, '永修县');
INSERT INTO `province_city_district`
VALUES (360426, 3604, '德安县');
INSERT INTO `province_city_district`
VALUES (360427, 3604, '星子县');
INSERT INTO `province_city_district`
VALUES (360428, 3604, '都昌县');
INSERT INTO `province_city_district`
VALUES (360429, 3604, '湖口县');
INSERT INTO `province_city_district`
VALUES (360430, 3604, '彭泽县');
INSERT INTO `province_city_district`
VALUES (360481, 3604, '瑞昌市');
INSERT INTO `province_city_district`
VALUES (360501, 3605, '市辖区');
INSERT INTO `province_city_district`
VALUES (360502, 3605, '渝水区');
INSERT INTO `province_city_district`
VALUES (360521, 3605, '分宜县');
INSERT INTO `province_city_district`
VALUES (360601, 3606, '市辖区');
INSERT INTO `province_city_district`
VALUES (360602, 3606, '月湖区');
INSERT INTO `province_city_district`
VALUES (360622, 3606, '余江县');
INSERT INTO `province_city_district`
VALUES (360681, 3606, '贵溪市');
INSERT INTO `province_city_district`
VALUES (360701, 3607, '市辖区');
INSERT INTO `province_city_district`
VALUES (360702, 3607, '章贡区');
INSERT INTO `province_city_district`
VALUES (360721, 3607, '赣  县');
INSERT INTO `province_city_district`
VALUES (360722, 3607, '信丰县');
INSERT INTO `province_city_district`
VALUES (360723, 3607, '大余县');
INSERT INTO `province_city_district`
VALUES (360724, 3607, '上犹县');
INSERT INTO `province_city_district`
VALUES (360725, 3607, '崇义县');
INSERT INTO `province_city_district`
VALUES (360726, 3607, '安远县');
INSERT INTO `province_city_district`
VALUES (360727, 3607, '龙南县');
INSERT INTO `province_city_district`
VALUES (360728, 3607, '定南县');
INSERT INTO `province_city_district`
VALUES (360729, 3607, '全南县');
INSERT INTO `province_city_district`
VALUES (360730, 3607, '宁都县');
INSERT INTO `province_city_district`
VALUES (360731, 3607, '于都县');
INSERT INTO `province_city_district`
VALUES (360732, 3607, '兴国县');
INSERT INTO `province_city_district`
VALUES (360733, 3607, '会昌县');
INSERT INTO `province_city_district`
VALUES (360734, 3607, '寻乌县');
INSERT INTO `province_city_district`
VALUES (360735, 3607, '石城县');
INSERT INTO `province_city_district`
VALUES (360781, 3607, '瑞金市');
INSERT INTO `province_city_district`
VALUES (360782, 3607, '南康市');
INSERT INTO `province_city_district`
VALUES (360801, 3608, '市辖区');
INSERT INTO `province_city_district`
VALUES (360802, 3608, '吉州区');
INSERT INTO `province_city_district`
VALUES (360803, 3608, '青原区');
INSERT INTO `province_city_district`
VALUES (360821, 3608, '吉安县');
INSERT INTO `province_city_district`
VALUES (360822, 3608, '吉水县');
INSERT INTO `province_city_district`
VALUES (360823, 3608, '峡江县');
INSERT INTO `province_city_district`
VALUES (360824, 3608, '新干县');
INSERT INTO `province_city_district`
VALUES (360825, 3608, '永丰县');
INSERT INTO `province_city_district`
VALUES (360826, 3608, '泰和县');
INSERT INTO `province_city_district`
VALUES (360827, 3608, '遂川县');
INSERT INTO `province_city_district`
VALUES (360828, 3608, '万安县');
INSERT INTO `province_city_district`
VALUES (360829, 3608, '安福县');
INSERT INTO `province_city_district`
VALUES (360830, 3608, '永新县');
INSERT INTO `province_city_district`
VALUES (360881, 3608, '井冈山市');
INSERT INTO `province_city_district`
VALUES (360901, 3609, '市辖区');
INSERT INTO `province_city_district`
VALUES (360902, 3609, '袁州区');
INSERT INTO `province_city_district`
VALUES (360921, 3609, '奉新县');
INSERT INTO `province_city_district`
VALUES (360922, 3609, '万载县');
INSERT INTO `province_city_district`
VALUES (360923, 3609, '上高县');
INSERT INTO `province_city_district`
VALUES (360924, 3609, '宜丰县');
INSERT INTO `province_city_district`
VALUES (360925, 3609, '靖安县');
INSERT INTO `province_city_district`
VALUES (360926, 3609, '铜鼓县');
INSERT INTO `province_city_district`
VALUES (360981, 3609, '丰城市');
INSERT INTO `province_city_district`
VALUES (360982, 3609, '樟树市');
INSERT INTO `province_city_district`
VALUES (360983, 3609, '高安市');
INSERT INTO `province_city_district`
VALUES (361001, 3610, '市辖区');
INSERT INTO `province_city_district`
VALUES (361002, 3610, '临川区');
INSERT INTO `province_city_district`
VALUES (361021, 3610, '南城县');
INSERT INTO `province_city_district`
VALUES (361022, 3610, '黎川县');
INSERT INTO `province_city_district`
VALUES (361023, 3610, '南丰县');
INSERT INTO `province_city_district`
VALUES (361024, 3610, '崇仁县');
INSERT INTO `province_city_district`
VALUES (361025, 3610, '乐安县');
INSERT INTO `province_city_district`
VALUES (361026, 3610, '宜黄县');
INSERT INTO `province_city_district`
VALUES (361027, 3610, '金溪县');
INSERT INTO `province_city_district`
VALUES (361028, 3610, '资溪县');
INSERT INTO `province_city_district`
VALUES (361029, 3610, '东乡县');
INSERT INTO `province_city_district`
VALUES (361030, 3610, '广昌县');
INSERT INTO `province_city_district`
VALUES (361101, 3611, '市辖区');
INSERT INTO `province_city_district`
VALUES (361102, 3611, '信州区');
INSERT INTO `province_city_district`
VALUES (361121, 3611, '上饶县');
INSERT INTO `province_city_district`
VALUES (361122, 3611, '广丰县');
INSERT INTO `province_city_district`
VALUES (361123, 3611, '玉山县');
INSERT INTO `province_city_district`
VALUES (361124, 3611, '铅山县');
INSERT INTO `province_city_district`
VALUES (361125, 3611, '横峰县');
INSERT INTO `province_city_district`
VALUES (361126, 3611, '弋阳县');
INSERT INTO `province_city_district`
VALUES (361127, 3611, '余干县');
INSERT INTO `province_city_district`
VALUES (361128, 3611, '波阳县');
INSERT INTO `province_city_district`
VALUES (361129, 3611, '万年县');
INSERT INTO `province_city_district`
VALUES (361130, 3611, '婺源县');
INSERT INTO `province_city_district`
VALUES (361181, 3611, '德兴市');
INSERT INTO `province_city_district`
VALUES (370101, 3701, '市辖区');
INSERT INTO `province_city_district`
VALUES (370102, 3701, '历下区');
INSERT INTO `province_city_district`
VALUES (370103, 3701, '市中区');
INSERT INTO `province_city_district`
VALUES (370104, 3701, '槐荫区');
INSERT INTO `province_city_district`
VALUES (370105, 3701, '天桥区');
INSERT INTO `province_city_district`
VALUES (370112, 3701, '历城区');
INSERT INTO `province_city_district`
VALUES (370123, 3701, '长清县');
INSERT INTO `province_city_district`
VALUES (370124, 3701, '平阴县');
INSERT INTO `province_city_district`
VALUES (370125, 3701, '济阳县');
INSERT INTO `province_city_district`
VALUES (370126, 3701, '商河县');
INSERT INTO `province_city_district`
VALUES (370181, 3701, '章丘市');
INSERT INTO `province_city_district`
VALUES (370201, 3702, '市辖区');
INSERT INTO `province_city_district`
VALUES (370202, 3702, '市南区');
INSERT INTO `province_city_district`
VALUES (370203, 3702, '市北区');
INSERT INTO `province_city_district`
VALUES (370205, 3702, '四方区');
INSERT INTO `province_city_district`
VALUES (370211, 3702, '黄岛区');
INSERT INTO `province_city_district`
VALUES (370212, 3702, '崂山区');
INSERT INTO `province_city_district`
VALUES (370213, 3702, '李沧区');
INSERT INTO `province_city_district`
VALUES (370214, 3702, '城阳区');
INSERT INTO `province_city_district`
VALUES (370281, 3702, '胶州市');
INSERT INTO `province_city_district`
VALUES (370282, 3702, '即墨市');
INSERT INTO `province_city_district`
VALUES (370283, 3702, '平度市');
INSERT INTO `province_city_district`
VALUES (370284, 3702, '胶南市');
INSERT INTO `province_city_district`
VALUES (370285, 3702, '莱西市');
INSERT INTO `province_city_district`
VALUES (370301, 3703, '市辖区');
INSERT INTO `province_city_district`
VALUES (370302, 3703, '淄川区');
INSERT INTO `province_city_district`
VALUES (370303, 3703, '张店区');
INSERT INTO `province_city_district`
VALUES (370304, 3703, '博山区');
INSERT INTO `province_city_district`
VALUES (370305, 3703, '临淄区');
INSERT INTO `province_city_district`
VALUES (370306, 3703, '周村区');
INSERT INTO `province_city_district`
VALUES (370321, 3703, '桓台县');
INSERT INTO `province_city_district`
VALUES (370322, 3703, '高青县');
INSERT INTO `province_city_district`
VALUES (370323, 3703, '沂源县');
INSERT INTO `province_city_district`
VALUES (370401, 3704, '市辖区');
INSERT INTO `province_city_district`
VALUES (370402, 3704, '市中区');
INSERT INTO `province_city_district`
VALUES (370403, 3704, '薛城区');
INSERT INTO `province_city_district`
VALUES (370404, 3704, '峄城区');
INSERT INTO `province_city_district`
VALUES (370405, 3704, '台儿庄区');
INSERT INTO `province_city_district`
VALUES (370406, 3704, '山亭区');
INSERT INTO `province_city_district`
VALUES (370481, 3704, '滕州市');
INSERT INTO `province_city_district`
VALUES (370501, 3705, '市辖区');
INSERT INTO `province_city_district`
VALUES (370502, 3705, '东营区');
INSERT INTO `province_city_district`
VALUES (370503, 3705, '河口区');
INSERT INTO `province_city_district`
VALUES (370521, 3705, '垦利县');
INSERT INTO `province_city_district`
VALUES (370522, 3705, '利津县');
INSERT INTO `province_city_district`
VALUES (370523, 3705, '广饶县');
INSERT INTO `province_city_district`
VALUES (370601, 3706, '市辖区');
INSERT INTO `province_city_district`
VALUES (370602, 3706, '芝罘区');
INSERT INTO `province_city_district`
VALUES (370611, 3706, '福山区');
INSERT INTO `province_city_district`
VALUES (370612, 3706, '牟平区');
INSERT INTO `province_city_district`
VALUES (370613, 3706, '莱山区');
INSERT INTO `province_city_district`
VALUES (370634, 3706, '长岛县');
INSERT INTO `province_city_district`
VALUES (370681, 3706, '龙口市');
INSERT INTO `province_city_district`
VALUES (370682, 3706, '莱阳市');
INSERT INTO `province_city_district`
VALUES (370683, 3706, '莱州市');
INSERT INTO `province_city_district`
VALUES (370684, 3706, '蓬莱市');
INSERT INTO `province_city_district`
VALUES (370685, 3706, '招远市');
INSERT INTO `province_city_district`
VALUES (370686, 3706, '栖霞市');
INSERT INTO `province_city_district`
VALUES (370687, 3706, '海阳市');
INSERT INTO `province_city_district`
VALUES (370701, 3707, '市辖区');
INSERT INTO `province_city_district`
VALUES (370702, 3707, '潍城区');
INSERT INTO `province_city_district`
VALUES (370703, 3707, '寒亭区');
INSERT INTO `province_city_district`
VALUES (370704, 3707, '坊子区');
INSERT INTO `province_city_district`
VALUES (370705, 3707, '奎文区');
INSERT INTO `province_city_district`
VALUES (370724, 3707, '临朐县');
INSERT INTO `province_city_district`
VALUES (370725, 3707, '昌乐县');
INSERT INTO `province_city_district`
VALUES (370781, 3707, '青州市');
INSERT INTO `province_city_district`
VALUES (370782, 3707, '诸城市');
INSERT INTO `province_city_district`
VALUES (370783, 3707, '寿光市');
INSERT INTO `province_city_district`
VALUES (370784, 3707, '安丘市');
INSERT INTO `province_city_district`
VALUES (370785, 3707, '高密市');
INSERT INTO `province_city_district`
VALUES (370786, 3707, '昌邑市');
INSERT INTO `province_city_district`
VALUES (370801, 3708, '市辖区');
INSERT INTO `province_city_district`
VALUES (370802, 3708, '市中区');
INSERT INTO `province_city_district`
VALUES (370811, 3708, '任城区');
INSERT INTO `province_city_district`
VALUES (370826, 3708, '微山县');
INSERT INTO `province_city_district`
VALUES (370827, 3708, '鱼台县');
INSERT INTO `province_city_district`
VALUES (370828, 3708, '金乡县');
INSERT INTO `province_city_district`
VALUES (370829, 3708, '嘉祥县');
INSERT INTO `province_city_district`
VALUES (370830, 3708, '汶上县');
INSERT INTO `province_city_district`
VALUES (370831, 3708, '泗水县');
INSERT INTO `province_city_district`
VALUES (370832, 3708, '梁山县');
INSERT INTO `province_city_district`
VALUES (370881, 3708, '曲阜市');
INSERT INTO `province_city_district`
VALUES (370882, 3708, '兖州市');
INSERT INTO `province_city_district`
VALUES (370883, 3708, '邹城市');
INSERT INTO `province_city_district`
VALUES (370901, 3709, '市辖区');
INSERT INTO `province_city_district`
VALUES (370902, 3709, '泰山区');
INSERT INTO `province_city_district`
VALUES (370903, 3709, '岱岳区');
INSERT INTO `province_city_district`
VALUES (370921, 3709, '宁阳县');
INSERT INTO `province_city_district`
VALUES (370923, 3709, '东平县');
INSERT INTO `province_city_district`
VALUES (370982, 3709, '新泰市');
INSERT INTO `province_city_district`
VALUES (370983, 3709, '肥城市');
INSERT INTO `province_city_district`
VALUES (371001, 3710, '市辖区');
INSERT INTO `province_city_district`
VALUES (371002, 3710, '环翠区');
INSERT INTO `province_city_district`
VALUES (371081, 3710, '文登市');
INSERT INTO `province_city_district`
VALUES (371082, 3710, '荣成市');
INSERT INTO `province_city_district`
VALUES (371083, 3710, '乳山市');
INSERT INTO `province_city_district`
VALUES (371101, 3711, '市辖区');
INSERT INTO `province_city_district`
VALUES (371102, 3711, '东港区');
INSERT INTO `province_city_district`
VALUES (371121, 3711, '五莲县');
INSERT INTO `province_city_district`
VALUES (371122, 3711, '莒  县');
INSERT INTO `province_city_district`
VALUES (371201, 3712, '市辖区');
INSERT INTO `province_city_district`
VALUES (371202, 3712, '莱城区');
INSERT INTO `province_city_district`
VALUES (371203, 3712, '钢城区');
INSERT INTO `province_city_district`
VALUES (371301, 3713, '市辖区');
INSERT INTO `province_city_district`
VALUES (371302, 3713, '兰山区');
INSERT INTO `province_city_district`
VALUES (371311, 3713, '罗庄区');
INSERT INTO `province_city_district`
VALUES (371312, 3713, '河东区');
INSERT INTO `province_city_district`
VALUES (371321, 3713, '沂南县');
INSERT INTO `province_city_district`
VALUES (371322, 3713, '郯城县');
INSERT INTO `province_city_district`
VALUES (371323, 3713, '沂水县');
INSERT INTO `province_city_district`
VALUES (371324, 3713, '苍山县');
INSERT INTO `province_city_district`
VALUES (371325, 3713, '费  县');
INSERT INTO `province_city_district`
VALUES (371326, 3713, '平邑县');
INSERT INTO `province_city_district`
VALUES (371327, 3713, '莒南县');
INSERT INTO `province_city_district`
VALUES (371328, 3713, '蒙阴县');
INSERT INTO `province_city_district`
VALUES (371329, 3713, '临沭县');
INSERT INTO `province_city_district`
VALUES (371401, 3714, '市辖区');
INSERT INTO `province_city_district`
VALUES (371402, 3714, '德城区');
INSERT INTO `province_city_district`
VALUES (371421, 3714, '陵  县');
INSERT INTO `province_city_district`
VALUES (371422, 3714, '宁津县');
INSERT INTO `province_city_district`
VALUES (371423, 3714, '庆云县');
INSERT INTO `province_city_district`
VALUES (371424, 3714, '临邑县');
INSERT INTO `province_city_district`
VALUES (371425, 3714, '齐河县');
INSERT INTO `province_city_district`
VALUES (371426, 3714, '平原县');
INSERT INTO `province_city_district`
VALUES (371427, 3714, '夏津县');
INSERT INTO `province_city_district`
VALUES (371428, 3714, '武城县');
INSERT INTO `province_city_district`
VALUES (371481, 3714, '乐陵市');
INSERT INTO `province_city_district`
VALUES (371482, 3714, '禹城市');
INSERT INTO `province_city_district`
VALUES (371501, 3715, '市辖区');
INSERT INTO `province_city_district`
VALUES (371502, 3715, '东昌府区');
INSERT INTO `province_city_district`
VALUES (371521, 3715, '阳谷县');
INSERT INTO `province_city_district`
VALUES (371522, 3715, '莘  县');
INSERT INTO `province_city_district`
VALUES (371523, 3715, '茌平县');
INSERT INTO `province_city_district`
VALUES (371524, 3715, '东阿县');
INSERT INTO `province_city_district`
VALUES (371525, 3715, '冠  县');
INSERT INTO `province_city_district`
VALUES (371526, 3715, '高唐县');
INSERT INTO `province_city_district`
VALUES (371581, 3715, '临清市');
INSERT INTO `province_city_district`
VALUES (371601, 3716, '市辖区');
INSERT INTO `province_city_district`
VALUES (371603, 3716, '滨城区');
INSERT INTO `province_city_district`
VALUES (371621, 3716, '惠民县');
INSERT INTO `province_city_district`
VALUES (371622, 3716, '阳信县');
INSERT INTO `province_city_district`
VALUES (371623, 3716, '无棣县');
INSERT INTO `province_city_district`
VALUES (371624, 3716, '沾化县');
INSERT INTO `province_city_district`
VALUES (371625, 3716, '博兴县');
INSERT INTO `province_city_district`
VALUES (371626, 3716, '邹平县');
INSERT INTO `province_city_district`
VALUES (371701, 3717, '市辖区');
INSERT INTO `province_city_district`
VALUES (371702, 3717, '牡丹区');
INSERT INTO `province_city_district`
VALUES (371721, 3717, '曹  县');
INSERT INTO `province_city_district`
VALUES (371722, 3717, '单  县');
INSERT INTO `province_city_district`
VALUES (371723, 3717, '成武县');
INSERT INTO `province_city_district`
VALUES (371724, 3717, '巨野县');
INSERT INTO `province_city_district`
VALUES (371725, 3717, '郓城县');
INSERT INTO `province_city_district`
VALUES (371726, 3717, '鄄城县');
INSERT INTO `province_city_district`
VALUES (371727, 3717, '定陶县');
INSERT INTO `province_city_district`
VALUES (371728, 3717, '东明县');
INSERT INTO `province_city_district`
VALUES (410101, 4101, '市辖区');
INSERT INTO `province_city_district`
VALUES (410102, 4101, '中原区');
INSERT INTO `province_city_district`
VALUES (410103, 4101, '二七区');
INSERT INTO `province_city_district`
VALUES (410104, 4101, '管城回族区');
INSERT INTO `province_city_district`
VALUES (410105, 4101, '金水区');
INSERT INTO `province_city_district`
VALUES (410106, 4101, '上街区');
INSERT INTO `province_city_district`
VALUES (410108, 4101, '邙山区');
INSERT INTO `province_city_district`
VALUES (410122, 4101, '中牟县');
INSERT INTO `province_city_district`
VALUES (410181, 4101, '巩义市');
INSERT INTO `province_city_district`
VALUES (410182, 4101, '荥阳市');
INSERT INTO `province_city_district`
VALUES (410183, 4101, '新密市');
INSERT INTO `province_city_district`
VALUES (410184, 4101, '新郑市');
INSERT INTO `province_city_district`
VALUES (410185, 4101, '登封市');
INSERT INTO `province_city_district`
VALUES (410201, 4102, '市辖区');
INSERT INTO `province_city_district`
VALUES (410202, 4102, '龙亭区');
INSERT INTO `province_city_district`
VALUES (410203, 4102, '顺河回族区');
INSERT INTO `province_city_district`
VALUES (410204, 4102, '鼓楼区');
INSERT INTO `province_city_district`
VALUES (410205, 4102, '南关区');
INSERT INTO `province_city_district`
VALUES (410211, 4102, '郊  区');
INSERT INTO `province_city_district`
VALUES (410221, 4102, '杞  县');
INSERT INTO `province_city_district`
VALUES (410222, 4102, '通许县');
INSERT INTO `province_city_district`
VALUES (410223, 4102, '尉氏县');
INSERT INTO `province_city_district`
VALUES (410224, 4102, '开封县');
INSERT INTO `province_city_district`
VALUES (410225, 4102, '兰考县');
INSERT INTO `province_city_district`
VALUES (410301, 4103, '市辖区');
INSERT INTO `province_city_district`
VALUES (410302, 4103, '老城区');
INSERT INTO `province_city_district`
VALUES (410303, 4103, '西工区');
INSERT INTO `province_city_district`
VALUES (410304, 4103, '廛河回族区');
INSERT INTO `province_city_district`
VALUES (410305, 4103, '涧西区');
INSERT INTO `province_city_district`
VALUES (410306, 4103, '吉利区');
INSERT INTO `province_city_district`
VALUES (410307, 4103, '洛龙区');
INSERT INTO `province_city_district`
VALUES (410322, 4103, '孟津县');
INSERT INTO `province_city_district`
VALUES (410323, 4103, '新安县');
INSERT INTO `province_city_district`
VALUES (410324, 4103, '栾川县');
INSERT INTO `province_city_district`
VALUES (410325, 4103, '嵩  县');
INSERT INTO `province_city_district`
VALUES (410326, 4103, '汝阳县');
INSERT INTO `province_city_district`
VALUES (410327, 4103, '宜阳县');
INSERT INTO `province_city_district`
VALUES (410328, 4103, '洛宁县');
INSERT INTO `province_city_district`
VALUES (410329, 4103, '伊川县');
INSERT INTO `province_city_district`
VALUES (410381, 4103, '偃师市');
INSERT INTO `province_city_district`
VALUES (410401, 4104, '市辖区');
INSERT INTO `province_city_district`
VALUES (410402, 4104, '新华区');
INSERT INTO `province_city_district`
VALUES (410403, 4104, '卫东区');
INSERT INTO `province_city_district`
VALUES (410404, 4104, '石龙区');
INSERT INTO `province_city_district`
VALUES (410411, 4104, '湛河区');
INSERT INTO `province_city_district`
VALUES (410421, 4104, '宝丰县');
INSERT INTO `province_city_district`
VALUES (410422, 4104, '叶  县');
INSERT INTO `province_city_district`
VALUES (410423, 4104, '鲁山县');
INSERT INTO `province_city_district`
VALUES (410425, 4104, '郏  县');
INSERT INTO `province_city_district`
VALUES (410481, 4104, '舞钢市');
INSERT INTO `province_city_district`
VALUES (410482, 4104, '汝州市');
INSERT INTO `province_city_district`
VALUES (410501, 4105, '市辖区');
INSERT INTO `province_city_district`
VALUES (410502, 4105, '文峰区');
INSERT INTO `province_city_district`
VALUES (410503, 4105, '北关区');
INSERT INTO `province_city_district`
VALUES (410504, 4105, '铁西区');
INSERT INTO `province_city_district`
VALUES (410511, 4105, '郊  区');
INSERT INTO `province_city_district`
VALUES (410522, 4105, '安阳县');
INSERT INTO `province_city_district`
VALUES (410523, 4105, '汤阴县');
INSERT INTO `province_city_district`
VALUES (410526, 4105, '滑  县');
INSERT INTO `province_city_district`
VALUES (410527, 4105, '内黄县');
INSERT INTO `province_city_district`
VALUES (410581, 4105, '林州市');
INSERT INTO `province_city_district`
VALUES (410601, 4106, '市辖区');
INSERT INTO `province_city_district`
VALUES (410602, 4106, '鹤山区');
INSERT INTO `province_city_district`
VALUES (410603, 4106, '山城区');
INSERT INTO `province_city_district`
VALUES (410611, 4106, '郊  区');
INSERT INTO `province_city_district`
VALUES (410621, 4106, '浚  县');
INSERT INTO `province_city_district`
VALUES (410622, 4106, '淇  县');
INSERT INTO `province_city_district`
VALUES (410701, 4107, '市辖区');
INSERT INTO `province_city_district`
VALUES (410702, 4107, '红旗区');
INSERT INTO `province_city_district`
VALUES (410703, 4107, '新华区');
INSERT INTO `province_city_district`
VALUES (410704, 4107, '北站区');
INSERT INTO `province_city_district`
VALUES (410711, 4107, '郊  区');
INSERT INTO `province_city_district`
VALUES (410721, 4107, '新乡县');
INSERT INTO `province_city_district`
VALUES (410724, 4107, '获嘉县');
INSERT INTO `province_city_district`
VALUES (410725, 4107, '原阳县');
INSERT INTO `province_city_district`
VALUES (410726, 4107, '延津县');
INSERT INTO `province_city_district`
VALUES (410727, 4107, '封丘县');
INSERT INTO `province_city_district`
VALUES (410728, 4107, '长垣县');
INSERT INTO `province_city_district`
VALUES (410781, 4107, '卫辉市');
INSERT INTO `province_city_district`
VALUES (410782, 4107, '辉县市');
INSERT INTO `province_city_district`
VALUES (410801, 4108, '市辖区');
INSERT INTO `province_city_district`
VALUES (410802, 4108, '解放区');
INSERT INTO `province_city_district`
VALUES (410803, 4108, '中站区');
INSERT INTO `province_city_district`
VALUES (410804, 4108, '马村区');
INSERT INTO `province_city_district`
VALUES (410811, 4108, '山阳区');
INSERT INTO `province_city_district`
VALUES (410821, 4108, '修武县');
INSERT INTO `province_city_district`
VALUES (410822, 4108, '博爱县');
INSERT INTO `province_city_district`
VALUES (410823, 4108, '武陟县');
INSERT INTO `province_city_district`
VALUES (410825, 4108, '温  县');
INSERT INTO `province_city_district`
VALUES (410881, 4108, '济源市');
INSERT INTO `province_city_district`
VALUES (410882, 4108, '沁阳市');
INSERT INTO `province_city_district`
VALUES (410883, 4108, '孟州市');
INSERT INTO `province_city_district`
VALUES (410901, 4109, '市辖区');
INSERT INTO `province_city_district`
VALUES (410902, 4109, '市  区');
INSERT INTO `province_city_district`
VALUES (410922, 4109, '清丰县');
INSERT INTO `province_city_district`
VALUES (410923, 4109, '南乐县');
INSERT INTO `province_city_district`
VALUES (410926, 4109, '范  县');
INSERT INTO `province_city_district`
VALUES (410927, 4109, '台前县');
INSERT INTO `province_city_district`
VALUES (410928, 4109, '濮阳县');
INSERT INTO `province_city_district`
VALUES (411001, 4110, '市辖区');
INSERT INTO `province_city_district`
VALUES (411002, 4110, '魏都区');
INSERT INTO `province_city_district`
VALUES (411023, 4110, '许昌县');
INSERT INTO `province_city_district`
VALUES (411024, 4110, '鄢陵县');
INSERT INTO `province_city_district`
VALUES (411025, 4110, '襄城县');
INSERT INTO `province_city_district`
VALUES (411081, 4110, '禹州市');
INSERT INTO `province_city_district`
VALUES (411082, 4110, '长葛市');
INSERT INTO `province_city_district`
VALUES (411101, 4111, '市辖区');
INSERT INTO `province_city_district`
VALUES (411102, 4111, '源汇区');
INSERT INTO `province_city_district`
VALUES (411121, 4111, '舞阳县');
INSERT INTO `province_city_district`
VALUES (411122, 4111, '临颍县');
INSERT INTO `province_city_district`
VALUES (411123, 4111, '郾城县');
INSERT INTO `province_city_district`
VALUES (411201, 4112, '市辖区');
INSERT INTO `province_city_district`
VALUES (411202, 4112, '湖滨区');
INSERT INTO `province_city_district`
VALUES (411221, 4112, '渑池县');
INSERT INTO `province_city_district`
VALUES (411222, 4112, '陕  县');
INSERT INTO `province_city_district`
VALUES (411224, 4112, '卢氏县');
INSERT INTO `province_city_district`
VALUES (411281, 4112, '义马市');
INSERT INTO `province_city_district`
VALUES (411282, 4112, '灵宝市');
INSERT INTO `province_city_district`
VALUES (411301, 4113, '市辖区');
INSERT INTO `province_city_district`
VALUES (411302, 4113, '宛城区');
INSERT INTO `province_city_district`
VALUES (411303, 4113, '卧龙区');
INSERT INTO `province_city_district`
VALUES (411321, 4113, '南召县');
INSERT INTO `province_city_district`
VALUES (411322, 4113, '方城县');
INSERT INTO `province_city_district`
VALUES (411323, 4113, '西峡县');
INSERT INTO `province_city_district`
VALUES (411324, 4113, '镇平县');
INSERT INTO `province_city_district`
VALUES (411325, 4113, '内乡县');
INSERT INTO `province_city_district`
VALUES (411326, 4113, '淅川县');
INSERT INTO `province_city_district`
VALUES (411327, 4113, '社旗县');
INSERT INTO `province_city_district`
VALUES (411328, 4113, '唐河县');
INSERT INTO `province_city_district`
VALUES (411329, 4113, '新野县');
INSERT INTO `province_city_district`
VALUES (411330, 4113, '桐柏县');
INSERT INTO `province_city_district`
VALUES (411381, 4113, '邓州市');
INSERT INTO `province_city_district`
VALUES (411401, 4114, '市辖区');
INSERT INTO `province_city_district`
VALUES (411402, 4114, '梁园区');
INSERT INTO `province_city_district`
VALUES (411403, 4114, '睢阳区');
INSERT INTO `province_city_district`
VALUES (411421, 4114, '民权县');
INSERT INTO `province_city_district`
VALUES (411422, 4114, '睢  县');
INSERT INTO `province_city_district`
VALUES (411423, 4114, '宁陵县');
INSERT INTO `province_city_district`
VALUES (411424, 4114, '柘城县');
INSERT INTO `province_city_district`
VALUES (411425, 4114, '虞城县');
INSERT INTO `province_city_district`
VALUES (411426, 4114, '夏邑县');
INSERT INTO `province_city_district`
VALUES (411481, 4114, '永城市');
INSERT INTO `province_city_district`
VALUES (411501, 4115, '市辖区');
INSERT INTO `province_city_district`
VALUES (411502, 4115, '师河区');
INSERT INTO `province_city_district`
VALUES (411503, 4115, '平桥区');
INSERT INTO `province_city_district`
VALUES (411521, 4115, '罗山县');
INSERT INTO `province_city_district`
VALUES (411522, 4115, '光山县');
INSERT INTO `province_city_district`
VALUES (411523, 4115, '新  县');
INSERT INTO `province_city_district`
VALUES (411524, 4115, '商城县');
INSERT INTO `province_city_district`
VALUES (411525, 4115, '固始县');
INSERT INTO `province_city_district`
VALUES (411526, 4115, '潢川县');
INSERT INTO `province_city_district`
VALUES (411527, 4115, '淮滨县');
INSERT INTO `province_city_district`
VALUES (411528, 4115, '息  县');
INSERT INTO `province_city_district`
VALUES (411601, 4116, '市辖区');
INSERT INTO `province_city_district`
VALUES (411602, 4116, '川汇区');
INSERT INTO `province_city_district`
VALUES (411621, 4116, '扶沟县');
INSERT INTO `province_city_district`
VALUES (411622, 4116, '西华县');
INSERT INTO `province_city_district`
VALUES (411623, 4116, '商水县');
INSERT INTO `province_city_district`
VALUES (411624, 4116, '沈丘县');
INSERT INTO `province_city_district`
VALUES (411625, 4116, '郸城县');
INSERT INTO `province_city_district`
VALUES (411626, 4116, '淮阳县');
INSERT INTO `province_city_district`
VALUES (411627, 4116, '太康县');
INSERT INTO `province_city_district`
VALUES (411628, 4116, '鹿邑县');
INSERT INTO `province_city_district`
VALUES (411681, 4116, '项城市');
INSERT INTO `province_city_district`
VALUES (411701, 4117, '市辖区');
INSERT INTO `province_city_district`
VALUES (411702, 4117, '驿城区');
INSERT INTO `province_city_district`
VALUES (411721, 4117, '西平县');
INSERT INTO `province_city_district`
VALUES (411722, 4117, '上蔡县');
INSERT INTO `province_city_district`
VALUES (411723, 4117, '平舆县');
INSERT INTO `province_city_district`
VALUES (411724, 4117, '正阳县');
INSERT INTO `province_city_district`
VALUES (411725, 4117, '确山县');
INSERT INTO `province_city_district`
VALUES (411726, 4117, '泌阳县');
INSERT INTO `province_city_district`
VALUES (411727, 4117, '汝南县');
INSERT INTO `province_city_district`
VALUES (411728, 4117, '遂平县');
INSERT INTO `province_city_district`
VALUES (411729, 4117, '新蔡县');
INSERT INTO `province_city_district`
VALUES (420101, 4201, '市辖区');
INSERT INTO `province_city_district`
VALUES (420102, 4201, '江岸区');
INSERT INTO `province_city_district`
VALUES (420103, 4201, '江汉区');
INSERT INTO `province_city_district`
VALUES (420104, 4201, '乔口区');
INSERT INTO `province_city_district`
VALUES (420105, 4201, '汉阳区');
INSERT INTO `province_city_district`
VALUES (420106, 4201, '武昌区');
INSERT INTO `province_city_district`
VALUES (420107, 4201, '青山区');
INSERT INTO `province_city_district`
VALUES (420111, 4201, '洪山区');
INSERT INTO `province_city_district`
VALUES (420112, 4201, '东西湖区');
INSERT INTO `province_city_district`
VALUES (420113, 4201, '汉南区');
INSERT INTO `province_city_district`
VALUES (420114, 4201, '蔡甸区');
INSERT INTO `province_city_district`
VALUES (420115, 4201, '江夏区');
INSERT INTO `province_city_district`
VALUES (420116, 4201, '黄陂区');
INSERT INTO `province_city_district`
VALUES (420117, 4201, '新洲区');
INSERT INTO `province_city_district`
VALUES (420201, 4202, '市辖区');
INSERT INTO `province_city_district`
VALUES (420202, 4202, '黄石港区');
INSERT INTO `province_city_district`
VALUES (420203, 4202, '石灰窑区');
INSERT INTO `province_city_district`
VALUES (420204, 4202, '下陆区');
INSERT INTO `province_city_district`
VALUES (420205, 4202, '铁山区');
INSERT INTO `province_city_district`
VALUES (420222, 4202, '阳新县');
INSERT INTO `province_city_district`
VALUES (420281, 4202, '大冶市');
INSERT INTO `province_city_district`
VALUES (420301, 4203, '市辖区');
INSERT INTO `province_city_district`
VALUES (420302, 4203, '茅箭区');
INSERT INTO `province_city_district`
VALUES (420303, 4203, '张湾区');
INSERT INTO `province_city_district`
VALUES (420321, 4203, '郧  县');
INSERT INTO `province_city_district`
VALUES (420322, 4203, '郧西县');
INSERT INTO `province_city_district`
VALUES (420323, 4203, '竹山县');
INSERT INTO `province_city_district`
VALUES (420324, 4203, '竹溪县');
INSERT INTO `province_city_district`
VALUES (420325, 4203, '房  县');
INSERT INTO `province_city_district`
VALUES (420381, 4203, '丹江口市');
INSERT INTO `province_city_district`
VALUES (420501, 4205, '市辖区');
INSERT INTO `province_city_district`
VALUES (420502, 4205, '西陵区');
INSERT INTO `province_city_district`
VALUES (420503, 4205, '伍家岗区');
INSERT INTO `province_city_district`
VALUES (420504, 4205, '点军区');
INSERT INTO `province_city_district`
VALUES (420505, 4205, '虎亭区');
INSERT INTO `province_city_district`
VALUES (420521, 4205, '宜昌县');
INSERT INTO `province_city_district`
VALUES (420525, 4205, '远安县');
INSERT INTO `province_city_district`
VALUES (420526, 4205, '兴山县');
INSERT INTO `province_city_district`
VALUES (420527, 4205, '秭归县');
INSERT INTO `province_city_district`
VALUES (420528, 4205, '长阳土家族自治县');
INSERT INTO `province_city_district`
VALUES (420529, 4205, '五峰土家族自治县');
INSERT INTO `province_city_district`
VALUES (420581, 4205, '宜都市');
INSERT INTO `province_city_district`
VALUES (420582, 4205, '当阳市');
INSERT INTO `province_city_district`
VALUES (420583, 4205, '枝江市');
INSERT INTO `province_city_district`
VALUES (420601, 4206, '市辖区');
INSERT INTO `province_city_district`
VALUES (420602, 4206, '襄城区');
INSERT INTO `province_city_district`
VALUES (420606, 4206, '樊城区');
INSERT INTO `province_city_district`
VALUES (420621, 4206, '襄阳县');
INSERT INTO `province_city_district`
VALUES (420624, 4206, '南漳县');
INSERT INTO `province_city_district`
VALUES (420625, 4206, '谷城县');
INSERT INTO `province_city_district`
VALUES (420626, 4206, '保康县');
INSERT INTO `province_city_district`
VALUES (420682, 4206, '老河口市');
INSERT INTO `province_city_district`
VALUES (420683, 4206, '枣阳市');
INSERT INTO `province_city_district`
VALUES (420684, 4206, '宜城市');
INSERT INTO `province_city_district`
VALUES (420701, 4207, '市辖区');
INSERT INTO `province_city_district`
VALUES (420702, 4207, '梁子湖区');
INSERT INTO `province_city_district`
VALUES (420703, 4207, '华容区');
INSERT INTO `province_city_district`
VALUES (420704, 4207, '鄂城区');
INSERT INTO `province_city_district`
VALUES (420801, 4208, '市辖区');
INSERT INTO `province_city_district`
VALUES (420802, 4208, '东宝区');
INSERT INTO `province_city_district`
VALUES (420821, 4208, '京山县');
INSERT INTO `province_city_district`
VALUES (420822, 4208, '沙洋县');
INSERT INTO `province_city_district`
VALUES (420881, 4208, '钟祥市');
INSERT INTO `province_city_district`
VALUES (420901, 4209, '市辖区');
INSERT INTO `province_city_district`
VALUES (420902, 4209, '孝南区');
INSERT INTO `province_city_district`
VALUES (420921, 4209, '孝昌县');
INSERT INTO `province_city_district`
VALUES (420922, 4209, '大悟县');
INSERT INTO `province_city_district`
VALUES (420923, 4209, '云梦县');
INSERT INTO `province_city_district`
VALUES (420981, 4209, '应城市');
INSERT INTO `province_city_district`
VALUES (420982, 4209, '安陆市');
INSERT INTO `province_city_district`
VALUES (420984, 4209, '汉川市');
INSERT INTO `province_city_district`
VALUES (421001, 4210, '市辖区');
INSERT INTO `province_city_district`
VALUES (421002, 4210, '沙市区');
INSERT INTO `province_city_district`
VALUES (421003, 4210, '荆州区');
INSERT INTO `province_city_district`
VALUES (421022, 4210, '公安县');
INSERT INTO `province_city_district`
VALUES (421023, 4210, '监利县');
INSERT INTO `province_city_district`
VALUES (421024, 4210, '江陵县');
INSERT INTO `province_city_district`
VALUES (421081, 4210, '石首市');
INSERT INTO `province_city_district`
VALUES (421083, 4210, '洪湖市');
INSERT INTO `province_city_district`
VALUES (421087, 4210, '松滋市');
INSERT INTO `province_city_district`
VALUES (421101, 4211, '市辖区');
INSERT INTO `province_city_district`
VALUES (421102, 4211, '黄州区');
INSERT INTO `province_city_district`
VALUES (421121, 4211, '团风县');
INSERT INTO `province_city_district`
VALUES (421122, 4211, '红安县');
INSERT INTO `province_city_district`
VALUES (421123, 4211, '罗田县');
INSERT INTO `province_city_district`
VALUES (421124, 4211, '英山县');
INSERT INTO `province_city_district`
VALUES (421125, 4211, '浠水县');
INSERT INTO `province_city_district`
VALUES (421126, 4211, '蕲春县');
INSERT INTO `province_city_district`
VALUES (421127, 4211, '黄梅县');
INSERT INTO `province_city_district`
VALUES (421181, 4211, '麻城市');
INSERT INTO `province_city_district`
VALUES (421182, 4211, '武穴市');
INSERT INTO `province_city_district`
VALUES (421201, 4212, '市辖区');
INSERT INTO `province_city_district`
VALUES (421202, 4212, '咸安区');
INSERT INTO `province_city_district`
VALUES (421221, 4212, '嘉鱼县');
INSERT INTO `province_city_district`
VALUES (421222, 4212, '通城县');
INSERT INTO `province_city_district`
VALUES (421223, 4212, '崇阳县');
INSERT INTO `province_city_district`
VALUES (421224, 4212, '通山县');
INSERT INTO `province_city_district`
VALUES (421281, 4212, '赤壁市');
INSERT INTO `province_city_district`
VALUES (421301, 4213, '市辖区');
INSERT INTO `province_city_district`
VALUES (421302, 4213, '曾都区');
INSERT INTO `province_city_district`
VALUES (421381, 4213, '广水市');
INSERT INTO `province_city_district`
VALUES (422801, 4228, '恩施市');
INSERT INTO `province_city_district`
VALUES (422802, 4228, '利川市');
INSERT INTO `province_city_district`
VALUES (422822, 4228, '建始县');
INSERT INTO `province_city_district`
VALUES (422823, 4228, '巴东县');
INSERT INTO `province_city_district`
VALUES (422825, 4228, '宣恩县');
INSERT INTO `province_city_district`
VALUES (422826, 4228, '咸丰县');
INSERT INTO `province_city_district`
VALUES (422827, 4228, '来凤县');
INSERT INTO `province_city_district`
VALUES (422828, 4228, '鹤峰县');
INSERT INTO `province_city_district`
VALUES (429004, 4290, '仙桃市');
INSERT INTO `province_city_district`
VALUES (429005, 4290, '潜江市');
INSERT INTO `province_city_district`
VALUES (429006, 4290, '天门市');
INSERT INTO `province_city_district`
VALUES (429021, 4290, '神农架林区');
INSERT INTO `province_city_district`
VALUES (430101, 4301, '市辖区');
INSERT INTO `province_city_district`
VALUES (430102, 4301, '芙蓉区');
INSERT INTO `province_city_district`
VALUES (430103, 4301, '天心区');
INSERT INTO `province_city_district`
VALUES (430104, 4301, '岳麓区');
INSERT INTO `province_city_district`
VALUES (430105, 4301, '开福区');
INSERT INTO `province_city_district`
VALUES (430111, 4301, '雨花区');
INSERT INTO `province_city_district`
VALUES (430121, 4301, '长沙县');
INSERT INTO `province_city_district`
VALUES (430122, 4301, '望城县');
INSERT INTO `province_city_district`
VALUES (430124, 4301, '宁乡县');
INSERT INTO `province_city_district`
VALUES (430181, 4301, '浏阳市');
INSERT INTO `province_city_district`
VALUES (430201, 4302, '市辖区');
INSERT INTO `province_city_district`
VALUES (430202, 4302, '荷塘区');
INSERT INTO `province_city_district`
VALUES (430203, 4302, '芦淞区');
INSERT INTO `province_city_district`
VALUES (430204, 4302, '石峰区');
INSERT INTO `province_city_district`
VALUES (430211, 4302, '天元区');
INSERT INTO `province_city_district`
VALUES (430221, 4302, '株洲县');
INSERT INTO `province_city_district`
VALUES (430223, 4302, '攸  县');
INSERT INTO `province_city_district`
VALUES (430224, 4302, '茶陵县');
INSERT INTO `province_city_district`
VALUES (430225, 4302, '炎陵县');
INSERT INTO `province_city_district`
VALUES (430281, 4302, '醴陵市');
INSERT INTO `province_city_district`
VALUES (430301, 4303, '市辖区');
INSERT INTO `province_city_district`
VALUES (430302, 4303, '雨湖区');
INSERT INTO `province_city_district`
VALUES (430304, 4303, '岳塘区');
INSERT INTO `province_city_district`
VALUES (430321, 4303, '湘潭县');
INSERT INTO `province_city_district`
VALUES (430381, 4303, '湘乡市');
INSERT INTO `province_city_district`
VALUES (430382, 4303, '韶山市');
INSERT INTO `province_city_district`
VALUES (430401, 4304, '市辖区');
INSERT INTO `province_city_district`
VALUES (430402, 4304, '江东区');
INSERT INTO `province_city_district`
VALUES (430403, 4304, '城南区');
INSERT INTO `province_city_district`
VALUES (430404, 4304, '城北区');
INSERT INTO `province_city_district`
VALUES (430411, 4304, '郊   区');
INSERT INTO `province_city_district`
VALUES (430412, 4304, '南岳区');
INSERT INTO `province_city_district`
VALUES (430421, 4304, '衡阳县');
INSERT INTO `province_city_district`
VALUES (430422, 4304, '衡南县');
INSERT INTO `province_city_district`
VALUES (430423, 4304, '衡山县');
INSERT INTO `province_city_district`
VALUES (430424, 4304, '衡东县');
INSERT INTO `province_city_district`
VALUES (430426, 4304, '祁东县');
INSERT INTO `province_city_district`
VALUES (430481, 4304, '耒阳市');
INSERT INTO `province_city_district`
VALUES (430482, 4304, '常宁市');
INSERT INTO `province_city_district`
VALUES (430501, 4305, '市辖区');
INSERT INTO `province_city_district`
VALUES (430502, 4305, '双清区');
INSERT INTO `province_city_district`
VALUES (430503, 4305, '大祥区');
INSERT INTO `province_city_district`
VALUES (430511, 4305, '北塔区');
INSERT INTO `province_city_district`
VALUES (430521, 4305, '邵东县');
INSERT INTO `province_city_district`
VALUES (430522, 4305, '新邵县');
INSERT INTO `province_city_district`
VALUES (430523, 4305, '邵阳县');
INSERT INTO `province_city_district`
VALUES (430524, 4305, '隆回县');
INSERT INTO `province_city_district`
VALUES (430525, 4305, '洞口县');
INSERT INTO `province_city_district`
VALUES (430527, 4305, '绥宁县');
INSERT INTO `province_city_district`
VALUES (430528, 4305, '新宁县');
INSERT INTO `province_city_district`
VALUES (430529, 4305, '城步苗族自治县');
INSERT INTO `province_city_district`
VALUES (430581, 4305, '武冈市');
INSERT INTO `province_city_district`
VALUES (430601, 4306, '市辖区');
INSERT INTO `province_city_district`
VALUES (430602, 4306, '岳阳楼区');
INSERT INTO `province_city_district`
VALUES (430603, 4306, '云溪区');
INSERT INTO `province_city_district`
VALUES (430611, 4306, '君山区');
INSERT INTO `province_city_district`
VALUES (430621, 4306, '岳阳县');
INSERT INTO `province_city_district`
VALUES (430623, 4306, '华容县');
INSERT INTO `province_city_district`
VALUES (430624, 4306, '湘阴县');
INSERT INTO `province_city_district`
VALUES (430626, 4306, '平江县');
INSERT INTO `province_city_district`
VALUES (430681, 4306, '汨罗市');
INSERT INTO `province_city_district`
VALUES (430682, 4306, '临湘市');
INSERT INTO `province_city_district`
VALUES (430701, 4307, '市辖区');
INSERT INTO `province_city_district`
VALUES (430702, 4307, '武陵区');
INSERT INTO `province_city_district`
VALUES (430703, 4307, '鼎城区');
INSERT INTO `province_city_district`
VALUES (430721, 4307, '安乡县');
INSERT INTO `province_city_district`
VALUES (430722, 4307, '汉寿县');
INSERT INTO `province_city_district`
VALUES (430723, 4307, '澧  县');
INSERT INTO `province_city_district`
VALUES (430724, 4307, '临澧县');
INSERT INTO `province_city_district`
VALUES (430725, 4307, '桃源县');
INSERT INTO `province_city_district`
VALUES (430726, 4307, '石门县');
INSERT INTO `province_city_district`
VALUES (430781, 4307, '津市市');
INSERT INTO `province_city_district`
VALUES (430801, 4308, '市辖区');
INSERT INTO `province_city_district`
VALUES (430802, 4308, '永定区');
INSERT INTO `province_city_district`
VALUES (430811, 4308, '武陵源区');
INSERT INTO `province_city_district`
VALUES (430821, 4308, '慈利县');
INSERT INTO `province_city_district`
VALUES (430822, 4308, '桑植县');
INSERT INTO `province_city_district`
VALUES (430901, 4309, '市辖区');
INSERT INTO `province_city_district`
VALUES (430902, 4309, '资阳区');
INSERT INTO `province_city_district`
VALUES (430903, 4309, '赫山区');
INSERT INTO `province_city_district`
VALUES (430921, 4309, '南  县');
INSERT INTO `province_city_district`
VALUES (430922, 4309, '桃江县');
INSERT INTO `province_city_district`
VALUES (430923, 4309, '安化县');
INSERT INTO `province_city_district`
VALUES (430981, 4309, '沅江市');
INSERT INTO `province_city_district`
VALUES (431001, 4310, '市辖区');
INSERT INTO `province_city_district`
VALUES (431002, 4310, '北湖区');
INSERT INTO `province_city_district`
VALUES (431003, 4310, '苏仙区');
INSERT INTO `province_city_district`
VALUES (431021, 4310, '桂阳县');
INSERT INTO `province_city_district`
VALUES (431022, 4310, '宜章县');
INSERT INTO `province_city_district`
VALUES (431023, 4310, '永兴县');
INSERT INTO `province_city_district`
VALUES (431024, 4310, '嘉禾县');
INSERT INTO `province_city_district`
VALUES (431025, 4310, '临武县');
INSERT INTO `province_city_district`
VALUES (431026, 4310, '汝城县');
INSERT INTO `province_city_district`
VALUES (431027, 4310, '桂东县');
INSERT INTO `province_city_district`
VALUES (431028, 4310, '安仁县');
INSERT INTO `province_city_district`
VALUES (431081, 4310, '资兴市');
INSERT INTO `province_city_district`
VALUES (431101, 4311, '市辖区');
INSERT INTO `province_city_district`
VALUES (431102, 4311, '芝山区');
INSERT INTO `province_city_district`
VALUES (431103, 4311, '冷水滩区');
INSERT INTO `province_city_district`
VALUES (431121, 4311, '祁阳县');
INSERT INTO `province_city_district`
VALUES (431122, 4311, '东安县');
INSERT INTO `province_city_district`
VALUES (431123, 4311, '双牌县');
INSERT INTO `province_city_district`
VALUES (431124, 4311, '道  县');
INSERT INTO `province_city_district`
VALUES (431125, 4311, '江永县');
INSERT INTO `province_city_district`
VALUES (431126, 4311, '宁远县');
INSERT INTO `province_city_district`
VALUES (431127, 4311, '蓝山县');
INSERT INTO `province_city_district`
VALUES (431128, 4311, '新田县');
INSERT INTO `province_city_district`
VALUES (431129, 4311, '江华瑶族自治县');
INSERT INTO `province_city_district`
VALUES (431201, 4312, '市辖区');
INSERT INTO `province_city_district`
VALUES (431202, 4312, '鹤城区');
INSERT INTO `province_city_district`
VALUES (431221, 4312, '中方县');
INSERT INTO `province_city_district`
VALUES (431222, 4312, '沅陵县');
INSERT INTO `province_city_district`
VALUES (431223, 4312, '辰溪县');
INSERT INTO `province_city_district`
VALUES (431224, 4312, '溆浦县');
INSERT INTO `province_city_district`
VALUES (431225, 4312, '会同县');
INSERT INTO `province_city_district`
VALUES (431226, 4312, '麻阳苗族自治县');
INSERT INTO `province_city_district`
VALUES (431227, 4312, '新晃侗族自治县');
INSERT INTO `province_city_district`
VALUES (431228, 4312, '芷江侗族自治县');
INSERT INTO `province_city_district`
VALUES (431229, 4312, '靖州苗族侗族自治县');
INSERT INTO `province_city_district`
VALUES (431230, 4312, '通道侗族自治县');
INSERT INTO `province_city_district`
VALUES (431281, 4312, '洪江市');
INSERT INTO `province_city_district`
VALUES (431301, 4313, '市辖区');
INSERT INTO `province_city_district`
VALUES (431302, 4313, '娄星区');
INSERT INTO `province_city_district`
VALUES (431321, 4313, '双峰县');
INSERT INTO `province_city_district`
VALUES (431322, 4313, '新化县');
INSERT INTO `province_city_district`
VALUES (431381, 4313, '冷水江市');
INSERT INTO `province_city_district`
VALUES (431382, 4313, '涟源市');
INSERT INTO `province_city_district`
VALUES (433101, 4331, '吉首市');
INSERT INTO `province_city_district`
VALUES (433122, 4331, '泸溪县');
INSERT INTO `province_city_district`
VALUES (433123, 4331, '凤凰县');
INSERT INTO `province_city_district`
VALUES (433124, 4331, '花垣县');
INSERT INTO `province_city_district`
VALUES (433125, 4331, '保靖县');
INSERT INTO `province_city_district`
VALUES (433126, 4331, '古丈县');
INSERT INTO `province_city_district`
VALUES (433127, 4331, '永顺县');
INSERT INTO `province_city_district`
VALUES (433130, 4331, '龙山县');
INSERT INTO `province_city_district`
VALUES (440101, 4401, '市辖区');
INSERT INTO `province_city_district`
VALUES (440102, 4401, '东山区');
INSERT INTO `province_city_district`
VALUES (440103, 4401, '荔湾区');
INSERT INTO `province_city_district`
VALUES (440104, 4401, '越秀区');
INSERT INTO `province_city_district`
VALUES (440105, 4401, '海珠区');
INSERT INTO `province_city_district`
VALUES (440106, 4401, '天河区');
INSERT INTO `province_city_district`
VALUES (440107, 4401, '芳村区');
INSERT INTO `province_city_district`
VALUES (440111, 4401, '白云区');
INSERT INTO `province_city_district`
VALUES (440112, 4401, '黄埔区');
INSERT INTO `province_city_district`
VALUES (440113, 4401, '番禺区');
INSERT INTO `province_city_district`
VALUES (440114, 4401, '花都区');
INSERT INTO `province_city_district`
VALUES (440183, 4401, '增城市');
INSERT INTO `province_city_district`
VALUES (440184, 4401, '从化市');
INSERT INTO `province_city_district`
VALUES (440201, 4402, '市辖区');
INSERT INTO `province_city_district`
VALUES (440202, 4402, '北江区');
INSERT INTO `province_city_district`
VALUES (440203, 4402, '武江区');
INSERT INTO `province_city_district`
VALUES (440204, 4402, '浈江区');
INSERT INTO `province_city_district`
VALUES (440221, 4402, '曲江县');
INSERT INTO `province_city_district`
VALUES (440222, 4402, '始兴县');
INSERT INTO `province_city_district`
VALUES (440224, 4402, '仁化县');
INSERT INTO `province_city_district`
VALUES (440229, 4402, '翁源县');
INSERT INTO `province_city_district`
VALUES (440232, 4402, '乳源瑶族自治县');
INSERT INTO `province_city_district`
VALUES (440233, 4402, '新丰县');
INSERT INTO `province_city_district`
VALUES (440281, 4402, '乐昌市');
INSERT INTO `province_city_district`
VALUES (440282, 4402, '南雄市');
INSERT INTO `province_city_district`
VALUES (440301, 4403, '市辖区');
INSERT INTO `province_city_district`
VALUES (440303, 4403, '罗湖区');
INSERT INTO `province_city_district`
VALUES (440304, 4403, '福田区');
INSERT INTO `province_city_district`
VALUES (440305, 4403, '南山区');
INSERT INTO `province_city_district`
VALUES (440306, 4403, '宝安区');
INSERT INTO `province_city_district`
VALUES (440307, 4403, '龙岗区');
INSERT INTO `province_city_district`
VALUES (440308, 4403, '盐田区');
INSERT INTO `province_city_district`
VALUES (440401, 4404, '市辖区');
INSERT INTO `province_city_district`
VALUES (440402, 4404, '香洲区');
INSERT INTO `province_city_district`
VALUES (440421, 4404, '斗门县');
INSERT INTO `province_city_district`
VALUES (440501, 4405, '市辖区');
INSERT INTO `province_city_district`
VALUES (440506, 4405, '达濠区');
INSERT INTO `province_city_district`
VALUES (440507, 4405, '龙湖区');
INSERT INTO `province_city_district`
VALUES (440508, 4405, '金园区');
INSERT INTO `province_city_district`
VALUES (440509, 4405, '升平区');
INSERT INTO `province_city_district`
VALUES (440510, 4405, '河浦区');
INSERT INTO `province_city_district`
VALUES (440523, 4405, '南澳县');
INSERT INTO `province_city_district`
VALUES (440582, 4405, '潮阳市');
INSERT INTO `province_city_district`
VALUES (440583, 4405, '澄海市');
INSERT INTO `province_city_district`
VALUES (440601, 4406, '市辖区');
INSERT INTO `province_city_district`
VALUES (440602, 4406, '城  区');
INSERT INTO `province_city_district`
VALUES (440603, 4406, '石湾区');
INSERT INTO `province_city_district`
VALUES (440681, 4406, '顺德市');
INSERT INTO `province_city_district`
VALUES (440682, 4406, '南海市');
INSERT INTO `province_city_district`
VALUES (440683, 4406, '三水市');
INSERT INTO `province_city_district`
VALUES (440684, 4406, '高明市');
INSERT INTO `province_city_district`
VALUES (440701, 4407, '市辖区');
INSERT INTO `province_city_district`
VALUES (440703, 4407, '蓬江区');
INSERT INTO `province_city_district`
VALUES (440704, 4407, '江海区');
INSERT INTO `province_city_district`
VALUES (440781, 4407, '台山市');
INSERT INTO `province_city_district`
VALUES (440782, 4407, '新会市');
INSERT INTO `province_city_district`
VALUES (440783, 4407, '开平市');
INSERT INTO `province_city_district`
VALUES (440784, 4407, '鹤山市');
INSERT INTO `province_city_district`
VALUES (440785, 4407, '恩平市');
INSERT INTO `province_city_district`
VALUES (440801, 4408, '市辖区');
INSERT INTO `province_city_district`
VALUES (440802, 4408, '赤坎区');
INSERT INTO `province_city_district`
VALUES (440803, 4408, '霞山区');
INSERT INTO `province_city_district`
VALUES (440804, 4408, '坡头区');
INSERT INTO `province_city_district`
VALUES (440811, 4408, '麻章区');
INSERT INTO `province_city_district`
VALUES (440823, 4408, '遂溪县');
INSERT INTO `province_city_district`
VALUES (440825, 4408, '徐闻县');
INSERT INTO `province_city_district`
VALUES (440881, 4408, '廉江市');
INSERT INTO `province_city_district`
VALUES (440882, 4408, '雷州市');
INSERT INTO `province_city_district`
VALUES (440883, 4408, '吴川市');
INSERT INTO `province_city_district`
VALUES (440901, 4409, '市辖区');
INSERT INTO `province_city_district`
VALUES (440902, 4409, '茂南区');
INSERT INTO `province_city_district`
VALUES (440923, 4409, '电白县');
INSERT INTO `province_city_district`
VALUES (440981, 4409, '高州市');
INSERT INTO `province_city_district`
VALUES (440982, 4409, '化州市');
INSERT INTO `province_city_district`
VALUES (440983, 4409, '信宜市');
INSERT INTO `province_city_district`
VALUES (441201, 4412, '市辖区');
INSERT INTO `province_city_district`
VALUES (441202, 4412, '端州区');
INSERT INTO `province_city_district`
VALUES (441203, 4412, '鼎湖区');
INSERT INTO `province_city_district`
VALUES (441223, 4412, '广宁县');
INSERT INTO `province_city_district`
VALUES (441224, 4412, '怀集县');
INSERT INTO `province_city_district`
VALUES (441225, 4412, '封开县');
INSERT INTO `province_city_district`
VALUES (441226, 4412, '德庆县');
INSERT INTO `province_city_district`
VALUES (441283, 4412, '高要市');
INSERT INTO `province_city_district`
VALUES (441284, 4412, '四会市');
INSERT INTO `province_city_district`
VALUES (441301, 4413, '市辖区');
INSERT INTO `province_city_district`
VALUES (441302, 4413, '惠城区');
INSERT INTO `province_city_district`
VALUES (441322, 4413, '博罗县');
INSERT INTO `province_city_district`
VALUES (441323, 4413, '惠东县');
INSERT INTO `province_city_district`
VALUES (441324, 4413, '龙门县');
INSERT INTO `province_city_district`
VALUES (441381, 4413, '惠阳市');
INSERT INTO `province_city_district`
VALUES (441401, 4414, '市辖区');
INSERT INTO `province_city_district`
VALUES (441402, 4414, '梅江区');
INSERT INTO `province_city_district`
VALUES (441421, 4414, '梅  县');
INSERT INTO `province_city_district`
VALUES (441422, 4414, '大埔县');
INSERT INTO `province_city_district`
VALUES (441423, 4414, '丰顺县');
INSERT INTO `province_city_district`
VALUES (441424, 4414, '五华县');
INSERT INTO `province_city_district`
VALUES (441426, 4414, '平远县');
INSERT INTO `province_city_district`
VALUES (441427, 4414, '蕉岭县');
INSERT INTO `province_city_district`
VALUES (441481, 4414, '兴宁市');
INSERT INTO `province_city_district`
VALUES (441501, 4415, '市辖区');
INSERT INTO `province_city_district`
VALUES (441502, 4415, '城  区');
INSERT INTO `province_city_district`
VALUES (441521, 4415, '海丰县');
INSERT INTO `province_city_district`
VALUES (441523, 4415, '陆河县');
INSERT INTO `province_city_district`
VALUES (441581, 4415, '陆丰市');
INSERT INTO `province_city_district`
VALUES (441601, 4416, '市辖区');
INSERT INTO `province_city_district`
VALUES (441602, 4416, '源城区');
INSERT INTO `province_city_district`
VALUES (441621, 4416, '紫金县');
INSERT INTO `province_city_district`
VALUES (441622, 4416, '龙川县');
INSERT INTO `province_city_district`
VALUES (441623, 4416, '连平县');
INSERT INTO `province_city_district`
VALUES (441624, 4416, '和平县');
INSERT INTO `province_city_district`
VALUES (441625, 4416, '东源县');
INSERT INTO `province_city_district`
VALUES (441701, 4417, '市辖区');
INSERT INTO `province_city_district`
VALUES (441702, 4417, '江城区');
INSERT INTO `province_city_district`
VALUES (441721, 4417, '阳西县');
INSERT INTO `province_city_district`
VALUES (441723, 4417, '阳东县');
INSERT INTO `province_city_district`
VALUES (441781, 4417, '阳春市');
INSERT INTO `province_city_district`
VALUES (441801, 4418, '市辖区');
INSERT INTO `province_city_district`
VALUES (441802, 4418, '清城区');
INSERT INTO `province_city_district`
VALUES (441821, 4418, '佛冈县');
INSERT INTO `province_city_district`
VALUES (441823, 4418, '阳山县');
INSERT INTO `province_city_district`
VALUES (441825, 4418, '连山壮族瑶族自治县');
INSERT INTO `province_city_district`
VALUES (441826, 4418, '连南瑶族自治县');
INSERT INTO `province_city_district`
VALUES (441827, 4418, '清新县');
INSERT INTO `province_city_district`
VALUES (441881, 4418, '英德市');
INSERT INTO `province_city_district`
VALUES (441882, 4418, '连州市');
INSERT INTO `province_city_district`
VALUES (441901, 4419, '莞城区');
INSERT INTO `province_city_district`
VALUES (441902, 4419, '东城区');
INSERT INTO `province_city_district`
VALUES (441903, 4419, '南城区');
INSERT INTO `province_city_district`
VALUES (441904, 4419, '万江区');
INSERT INTO `province_city_district`
VALUES (442001, 4420, '石岐区');
INSERT INTO `province_city_district`
VALUES (442002, 4420, '东区');
INSERT INTO `province_city_district`
VALUES (442003, 4420, '西区');
INSERT INTO `province_city_district`
VALUES (442004, 4420, '南区');
INSERT INTO `province_city_district`
VALUES (442005, 4420, '五桂山');
INSERT INTO `province_city_district`
VALUES (445101, 4451, '市辖区');
INSERT INTO `province_city_district`
VALUES (445102, 4451, '湘桥区');
INSERT INTO `province_city_district`
VALUES (445121, 4451, '潮安县');
INSERT INTO `province_city_district`
VALUES (445122, 4451, '饶平县');
INSERT INTO `province_city_district`
VALUES (445201, 4452, '市辖区');
INSERT INTO `province_city_district`
VALUES (445202, 4452, '榕城区');
INSERT INTO `province_city_district`
VALUES (445221, 4452, '揭东县');
INSERT INTO `province_city_district`
VALUES (445222, 4452, '揭西县');
INSERT INTO `province_city_district`
VALUES (445224, 4452, '惠来县');
INSERT INTO `province_city_district`
VALUES (445281, 4452, '普宁市');
INSERT INTO `province_city_district`
VALUES (445301, 4453, '市辖区');
INSERT INTO `province_city_district`
VALUES (445302, 4453, '云城区');
INSERT INTO `province_city_district`
VALUES (445321, 4453, '新兴县');
INSERT INTO `province_city_district`
VALUES (445322, 4453, '郁南县');
INSERT INTO `province_city_district`
VALUES (445323, 4453, '云安县');
INSERT INTO `province_city_district`
VALUES (445381, 4453, '罗定市');
INSERT INTO `province_city_district`
VALUES (450101, 4501, '市辖区');
INSERT INTO `province_city_district`
VALUES (450102, 4501, '兴宁区');
INSERT INTO `province_city_district`
VALUES (450103, 4501, '新城区');
INSERT INTO `province_city_district`
VALUES (450104, 4501, '城北区');
INSERT INTO `province_city_district`
VALUES (450105, 4501, '江南区');
INSERT INTO `province_city_district`
VALUES (450106, 4501, '永新区');
INSERT INTO `province_city_district`
VALUES (450111, 4501, '市郊区');
INSERT INTO `province_city_district`
VALUES (450121, 4501, '邕宁县');
INSERT INTO `province_city_district`
VALUES (450122, 4501, '武鸣县');
INSERT INTO `province_city_district`
VALUES (450201, 4502, '市辖区');
INSERT INTO `province_city_district`
VALUES (450202, 4502, '城中区');
INSERT INTO `province_city_district`
VALUES (450203, 4502, '鱼峰区');
INSERT INTO `province_city_district`
VALUES (450204, 4502, '柳南区');
INSERT INTO `province_city_district`
VALUES (450205, 4502, '柳北区');
INSERT INTO `province_city_district`
VALUES (450211, 4502, '市郊区');
INSERT INTO `province_city_district`
VALUES (450221, 4502, '柳江县');
INSERT INTO `province_city_district`
VALUES (450222, 4502, '柳城县');
INSERT INTO `province_city_district`
VALUES (450301, 4503, '市辖区');
INSERT INTO `province_city_district`
VALUES (450302, 4503, '秀峰区');
INSERT INTO `province_city_district`
VALUES (450303, 4503, '叠彩区');
INSERT INTO `province_city_district`
VALUES (450304, 4503, '象山区');
INSERT INTO `province_city_district`
VALUES (450305, 4503, '七星区');
INSERT INTO `province_city_district`
VALUES (450311, 4503, '雁山区');
INSERT INTO `province_city_district`
VALUES (450321, 4503, '阳朔县');
INSERT INTO `province_city_district`
VALUES (450322, 4503, '临桂县');
INSERT INTO `province_city_district`
VALUES (450323, 4503, '灵川县');
INSERT INTO `province_city_district`
VALUES (450324, 4503, '全州县');
INSERT INTO `province_city_district`
VALUES (450325, 4503, '兴安县');
INSERT INTO `province_city_district`
VALUES (450326, 4503, '永福县');
INSERT INTO `province_city_district`
VALUES (450327, 4503, '灌阳县');
INSERT INTO `province_city_district`
VALUES (450328, 4503, '龙胜各县自治区');
INSERT INTO `province_city_district`
VALUES (450329, 4503, '资源县');
INSERT INTO `province_city_district`
VALUES (450330, 4503, '平乐县');
INSERT INTO `province_city_district`
VALUES (450331, 4503, '荔蒲县');
INSERT INTO `province_city_district`
VALUES (450332, 4503, '恭城瑶族自治县');
INSERT INTO `province_city_district`
VALUES (450401, 4504, '市辖区');
INSERT INTO `province_city_district`
VALUES (450403, 4504, '万秀区');
INSERT INTO `province_city_district`
VALUES (450404, 4504, '蝶山区');
INSERT INTO `province_city_district`
VALUES (450411, 4504, '市郊区');
INSERT INTO `province_city_district`
VALUES (450421, 4504, '苍梧县');
INSERT INTO `province_city_district`
VALUES (450422, 4504, '藤  县');
INSERT INTO `province_city_district`
VALUES (450423, 4504, '蒙山县');
INSERT INTO `province_city_district`
VALUES (450481, 4504, '岑溪市');
INSERT INTO `province_city_district`
VALUES (450501, 4505, '市辖区');
INSERT INTO `province_city_district`
VALUES (450502, 4505, '海城区');
INSERT INTO `province_city_district`
VALUES (450503, 4505, '银海区');
INSERT INTO `province_city_district`
VALUES (450512, 4505, '铁山港区');
INSERT INTO `province_city_district`
VALUES (450521, 4505, '合浦县');
INSERT INTO `province_city_district`
VALUES (450601, 4506, '市辖区');
INSERT INTO `province_city_district`
VALUES (450602, 4506, '港口区');
INSERT INTO `province_city_district`
VALUES (450603, 4506, '防城区');
INSERT INTO `province_city_district`
VALUES (450621, 4506, '上思县');
INSERT INTO `province_city_district`
VALUES (450681, 4506, '东兴市');
INSERT INTO `province_city_district`
VALUES (450701, 4507, '市辖区');
INSERT INTO `province_city_district`
VALUES (450702, 4507, '钦南区');
INSERT INTO `province_city_district`
VALUES (450703, 4507, '钦北区');
INSERT INTO `province_city_district`
VALUES (450721, 4507, '浦北县');
INSERT INTO `province_city_district`
VALUES (450722, 4507, '灵山县');
INSERT INTO `province_city_district`
VALUES (450801, 4508, '市辖区');
INSERT INTO `province_city_district`
VALUES (450802, 4508, '港北区');
INSERT INTO `province_city_district`
VALUES (450803, 4508, '港南区');
INSERT INTO `province_city_district`
VALUES (450821, 4508, '平南县');
INSERT INTO `province_city_district`
VALUES (450881, 4508, '桂平市');
INSERT INTO `province_city_district`
VALUES (450901, 4509, '市辖区');
INSERT INTO `province_city_district`
VALUES (450902, 4509, '玉州区');
INSERT INTO `province_city_district`
VALUES (450921, 4509, '容  县');
INSERT INTO `province_city_district`
VALUES (450922, 4509, '陆川县');
INSERT INTO `province_city_district`
VALUES (450923, 4509, '博白县');
INSERT INTO `province_city_district`
VALUES (450924, 4509, '兴业县');
INSERT INTO `province_city_district`
VALUES (450981, 4509, '北流市');
INSERT INTO `province_city_district`
VALUES (452101, 4521, '凭祥市');
INSERT INTO `province_city_district`
VALUES (452122, 4521, '横  县');
INSERT INTO `province_city_district`
VALUES (452123, 4521, '宾阳县');
INSERT INTO `province_city_district`
VALUES (452124, 4521, '上林县');
INSERT INTO `province_city_district`
VALUES (452126, 4521, '隆安县');
INSERT INTO `province_city_district`
VALUES (452127, 4521, '马山县');
INSERT INTO `province_city_district`
VALUES (452128, 4521, '扶绥县');
INSERT INTO `province_city_district`
VALUES (452129, 4521, '崇左县');
INSERT INTO `province_city_district`
VALUES (452130, 4521, '大新县');
INSERT INTO `province_city_district`
VALUES (452131, 4521, '天等县');
INSERT INTO `province_city_district`
VALUES (452132, 4521, '宁明县');
INSERT INTO `province_city_district`
VALUES (452133, 4521, '龙州县');
INSERT INTO `province_city_district`
VALUES (452201, 4522, '合山市');
INSERT INTO `province_city_district`
VALUES (452223, 4522, '鹿寨县');
INSERT INTO `province_city_district`
VALUES (452224, 4522, '象州县');
INSERT INTO `province_city_district`
VALUES (452225, 4522, '武宣县');
INSERT INTO `province_city_district`
VALUES (452226, 4522, '来宾县');
INSERT INTO `province_city_district`
VALUES (452227, 4522, '融安县');
INSERT INTO `province_city_district`
VALUES (452228, 4522, '三江侗族自治县');
INSERT INTO `province_city_district`
VALUES (452229, 4522, '融水苗族自治县');
INSERT INTO `province_city_district`
VALUES (452230, 4522, '金秀瑶族自治县');
INSERT INTO `province_city_district`
VALUES (452231, 4522, '忻城县');
INSERT INTO `province_city_district`
VALUES (452402, 4524, '贺州市');
INSERT INTO `province_city_district`
VALUES (452424, 4524, '昭平县');
INSERT INTO `province_city_district`
VALUES (452427, 4524, '钟山县');
INSERT INTO `province_city_district`
VALUES (452428, 4524, '富川瑶族自治县');
INSERT INTO `province_city_district`
VALUES (452601, 4526, '百色市');
INSERT INTO `province_city_district`
VALUES (452622, 4526, '田阳县');
INSERT INTO `province_city_district`
VALUES (452623, 4526, '田东县');
INSERT INTO `province_city_district`
VALUES (452624, 4526, '平果县');
INSERT INTO `province_city_district`
VALUES (452625, 4526, '德保县');
INSERT INTO `province_city_district`
VALUES (452626, 4526, '靖西县');
INSERT INTO `province_city_district`
VALUES (452627, 4526, '那坡县');
INSERT INTO `province_city_district`
VALUES (452628, 4526, '凌云县');
INSERT INTO `province_city_district`
VALUES (452629, 4526, '乐业县');
INSERT INTO `province_city_district`
VALUES (452630, 4526, '田林县');
INSERT INTO `province_city_district`
VALUES (452631, 4526, '隆林各族自治县');
INSERT INTO `province_city_district`
VALUES (452632, 4526, '西林县');
INSERT INTO `province_city_district`
VALUES (452701, 4527, '河池市');
INSERT INTO `province_city_district`
VALUES (452702, 4527, '宜州市');
INSERT INTO `province_city_district`
VALUES (452723, 4527, '罗城仫佬族自治县');
INSERT INTO `province_city_district`
VALUES (452724, 4527, '环江毛南族自治县');
INSERT INTO `province_city_district`
VALUES (452725, 4527, '南丹县');
INSERT INTO `province_city_district`
VALUES (452726, 4527, '天峨县');
INSERT INTO `province_city_district`
VALUES (452727, 4527, '凤山县');
INSERT INTO `province_city_district`
VALUES (452728, 4527, '东兰县');
INSERT INTO `province_city_district`
VALUES (452729, 4527, '巴马瑶族自治县');
INSERT INTO `province_city_district`
VALUES (452730, 4527, '都安瑶族自治县');
INSERT INTO `province_city_district`
VALUES (452731, 4527, '大化瑶族自治县');
INSERT INTO `province_city_district`
VALUES (460101, 4601, '通什市');
INSERT INTO `province_city_district`
VALUES (460102, 4601, '琼海市');
INSERT INTO `province_city_district`
VALUES (460103, 4601, '儋州市');
INSERT INTO `province_city_district`
VALUES (460104, 4601, '琼山市');
INSERT INTO `province_city_district`
VALUES (460105, 4601, '文昌市');
INSERT INTO `province_city_district`
VALUES (460106, 4601, '万宁市');
INSERT INTO `province_city_district`
VALUES (460107, 4601, '东方市');
INSERT INTO `province_city_district`
VALUES (460125, 4601, '定安县');
INSERT INTO `province_city_district`
VALUES (460126, 4601, '屯昌县');
INSERT INTO `province_city_district`
VALUES (460127, 4601, '澄迈县');
INSERT INTO `province_city_district`
VALUES (460128, 4601, '临高县');
INSERT INTO `province_city_district`
VALUES (460130, 4601, '白沙黎族自治县');
INSERT INTO `province_city_district`
VALUES (460131, 4601, '昌江黎族自治县');
INSERT INTO `province_city_district`
VALUES (460133, 4601, '乐东黎族自治县');
INSERT INTO `province_city_district`
VALUES (460134, 4601, '陵水黎族自治县');
INSERT INTO `province_city_district`
VALUES (460135, 4601, '保亭黎族苗族自治县');
INSERT INTO `province_city_district`
VALUES (460136, 4601, '琼中黎族苗族自治县');
INSERT INTO `province_city_district`
VALUES (460137, 4601, '西沙群岛');
INSERT INTO `province_city_district`
VALUES (460138, 4601, '南沙群岛');
INSERT INTO `province_city_district`
VALUES (460139, 4601, '中沙群岛的岛礁及其海');
INSERT INTO `province_city_district`
VALUES (460201, 4602, '市辖区');
INSERT INTO `province_city_district`
VALUES (460202, 4602, '振东区');
INSERT INTO `province_city_district`
VALUES (460203, 4602, '新华区');
INSERT INTO `province_city_district`
VALUES (460204, 4602, '秀英区');
INSERT INTO `province_city_district`
VALUES (460301, 4603, '市辖区');
INSERT INTO `province_city_district`
VALUES (500101, 5001, '万州区');
INSERT INTO `province_city_district`
VALUES (500102, 5001, '涪陵区');
INSERT INTO `province_city_district`
VALUES (500103, 5001, '渝中区');
INSERT INTO `province_city_district`
VALUES (500104, 5001, '大渡口区');
INSERT INTO `province_city_district`
VALUES (500105, 5001, '江北区');
INSERT INTO `province_city_district`
VALUES (500106, 5001, '沙坪坝区');
INSERT INTO `province_city_district`
VALUES (500107, 5001, '九龙坡区');
INSERT INTO `province_city_district`
VALUES (500108, 5001, '南岸区');
INSERT INTO `province_city_district`
VALUES (500109, 5001, '北碚区');
INSERT INTO `province_city_district`
VALUES (500110, 5001, '万盛区');
INSERT INTO `province_city_district`
VALUES (500111, 5001, '双桥区');
INSERT INTO `province_city_district`
VALUES (500112, 5001, '渝北区');
INSERT INTO `province_city_district`
VALUES (500113, 5001, '巴南区');
INSERT INTO `province_city_district`
VALUES (500114, 5001, '黔江区');
INSERT INTO `province_city_district`
VALUES (500221, 5002, '长寿县');
INSERT INTO `province_city_district`
VALUES (500222, 5002, '綦江县');
INSERT INTO `province_city_district`
VALUES (500223, 5002, '潼南县');
INSERT INTO `province_city_district`
VALUES (500224, 5002, '铜梁县');
INSERT INTO `province_city_district`
VALUES (500225, 5002, '大足县');
INSERT INTO `province_city_district`
VALUES (500226, 5002, '荣昌县');
INSERT INTO `province_city_district`
VALUES (500227, 5002, '璧山县');
INSERT INTO `province_city_district`
VALUES (500228, 5002, '梁平县');
INSERT INTO `province_city_district`
VALUES (500229, 5002, '城口县');
INSERT INTO `province_city_district`
VALUES (500230, 5002, '丰都县');
INSERT INTO `province_city_district`
VALUES (500231, 5002, '垫江县');
INSERT INTO `province_city_district`
VALUES (500232, 5002, '武隆县');
INSERT INTO `province_city_district`
VALUES (500233, 5002, '忠  县');
INSERT INTO `province_city_district`
VALUES (500234, 5002, '开  县');
INSERT INTO `province_city_district`
VALUES (500235, 5002, '云阳县');
INSERT INTO `province_city_district`
VALUES (500236, 5002, '奉节县');
INSERT INTO `province_city_district`
VALUES (500237, 5002, '巫山县');
INSERT INTO `province_city_district`
VALUES (500238, 5002, '巫溪县');
INSERT INTO `province_city_district`
VALUES (500240, 5002, '石柱土家族自治县');
INSERT INTO `province_city_district`
VALUES (500241, 5002, '秀山土家族苗族自治县');
INSERT INTO `province_city_district`
VALUES (500242, 5002, '酉阳土家族苗族自治县');
INSERT INTO `province_city_district`
VALUES (500243, 5002, '彭水苗族土家族自治县');
INSERT INTO `province_city_district`
VALUES (500381, 5003, '江津市');
INSERT INTO `province_city_district`
VALUES (500382, 5003, '合川市');
INSERT INTO `province_city_district`
VALUES (500383, 5003, '永川市');
INSERT INTO `province_city_district`
VALUES (500384, 5003, '南川市');
INSERT INTO `province_city_district`
VALUES (510101, 5101, '市辖区');
INSERT INTO `province_city_district`
VALUES (510103, 5101, '高新区');
INSERT INTO `province_city_district`
VALUES (510104, 5101, '锦江区');
INSERT INTO `province_city_district`
VALUES (510105, 5101, '青羊区');
INSERT INTO `province_city_district`
VALUES (510106, 5101, '金牛区');
INSERT INTO `province_city_district`
VALUES (510107, 5101, '武侯区');
INSERT INTO `province_city_district`
VALUES (510108, 5101, '成华区');
INSERT INTO `province_city_district`
VALUES (510112, 5101, '龙泉驿区');
INSERT INTO `province_city_district`
VALUES (510113, 5101, '青白江区');
INSERT INTO `province_city_district`
VALUES (510121, 5101, '金堂县');
INSERT INTO `province_city_district`
VALUES (510122, 5101, '双流县');
INSERT INTO `province_city_district`
VALUES (510123, 5101, '温江县');
INSERT INTO `province_city_district`
VALUES (510124, 5101, '郫  县');
INSERT INTO `province_city_district`
VALUES (510125, 5101, '新都县');
INSERT INTO `province_city_district`
VALUES (510129, 5101, '大邑县');
INSERT INTO `province_city_district`
VALUES (510131, 5101, '蒲江县');
INSERT INTO `province_city_district`
VALUES (510132, 5101, '新津县');
INSERT INTO `province_city_district`
VALUES (510181, 5101, '都江堰市');
INSERT INTO `province_city_district`
VALUES (510182, 5101, '彭州市');
INSERT INTO `province_city_district`
VALUES (510183, 5101, '邛崃市');
INSERT INTO `province_city_district`
VALUES (510184, 5101, '崇州市');
INSERT INTO `province_city_district`
VALUES (510301, 5103, '市辖区');
INSERT INTO `province_city_district`
VALUES (510302, 5103, '自流井区');
INSERT INTO `province_city_district`
VALUES (510303, 5103, '贡井区');
INSERT INTO `province_city_district`
VALUES (510304, 5103, '大安区');
INSERT INTO `province_city_district`
VALUES (510311, 5103, '沿滩区');
INSERT INTO `province_city_district`
VALUES (510321, 5103, '荣  县');
INSERT INTO `province_city_district`
VALUES (510322, 5103, '富顺县');
INSERT INTO `province_city_district`
VALUES (510401, 5104, '市辖区');
INSERT INTO `province_city_district`
VALUES (510402, 5104, '东  区');
INSERT INTO `province_city_district`
VALUES (510403, 5104, '西  区');
INSERT INTO `province_city_district`
VALUES (510411, 5104, '仁和区');
INSERT INTO `province_city_district`
VALUES (510421, 5104, '米易县');
INSERT INTO `province_city_district`
VALUES (510422, 5104, '盐边县');
INSERT INTO `province_city_district`
VALUES (510501, 5105, '市辖区');
INSERT INTO `province_city_district`
VALUES (510502, 5105, '江阳区');
INSERT INTO `province_city_district`
VALUES (510503, 5105, '纳溪区');
INSERT INTO `province_city_district`
VALUES (510504, 5105, '龙马潭区');
INSERT INTO `province_city_district`
VALUES (510521, 5105, '泸  县');
INSERT INTO `province_city_district`
VALUES (510522, 5105, '合江县');
INSERT INTO `province_city_district`
VALUES (510524, 5105, '叙永县');
INSERT INTO `province_city_district`
VALUES (510525, 5105, '古蔺县');
INSERT INTO `province_city_district`
VALUES (510601, 5106, '市辖区');
INSERT INTO `province_city_district`
VALUES (510603, 5106, '旌阳区');
INSERT INTO `province_city_district`
VALUES (510623, 5106, '中江县');
INSERT INTO `province_city_district`
VALUES (510626, 5106, '罗江县');
INSERT INTO `province_city_district`
VALUES (510681, 5106, '广汉市');
INSERT INTO `province_city_district`
VALUES (510682, 5106, '什邡市');
INSERT INTO `province_city_district`
VALUES (510683, 5106, '绵竹市');
INSERT INTO `province_city_district`
VALUES (510701, 5107, '市辖区');
INSERT INTO `province_city_district`
VALUES (510703, 5107, '涪城区');
INSERT INTO `province_city_district`
VALUES (510704, 5107, '游仙区');
INSERT INTO `province_city_district`
VALUES (510710, 5107, '科学城区');
INSERT INTO `province_city_district`
VALUES (510722, 5107, '三台县');
INSERT INTO `province_city_district`
VALUES (510723, 5107, '盐亭县');
INSERT INTO `province_city_district`
VALUES (510724, 5107, '安  县');
INSERT INTO `province_city_district`
VALUES (510725, 5107, '梓潼县');
INSERT INTO `province_city_district`
VALUES (510726, 5107, '北川县');
INSERT INTO `province_city_district`
VALUES (510727, 5107, '平武县');
INSERT INTO `province_city_district`
VALUES (510781, 5107, '江油市');
INSERT INTO `province_city_district`
VALUES (510801, 5108, '市辖区');
INSERT INTO `province_city_district`
VALUES (510802, 5108, '市中区');
INSERT INTO `province_city_district`
VALUES (510811, 5108, '元坝区');
INSERT INTO `province_city_district`
VALUES (510812, 5108, '朝天区');
INSERT INTO `province_city_district`
VALUES (510821, 5108, '旺苍县');
INSERT INTO `province_city_district`
VALUES (510822, 5108, '青川县');
INSERT INTO `province_city_district`
VALUES (510823, 5108, '剑阁县');
INSERT INTO `province_city_district`
VALUES (510824, 5108, '苍溪县');
INSERT INTO `province_city_district`
VALUES (510901, 5109, '市辖区');
INSERT INTO `province_city_district`
VALUES (510902, 5109, '市中区');
INSERT INTO `province_city_district`
VALUES (510921, 5109, '蓬溪县');
INSERT INTO `province_city_district`
VALUES (510922, 5109, '射洪县');
INSERT INTO `province_city_district`
VALUES (510923, 5109, '大英县');
INSERT INTO `province_city_district`
VALUES (511001, 5110, '市辖区');
INSERT INTO `province_city_district`
VALUES (511002, 5110, '市中区');
INSERT INTO `province_city_district`
VALUES (511011, 5110, '东兴区');
INSERT INTO `province_city_district`
VALUES (511024, 5110, '威远县');
INSERT INTO `province_city_district`
VALUES (511025, 5110, '资中县');
INSERT INTO `province_city_district`
VALUES (511028, 5110, '隆昌县');
INSERT INTO `province_city_district`
VALUES (511101, 5111, '市辖区');
INSERT INTO `province_city_district`
VALUES (511102, 5111, '市中区');
INSERT INTO `province_city_district`
VALUES (511111, 5111, '沙湾区');
INSERT INTO `province_city_district`
VALUES (511112, 5111, '五通桥区');
INSERT INTO `province_city_district`
VALUES (511113, 5111, '金口河区');
INSERT INTO `province_city_district`
VALUES (511123, 5111, '犍为县');
INSERT INTO `province_city_district`
VALUES (511124, 5111, '井研县');
INSERT INTO `province_city_district`
VALUES (511126, 5111, '夹江县');
INSERT INTO `province_city_district`
VALUES (511129, 5111, '沐川县');
INSERT INTO `province_city_district`
VALUES (511132, 5111, '峨边彝族自治县');
INSERT INTO `province_city_district`
VALUES (511133, 5111, '马边彝族自治县');
INSERT INTO `province_city_district`
VALUES (511181, 5111, '峨眉山市');
INSERT INTO `province_city_district`
VALUES (511301, 5113, '市辖区');
INSERT INTO `province_city_district`
VALUES (511302, 5113, '顺庆区');
INSERT INTO `province_city_district`
VALUES (511303, 5113, '高坪区');
INSERT INTO `province_city_district`
VALUES (511304, 5113, '嘉陵区');
INSERT INTO `province_city_district`
VALUES (511321, 5113, '南部县');
INSERT INTO `province_city_district`
VALUES (511322, 5113, '营山县');
INSERT INTO `province_city_district`
VALUES (511323, 5113, '蓬安县');
INSERT INTO `province_city_district`
VALUES (511324, 5113, '仪陇县');
INSERT INTO `province_city_district`
VALUES (511325, 5113, '西充县');
INSERT INTO `province_city_district`
VALUES (511381, 5113, '阆中市');
INSERT INTO `province_city_district`
VALUES (511401, 5114, '市辖区');
INSERT INTO `province_city_district`
VALUES (511402, 5114, '东坡区');
INSERT INTO `province_city_district`
VALUES (511421, 5114, '仁寿县');
INSERT INTO `province_city_district`
VALUES (511422, 5114, '彭山县');
INSERT INTO `province_city_district`
VALUES (511423, 5114, '洪雅县');
INSERT INTO `province_city_district`
VALUES (511424, 5114, '丹棱县');
INSERT INTO `province_city_district`
VALUES (511425, 5114, '青神县');
INSERT INTO `province_city_district`
VALUES (511501, 5115, '市辖区');
INSERT INTO `province_city_district`
VALUES (511502, 5115, '翠屏区');
INSERT INTO `province_city_district`
VALUES (511521, 5115, '宜宾县');
INSERT INTO `province_city_district`
VALUES (511522, 5115, '南溪县');
INSERT INTO `province_city_district`
VALUES (511523, 5115, '江安县');
INSERT INTO `province_city_district`
VALUES (511524, 5115, '长宁县');
INSERT INTO `province_city_district`
VALUES (511525, 5115, '高  县');
INSERT INTO `province_city_district`
VALUES (511526, 5115, '珙  县');
INSERT INTO `province_city_district`
VALUES (511527, 5115, '筠连县');
INSERT INTO `province_city_district`
VALUES (511528, 5115, '兴文县');
INSERT INTO `province_city_district`
VALUES (511529, 5115, '屏山县');
INSERT INTO `province_city_district`
VALUES (511601, 5116, '市辖区');
INSERT INTO `province_city_district`
VALUES (511602, 5116, '广安区');
INSERT INTO `province_city_district`
VALUES (511621, 5116, '岳池县');
INSERT INTO `province_city_district`
VALUES (511622, 5116, '武胜县');
INSERT INTO `province_city_district`
VALUES (511623, 5116, '邻水县');
INSERT INTO `province_city_district`
VALUES (511681, 5116, '华蓥市');
INSERT INTO `province_city_district`
VALUES (511701, 5117, '市辖区');
INSERT INTO `province_city_district`
VALUES (511702, 5117, '通川区');
INSERT INTO `province_city_district`
VALUES (511721, 5117, '达  县');
INSERT INTO `province_city_district`
VALUES (511722, 5117, '宣汉县');
INSERT INTO `province_city_district`
VALUES (511723, 5117, '开江县');
INSERT INTO `province_city_district`
VALUES (511724, 5117, '大竹县');
INSERT INTO `province_city_district`
VALUES (511725, 5117, '渠  县');
INSERT INTO `province_city_district`
VALUES (511781, 5117, '万源市');
INSERT INTO `province_city_district`
VALUES (511801, 5118, '市辖区');
INSERT INTO `province_city_district`
VALUES (511802, 5118, '雨城区');
INSERT INTO `province_city_district`
VALUES (511821, 5118, '名山县');
INSERT INTO `province_city_district`
VALUES (511822, 5118, '荥经县');
INSERT INTO `province_city_district`
VALUES (511823, 5118, '汉源县');
INSERT INTO `province_city_district`
VALUES (511824, 5118, '石棉县');
INSERT INTO `province_city_district`
VALUES (511825, 5118, '天全县');
INSERT INTO `province_city_district`
VALUES (511826, 5118, '芦山县');
INSERT INTO `province_city_district`
VALUES (511827, 5118, '宝兴县');
INSERT INTO `province_city_district`
VALUES (511901, 5119, '市辖区');
INSERT INTO `province_city_district`
VALUES (511902, 5119, '巴州区');
INSERT INTO `province_city_district`
VALUES (511921, 5119, '通江县');
INSERT INTO `province_city_district`
VALUES (511922, 5119, '南江县');
INSERT INTO `province_city_district`
VALUES (511923, 5119, '平昌县');
INSERT INTO `province_city_district`
VALUES (512001, 5120, '市辖区');
INSERT INTO `province_city_district`
VALUES (512002, 5120, '雁江区');
INSERT INTO `province_city_district`
VALUES (512021, 5120, '安岳县');
INSERT INTO `province_city_district`
VALUES (512022, 5120, '乐至县');
INSERT INTO `province_city_district`
VALUES (512081, 5120, '简阳市');
INSERT INTO `province_city_district`
VALUES (513221, 5132, '汶川县');
INSERT INTO `province_city_district`
VALUES (513222, 5132, '理  县');
INSERT INTO `province_city_district`
VALUES (513223, 5132, '茂  县');
INSERT INTO `province_city_district`
VALUES (513224, 5132, '松潘县');
INSERT INTO `province_city_district`
VALUES (513225, 5132, '九寨沟县');
INSERT INTO `province_city_district`
VALUES (513226, 5132, '金川县');
INSERT INTO `province_city_district`
VALUES (513227, 5132, '小金县');
INSERT INTO `province_city_district`
VALUES (513228, 5132, '黑水县');
INSERT INTO `province_city_district`
VALUES (513229, 5132, '马尔康县');
INSERT INTO `province_city_district`
VALUES (513230, 5132, '壤塘县');
INSERT INTO `province_city_district`
VALUES (513231, 5132, '阿坝县');
INSERT INTO `province_city_district`
VALUES (513232, 5132, '若尔盖县');
INSERT INTO `province_city_district`
VALUES (513233, 5132, '红原县');
INSERT INTO `province_city_district`
VALUES (513321, 5133, '康定县');
INSERT INTO `province_city_district`
VALUES (513322, 5133, '泸定县');
INSERT INTO `province_city_district`
VALUES (513323, 5133, '丹巴县');
INSERT INTO `province_city_district`
VALUES (513324, 5133, '九龙县');
INSERT INTO `province_city_district`
VALUES (513325, 5133, '雅江县');
INSERT INTO `province_city_district`
VALUES (513326, 5133, '道孚县');
INSERT INTO `province_city_district`
VALUES (513327, 5133, '炉霍县');
INSERT INTO `province_city_district`
VALUES (513328, 5133, '甘孜县');
INSERT INTO `province_city_district`
VALUES (513329, 5133, '新龙县');
INSERT INTO `province_city_district`
VALUES (513330, 5133, '德格县');
INSERT INTO `province_city_district`
VALUES (513331, 5133, '白玉县');
INSERT INTO `province_city_district`
VALUES (513332, 5133, '石渠县');
INSERT INTO `province_city_district`
VALUES (513333, 5133, '色达县');
INSERT INTO `province_city_district`
VALUES (513334, 5133, '理塘县');
INSERT INTO `province_city_district`
VALUES (513335, 5133, '巴塘县');
INSERT INTO `province_city_district`
VALUES (513336, 5133, '乡城县');
INSERT INTO `province_city_district`
VALUES (513337, 5133, '稻城县');
INSERT INTO `province_city_district`
VALUES (513338, 5133, '得荣县');
INSERT INTO `province_city_district`
VALUES (513401, 5134, '西昌市');
INSERT INTO `province_city_district`
VALUES (513422, 5134, '木里藏族自治县');
INSERT INTO `province_city_district`
VALUES (513423, 5134, '盐源县');
INSERT INTO `province_city_district`
VALUES (513424, 5134, '德昌县');
INSERT INTO `province_city_district`
VALUES (513425, 5134, '会理县');
INSERT INTO `province_city_district`
VALUES (513426, 5134, '会东县');
INSERT INTO `province_city_district`
VALUES (513427, 5134, '宁南县');
INSERT INTO `province_city_district`
VALUES (513428, 5134, '普格县');
INSERT INTO `province_city_district`
VALUES (513429, 5134, '布拖县');
INSERT INTO `province_city_district`
VALUES (513430, 5134, '金阳县');
INSERT INTO `province_city_district`
VALUES (513431, 5134, '昭觉县');
INSERT INTO `province_city_district`
VALUES (513432, 5134, '喜德县');
INSERT INTO `province_city_district`
VALUES (513433, 5134, '冕宁县');
INSERT INTO `province_city_district`
VALUES (513434, 5134, '越西县');
INSERT INTO `province_city_district`
VALUES (513435, 5134, '甘洛县');
INSERT INTO `province_city_district`
VALUES (513436, 5134, '美姑县');
INSERT INTO `province_city_district`
VALUES (513437, 5134, '雷波县');
INSERT INTO `province_city_district`
VALUES (520101, 5201, '市辖区');
INSERT INTO `province_city_district`
VALUES (520102, 5201, '南明区');
INSERT INTO `province_city_district`
VALUES (520103, 5201, '云岩区');
INSERT INTO `province_city_district`
VALUES (520111, 5201, '花溪区');
INSERT INTO `province_city_district`
VALUES (520112, 5201, '乌当区');
INSERT INTO `province_city_district`
VALUES (520113, 5201, '白云区');
INSERT INTO `province_city_district`
VALUES (520114, 5201, '小河区');
INSERT INTO `province_city_district`
VALUES (520121, 5201, '开阳县');
INSERT INTO `province_city_district`
VALUES (520122, 5201, '息烽县');
INSERT INTO `province_city_district`
VALUES (520123, 5201, '修文县');
INSERT INTO `province_city_district`
VALUES (520181, 5201, '清镇市');
INSERT INTO `province_city_district`
VALUES (520201, 5202, '钟山区');
INSERT INTO `province_city_district`
VALUES (520203, 5202, '六枝特区');
INSERT INTO `province_city_district`
VALUES (520221, 5202, '水城县');
INSERT INTO `province_city_district`
VALUES (520222, 5202, '盘  县');
INSERT INTO `province_city_district`
VALUES (520301, 5203, '市辖区');
INSERT INTO `province_city_district`
VALUES (520302, 5203, '红花岗区');
INSERT INTO `province_city_district`
VALUES (520321, 5203, '遵义县');
INSERT INTO `province_city_district`
VALUES (520322, 5203, '桐梓县');
INSERT INTO `province_city_district`
VALUES (520323, 5203, '绥阳县');
INSERT INTO `province_city_district`
VALUES (520324, 5203, '正安县');
INSERT INTO `province_city_district`
VALUES (520325, 5203, '道真仡佬族苗族自治县');
INSERT INTO `province_city_district`
VALUES (520326, 5203, '务川仡佬族苗族自治县');
INSERT INTO `province_city_district`
VALUES (520327, 5203, '凤冈县');
INSERT INTO `province_city_district`
VALUES (520328, 5203, '湄潭县');
INSERT INTO `province_city_district`
VALUES (520329, 5203, '余庆县');
INSERT INTO `province_city_district`
VALUES (520330, 5203, '习水县');
INSERT INTO `province_city_district`
VALUES (520381, 5203, '赤水市');
INSERT INTO `province_city_district`
VALUES (520382, 5203, '仁怀市');
INSERT INTO `province_city_district`
VALUES (520401, 5204, '市辖区');
INSERT INTO `province_city_district`
VALUES (520402, 5204, '西秀区');
INSERT INTO `province_city_district`
VALUES (520421, 5204, '平坝县');
INSERT INTO `province_city_district`
VALUES (520422, 5204, '普定县');
INSERT INTO `province_city_district`
VALUES (520423, 5204, '镇宁布依族苗族自治县');
INSERT INTO `province_city_district`
VALUES (520424, 5204, '关岭布依族苗族自治县');
INSERT INTO `province_city_district`
VALUES (520425, 5204, '紫云苗族布依族自治县');
INSERT INTO `province_city_district`
VALUES (522201, 5222, '铜仁市');
INSERT INTO `province_city_district`
VALUES (522222, 5222, '江口县');
INSERT INTO `province_city_district`
VALUES (522223, 5222, '玉屏侗族自治县');
INSERT INTO `province_city_district`
VALUES (522224, 5222, '石阡县');
INSERT INTO `province_city_district`
VALUES (522225, 5222, '思南县');
INSERT INTO `province_city_district`
VALUES (522226, 5222, '印江土家族苗族自治县');
INSERT INTO `province_city_district`
VALUES (522227, 5222, '德江县');
INSERT INTO `province_city_district`
VALUES (522228, 5222, '沿河土家族自治县');
INSERT INTO `province_city_district`
VALUES (522229, 5222, '松桃苗族自治县');
INSERT INTO `province_city_district`
VALUES (522230, 5222, '万山特区');
INSERT INTO `province_city_district`
VALUES (522301, 5223, '兴义市');
INSERT INTO `province_city_district`
VALUES (522322, 5223, '兴仁县');
INSERT INTO `province_city_district`
VALUES (522323, 5223, '普安县');
INSERT INTO `province_city_district`
VALUES (522324, 5223, '晴隆县');
INSERT INTO `province_city_district`
VALUES (522325, 5223, '贞丰县');
INSERT INTO `province_city_district`
VALUES (522326, 5223, '望谟县');
INSERT INTO `province_city_district`
VALUES (522327, 5223, '册亨县');
INSERT INTO `province_city_district`
VALUES (522328, 5223, '安龙县');
INSERT INTO `province_city_district`
VALUES (522401, 5224, '毕节市');
INSERT INTO `province_city_district`
VALUES (522422, 5224, '大方县');
INSERT INTO `province_city_district`
VALUES (522423, 5224, '黔西县');
INSERT INTO `province_city_district`
VALUES (522424, 5224, '金沙县');
INSERT INTO `province_city_district`
VALUES (522425, 5224, '织金县');
INSERT INTO `province_city_district`
VALUES (522426, 5224, '纳雍县');
INSERT INTO `province_city_district`
VALUES (522427, 5224, '威宁彝族回族苗族自治');
INSERT INTO `province_city_district`
VALUES (522428, 5224, '赫章县');
INSERT INTO `province_city_district`
VALUES (522601, 5226, '凯里市');
INSERT INTO `province_city_district`
VALUES (522622, 5226, '黄平县');
INSERT INTO `province_city_district`
VALUES (522623, 5226, '施秉县');
INSERT INTO `province_city_district`
VALUES (522624, 5226, '三穗县');
INSERT INTO `province_city_district`
VALUES (522625, 5226, '镇远县');
INSERT INTO `province_city_district`
VALUES (522626, 5226, '岑巩县');
INSERT INTO `province_city_district`
VALUES (522627, 5226, '天柱县');
INSERT INTO `province_city_district`
VALUES (522628, 5226, '锦屏县');
INSERT INTO `province_city_district`
VALUES (522629, 5226, '剑河县');
INSERT INTO `province_city_district`
VALUES (522630, 5226, '台江县');
INSERT INTO `province_city_district`
VALUES (522631, 5226, '黎平县');
INSERT INTO `province_city_district`
VALUES (522632, 5226, '榕江县');
INSERT INTO `province_city_district`
VALUES (522633, 5226, '从江县');
INSERT INTO `province_city_district`
VALUES (522634, 5226, '雷山县');
INSERT INTO `province_city_district`
VALUES (522635, 5226, '麻江县');
INSERT INTO `province_city_district`
VALUES (522636, 5226, '丹寨县');
INSERT INTO `province_city_district`
VALUES (522701, 5227, '都匀市');
INSERT INTO `province_city_district`
VALUES (522702, 5227, '福泉市');
INSERT INTO `province_city_district`
VALUES (522722, 5227, '荔波县');
INSERT INTO `province_city_district`
VALUES (522723, 5227, '贵定县');
INSERT INTO `province_city_district`
VALUES (522725, 5227, '瓮安县');
INSERT INTO `province_city_district`
VALUES (522726, 5227, '独山县');
INSERT INTO `province_city_district`
VALUES (522727, 5227, '平塘县');
INSERT INTO `province_city_district`
VALUES (522728, 5227, '罗甸县');
INSERT INTO `province_city_district`
VALUES (522729, 5227, '长顺县');
INSERT INTO `province_city_district`
VALUES (522730, 5227, '龙里县');
INSERT INTO `province_city_district`
VALUES (522731, 5227, '惠水县');
INSERT INTO `province_city_district`
VALUES (522732, 5227, '三都水族自治县');
INSERT INTO `province_city_district`
VALUES (530101, 5301, '市辖区');
INSERT INTO `province_city_district`
VALUES (530102, 5301, '五华区');
INSERT INTO `province_city_district`
VALUES (530103, 5301, '盘龙区');
INSERT INTO `province_city_district`
VALUES (530111, 5301, '官渡区');
INSERT INTO `province_city_district`
VALUES (530112, 5301, '西山区');
INSERT INTO `province_city_district`
VALUES (530113, 5301, '东川区');
INSERT INTO `province_city_district`
VALUES (530121, 5301, '呈贡县');
INSERT INTO `province_city_district`
VALUES (530122, 5301, '晋宁县');
INSERT INTO `province_city_district`
VALUES (530124, 5301, '富民县');
INSERT INTO `province_city_district`
VALUES (530125, 5301, '宜良县');
INSERT INTO `province_city_district`
VALUES (530126, 5301, '石林彝族自治县');
INSERT INTO `province_city_district`
VALUES (530127, 5301, '嵩明县');
INSERT INTO `province_city_district`
VALUES (530128, 5301, '禄劝彝族苗族自治县');
INSERT INTO `province_city_district`
VALUES (530129, 5301, '寻甸回族彝族自治县');
INSERT INTO `province_city_district`
VALUES (530181, 5301, '安宁市');
INSERT INTO `province_city_district`
VALUES (530301, 5303, '市辖区');
INSERT INTO `province_city_district`
VALUES (530302, 5303, '麒麟区');
INSERT INTO `province_city_district`
VALUES (530321, 5303, '马龙县');
INSERT INTO `province_city_district`
VALUES (530322, 5303, '陆良县');
INSERT INTO `province_city_district`
VALUES (530323, 5303, '师宗县');
INSERT INTO `province_city_district`
VALUES (530324, 5303, '罗平县');
INSERT INTO `province_city_district`
VALUES (530325, 5303, '富源县');
INSERT INTO `province_city_district`
VALUES (530326, 5303, '会泽县');
INSERT INTO `province_city_district`
VALUES (530328, 5303, '沾益县');
INSERT INTO `province_city_district`
VALUES (530381, 5303, '宣威市');
INSERT INTO `province_city_district`
VALUES (530401, 5304, '市辖区');
INSERT INTO `province_city_district`
VALUES (530402, 5304, '红塔区');
INSERT INTO `province_city_district`
VALUES (530421, 5304, '江川县');
INSERT INTO `province_city_district`
VALUES (530422, 5304, '澄江县');
INSERT INTO `province_city_district`
VALUES (530423, 5304, '通海县');
INSERT INTO `province_city_district`
VALUES (530424, 5304, '华宁县');
INSERT INTO `province_city_district`
VALUES (530425, 5304, '易门县');
INSERT INTO `province_city_district`
VALUES (530426, 5304, '峨山彝族自治县');
INSERT INTO `province_city_district`
VALUES (530427, 5304, '新平彝族傣族自治县');
INSERT INTO `province_city_district`
VALUES (530428, 5304, '元江哈尼族彝族傣族自');
INSERT INTO `province_city_district`
VALUES (530501, 5305, '市辖区');
INSERT INTO `province_city_district`
VALUES (530502, 5305, '隆阳区');
INSERT INTO `province_city_district`
VALUES (530521, 5305, '施甸县');
INSERT INTO `province_city_district`
VALUES (530522, 5305, '腾冲县');
INSERT INTO `province_city_district`
VALUES (530523, 5305, '龙陵县');
INSERT INTO `province_city_district`
VALUES (530524, 5305, '昌宁县');
INSERT INTO `province_city_district`
VALUES (532101, 5321, '昭通市');
INSERT INTO `province_city_district`
VALUES (532122, 5321, '鲁甸县');
INSERT INTO `province_city_district`
VALUES (532123, 5321, '巧家县');
INSERT INTO `province_city_district`
VALUES (532124, 5321, '盐津县');
INSERT INTO `province_city_district`
VALUES (532125, 5321, '大关县');
INSERT INTO `province_city_district`
VALUES (532126, 5321, '永善县');
INSERT INTO `province_city_district`
VALUES (532127, 5321, '绥江县');
INSERT INTO `province_city_district`
VALUES (532128, 5321, '镇雄县');
INSERT INTO `province_city_district`
VALUES (532129, 5321, '彝良县');
INSERT INTO `province_city_district`
VALUES (532130, 5321, '威信县');
INSERT INTO `province_city_district`
VALUES (532131, 5321, '水富县');
INSERT INTO `province_city_district`
VALUES (532301, 5323, '楚雄市');
INSERT INTO `province_city_district`
VALUES (532322, 5323, '双柏县');
INSERT INTO `province_city_district`
VALUES (532323, 5323, '牟定县');
INSERT INTO `province_city_district`
VALUES (532324, 5323, '南华县');
INSERT INTO `province_city_district`
VALUES (532325, 5323, '姚安县');
INSERT INTO `province_city_district`
VALUES (532326, 5323, '大姚县');
INSERT INTO `province_city_district`
VALUES (532327, 5323, '永仁县');
INSERT INTO `province_city_district`
VALUES (532328, 5323, '元谋县');
INSERT INTO `province_city_district`
VALUES (532329, 5323, '武定县');
INSERT INTO `province_city_district`
VALUES (532331, 5323, '禄丰县');
INSERT INTO `province_city_district`
VALUES (532501, 5325, '个旧市');
INSERT INTO `province_city_district`
VALUES (532502, 5325, '开远市');
INSERT INTO `province_city_district`
VALUES (532522, 5325, '蒙自县');
INSERT INTO `province_city_district`
VALUES (532523, 5325, '屏边苗族自治县');
INSERT INTO `province_city_district`
VALUES (532524, 5325, '建水县');
INSERT INTO `province_city_district`
VALUES (532525, 5325, '石屏县');
INSERT INTO `province_city_district`
VALUES (532526, 5325, '弥勒县');
INSERT INTO `province_city_district`
VALUES (532527, 5325, '泸西县');
INSERT INTO `province_city_district`
VALUES (532528, 5325, '元阳县');
INSERT INTO `province_city_district`
VALUES (532529, 5325, '红河县');
INSERT INTO `province_city_district`
VALUES (532530, 5325, '金平苗族瑶族傣族自治');
INSERT INTO `province_city_district`
VALUES (532531, 5325, '绿春县');
INSERT INTO `province_city_district`
VALUES (532532, 5325, '河口瑶族自治县');
INSERT INTO `province_city_district`
VALUES (532621, 5326, '文山县');
INSERT INTO `province_city_district`
VALUES (532622, 5326, '砚山县');
INSERT INTO `province_city_district`
VALUES (532623, 5326, '西畴县');
INSERT INTO `province_city_district`
VALUES (532624, 5326, '麻栗坡县');
INSERT INTO `province_city_district`
VALUES (532625, 5326, '马关县');
INSERT INTO `province_city_district`
VALUES (532626, 5326, '丘北县');
INSERT INTO `province_city_district`
VALUES (532627, 5326, '广南县');
INSERT INTO `province_city_district`
VALUES (532628, 5326, '富宁县');
INSERT INTO `province_city_district`
VALUES (532701, 5327, '思茅市');
INSERT INTO `province_city_district`
VALUES (532722, 5327, '普洱哈尼族彝族自治县');
INSERT INTO `province_city_district`
VALUES (532723, 5327, '墨江哈尼族自治县');
INSERT INTO `province_city_district`
VALUES (532724, 5327, '景东彝族自治县');
INSERT INTO `province_city_district`
VALUES (532725, 5327, '景谷傣族彝族自治县');
INSERT INTO `province_city_district`
VALUES (532726, 5327, '镇沅彝族哈尼族拉祜族');
INSERT INTO `province_city_district`
VALUES (532727, 5327, '江城哈尼族彝族自治县');
INSERT INTO `province_city_district`
VALUES (532728, 5327, '孟连傣族拉祜族佤族自');
INSERT INTO `province_city_district`
VALUES (532729, 5327, '澜沧拉祜族自治县');
INSERT INTO `province_city_district`
VALUES (532730, 5327, '西盟佤族自治县');
INSERT INTO `province_city_district`
VALUES (532801, 5328, '景洪市');
INSERT INTO `province_city_district`
VALUES (532822, 5328, '勐海县');
INSERT INTO `province_city_district`
VALUES (532823, 5328, '勐腊县');
INSERT INTO `province_city_district`
VALUES (532901, 5329, '大理市');
INSERT INTO `province_city_district`
VALUES (532922, 5329, '漾濞彝族自治县');
INSERT INTO `province_city_district`
VALUES (532923, 5329, '祥云县');
INSERT INTO `province_city_district`
VALUES (532924, 5329, '宾川县');
INSERT INTO `province_city_district`
VALUES (532925, 5329, '弥渡县');
INSERT INTO `province_city_district`
VALUES (532926, 5329, '南涧彝族自治县');
INSERT INTO `province_city_district`
VALUES (532927, 5329, '巍山彝族回族自治县');
INSERT INTO `province_city_district`
VALUES (532928, 5329, '永平县');
INSERT INTO `province_city_district`
VALUES (532929, 5329, '云龙县');
INSERT INTO `province_city_district`
VALUES (532930, 5329, '洱源县');
INSERT INTO `province_city_district`
VALUES (532931, 5329, '剑川县');
INSERT INTO `province_city_district`
VALUES (532932, 5329, '鹤庆县');
INSERT INTO `province_city_district`
VALUES (533102, 5331, '瑞丽市');
INSERT INTO `province_city_district`
VALUES (533103, 5331, '潞西市');
INSERT INTO `province_city_district`
VALUES (533122, 5331, '梁河县');
INSERT INTO `province_city_district`
VALUES (533123, 5331, '盈江县');
INSERT INTO `province_city_district`
VALUES (533124, 5331, '陇川县');
INSERT INTO `province_city_district`
VALUES (533221, 5332, '丽江纳西族自治县');
INSERT INTO `province_city_district`
VALUES (533222, 5332, '永胜县');
INSERT INTO `province_city_district`
VALUES (533223, 5332, '华坪县');
INSERT INTO `province_city_district`
VALUES (533224, 5332, '宁蒗彝族自治县');
INSERT INTO `province_city_district`
VALUES (533321, 5333, '泸水县');
INSERT INTO `province_city_district`
VALUES (533323, 5333, '福贡县');
INSERT INTO `province_city_district`
VALUES (533324, 5333, '贡山独龙族怒族自治县');
INSERT INTO `province_city_district`
VALUES (533325, 5333, '兰坪白族普米族自治县');
INSERT INTO `province_city_district`
VALUES (533421, 5334, '中甸县');
INSERT INTO `province_city_district`
VALUES (533422, 5334, '德钦县');
INSERT INTO `province_city_district`
VALUES (533423, 5334, '维西傈僳族自治县');
INSERT INTO `province_city_district`
VALUES (533521, 5335, '临沧县');
INSERT INTO `province_city_district`
VALUES (533522, 5335, '凤庆县');
INSERT INTO `province_city_district`
VALUES (533523, 5335, '云  县');
INSERT INTO `province_city_district`
VALUES (533524, 5335, '永德县');
INSERT INTO `province_city_district`
VALUES (533525, 5335, '镇康县');
INSERT INTO `province_city_district`
VALUES (533526, 5335, '双江拉祜族佤族布朗族');
INSERT INTO `province_city_district`
VALUES (533527, 5335, '耿马傣族佤族自治县');
INSERT INTO `province_city_district`
VALUES (533528, 5335, '沧源佤族自治县');
INSERT INTO `province_city_district`
VALUES (540101, 5401, '市辖区');
INSERT INTO `province_city_district`
VALUES (540102, 5401, '城关区');
INSERT INTO `province_city_district`
VALUES (540121, 5401, '林周县');
INSERT INTO `province_city_district`
VALUES (540122, 5401, '当雄县');
INSERT INTO `province_city_district`
VALUES (540123, 5401, '尼木县');
INSERT INTO `province_city_district`
VALUES (540124, 5401, '曲水县');
INSERT INTO `province_city_district`
VALUES (540125, 5401, '堆龙德庆县');
INSERT INTO `province_city_district`
VALUES (540126, 5401, '达孜县');
INSERT INTO `province_city_district`
VALUES (540127, 5401, '墨竹工卡县');
INSERT INTO `province_city_district`
VALUES (542121, 5421, '昌都县');
INSERT INTO `province_city_district`
VALUES (542122, 5421, '江达县');
INSERT INTO `province_city_district`
VALUES (542123, 5421, '贡觉县');
INSERT INTO `province_city_district`
VALUES (542124, 5421, '类乌齐县');
INSERT INTO `province_city_district`
VALUES (542125, 5421, '丁青县');
INSERT INTO `province_city_district`
VALUES (542126, 5421, '察雅县');
INSERT INTO `province_city_district`
VALUES (542127, 5421, '八宿县');
INSERT INTO `province_city_district`
VALUES (542128, 5421, '左贡县');
INSERT INTO `province_city_district`
VALUES (542129, 5421, '芒康县');
INSERT INTO `province_city_district`
VALUES (542132, 5421, '洛隆县');
INSERT INTO `province_city_district`
VALUES (542133, 5421, '边坝县');
INSERT INTO `province_city_district`
VALUES (542221, 5422, '乃东县');
INSERT INTO `province_city_district`
VALUES (542222, 5422, '扎囊县');
INSERT INTO `province_city_district`
VALUES (542223, 5422, '贡嘎县');
INSERT INTO `province_city_district`
VALUES (542224, 5422, '桑日县');
INSERT INTO `province_city_district`
VALUES (542225, 5422, '琼结县');
INSERT INTO `province_city_district`
VALUES (542226, 5422, '曲松县');
INSERT INTO `province_city_district`
VALUES (542227, 5422, '措美县');
INSERT INTO `province_city_district`
VALUES (542228, 5422, '洛扎县');
INSERT INTO `province_city_district`
VALUES (542229, 5422, '加查县');
INSERT INTO `province_city_district`
VALUES (542231, 5422, '隆子县');
INSERT INTO `province_city_district`
VALUES (542232, 5422, '错那县');
INSERT INTO `province_city_district`
VALUES (542233, 5422, '浪卡子县');
INSERT INTO `province_city_district`
VALUES (542301, 5423, '日喀则市');
INSERT INTO `province_city_district`
VALUES (542322, 5423, '南木林县');
INSERT INTO `province_city_district`
VALUES (542323, 5423, '江孜县');
INSERT INTO `province_city_district`
VALUES (542324, 5423, '定日县');
INSERT INTO `province_city_district`
VALUES (542325, 5423, '萨迦县');
INSERT INTO `province_city_district`
VALUES (542326, 5423, '拉孜县');
INSERT INTO `province_city_district`
VALUES (542327, 5423, '昂仁县');
INSERT INTO `province_city_district`
VALUES (542328, 5423, '谢通门县');
INSERT INTO `province_city_district`
VALUES (542329, 5423, '白朗县');
INSERT INTO `province_city_district`
VALUES (542330, 5423, '仁布县');
INSERT INTO `province_city_district`
VALUES (542331, 5423, '康马县');
INSERT INTO `province_city_district`
VALUES (542332, 5423, '定结县');
INSERT INTO `province_city_district`
VALUES (542333, 5423, '仲巴县');
INSERT INTO `province_city_district`
VALUES (542334, 5423, '亚东县');
INSERT INTO `province_city_district`
VALUES (542335, 5423, '吉隆县');
INSERT INTO `province_city_district`
VALUES (542336, 5423, '聂拉木县');
INSERT INTO `province_city_district`
VALUES (542337, 5423, '萨嘎县');
INSERT INTO `province_city_district`
VALUES (542338, 5423, '岗巴县');
INSERT INTO `province_city_district`
VALUES (542421, 5424, '那曲县');
INSERT INTO `province_city_district`
VALUES (542422, 5424, '嘉黎县');
INSERT INTO `province_city_district`
VALUES (542423, 5424, '比如县');
INSERT INTO `province_city_district`
VALUES (542424, 5424, '聂荣县');
INSERT INTO `province_city_district`
VALUES (542425, 5424, '安多县');
INSERT INTO `province_city_district`
VALUES (542426, 5424, '申扎县');
INSERT INTO `province_city_district`
VALUES (542427, 5424, '索  县');
INSERT INTO `province_city_district`
VALUES (542428, 5424, '班戈县');
INSERT INTO `province_city_district`
VALUES (542429, 5424, '巴青县');
INSERT INTO `province_city_district`
VALUES (542430, 5424, '尼玛县');
INSERT INTO `province_city_district`
VALUES (542521, 5425, '普兰县');
INSERT INTO `province_city_district`
VALUES (542522, 5425, '札达县');
INSERT INTO `province_city_district`
VALUES (542523, 5425, '噶尔县');
INSERT INTO `province_city_district`
VALUES (542524, 5425, '日土县');
INSERT INTO `province_city_district`
VALUES (542525, 5425, '革吉县');
INSERT INTO `province_city_district`
VALUES (542526, 5425, '改则县');
INSERT INTO `province_city_district`
VALUES (542527, 5425, '措勤县');
INSERT INTO `province_city_district`
VALUES (542621, 5426, '林芝县');
INSERT INTO `province_city_district`
VALUES (542622, 5426, '工布江达县');
INSERT INTO `province_city_district`
VALUES (542623, 5426, '米林县');
INSERT INTO `province_city_district`
VALUES (542624, 5426, '墨脱县');
INSERT INTO `province_city_district`
VALUES (542625, 5426, '波密县');
INSERT INTO `province_city_district`
VALUES (542626, 5426, '察隅县');
INSERT INTO `province_city_district`
VALUES (542627, 5426, '朗  县');
INSERT INTO `province_city_district`
VALUES (610101, 6101, '市辖区');
INSERT INTO `province_city_district`
VALUES (610102, 6101, '新城区');
INSERT INTO `province_city_district`
VALUES (610103, 6101, '碑林区');
INSERT INTO `province_city_district`
VALUES (610104, 6101, '莲湖区');
INSERT INTO `province_city_district`
VALUES (610111, 6101, '灞桥区');
INSERT INTO `province_city_district`
VALUES (610112, 6101, '未央区');
INSERT INTO `province_city_district`
VALUES (610113, 6101, '雁塔区');
INSERT INTO `province_city_district`
VALUES (610114, 6101, '阎良区');
INSERT INTO `province_city_district`
VALUES (610115, 6101, '临潼区');
INSERT INTO `province_city_district`
VALUES (610121, 6101, '长安县');
INSERT INTO `province_city_district`
VALUES (610122, 6101, '蓝田县');
INSERT INTO `province_city_district`
VALUES (610124, 6101, '周至县');
INSERT INTO `province_city_district`
VALUES (610125, 6101, '户  县');
INSERT INTO `province_city_district`
VALUES (610126, 6101, '高陵县');
INSERT INTO `province_city_district`
VALUES (610201, 6102, '市辖区');
INSERT INTO `province_city_district`
VALUES (610202, 6102, '王益区');
INSERT INTO `province_city_district`
VALUES (610203, 6102, '印台区');
INSERT INTO `province_city_district`
VALUES (610221, 6102, '耀  县');
INSERT INTO `province_city_district`
VALUES (610222, 6102, '宜君县');
INSERT INTO `province_city_district`
VALUES (610301, 6103, '市辖区');
INSERT INTO `province_city_district`
VALUES (610302, 6103, '渭滨区');
INSERT INTO `province_city_district`
VALUES (610303, 6103, '金台区');
INSERT INTO `province_city_district`
VALUES (610321, 6103, '宝鸡县');
INSERT INTO `province_city_district`
VALUES (610322, 6103, '凤翔县');
INSERT INTO `province_city_district`
VALUES (610323, 6103, '岐山县');
INSERT INTO `province_city_district`
VALUES (610324, 6103, '扶风县');
INSERT INTO `province_city_district`
VALUES (610326, 6103, '眉  县');
INSERT INTO `province_city_district`
VALUES (610327, 6103, '陇  县');
INSERT INTO `province_city_district`
VALUES (610328, 6103, '千阳县');
INSERT INTO `province_city_district`
VALUES (610329, 6103, '麟游县');
INSERT INTO `province_city_district`
VALUES (610330, 6103, '凤  县');
INSERT INTO `province_city_district`
VALUES (610331, 6103, '太白县');
INSERT INTO `province_city_district`
VALUES (610401, 6104, '市辖区');
INSERT INTO `province_city_district`
VALUES (610402, 6104, '秦都区');
INSERT INTO `province_city_district`
VALUES (610403, 6104, '杨陵区');
INSERT INTO `province_city_district`
VALUES (610404, 6104, '渭城区');
INSERT INTO `province_city_district`
VALUES (610422, 6104, '三原县');
INSERT INTO `province_city_district`
VALUES (610423, 6104, '泾阳县');
INSERT INTO `province_city_district`
VALUES (610424, 6104, '乾  县');
INSERT INTO `province_city_district`
VALUES (610425, 6104, '礼泉县');
INSERT INTO `province_city_district`
VALUES (610426, 6104, '永寿县');
INSERT INTO `province_city_district`
VALUES (610427, 6104, '彬  县');
INSERT INTO `province_city_district`
VALUES (610428, 6104, '长武县');
INSERT INTO `province_city_district`
VALUES (610429, 6104, '旬邑县');
INSERT INTO `province_city_district`
VALUES (610430, 6104, '淳化县');
INSERT INTO `province_city_district`
VALUES (610431, 6104, '武功县');
INSERT INTO `province_city_district`
VALUES (610481, 6104, '兴平市');
INSERT INTO `province_city_district`
VALUES (610501, 6105, '市辖区');
INSERT INTO `province_city_district`
VALUES (610502, 6105, '临渭区');
INSERT INTO `province_city_district`
VALUES (610521, 6105, '华  县');
INSERT INTO `province_city_district`
VALUES (610522, 6105, '潼关县');
INSERT INTO `province_city_district`
VALUES (610523, 6105, '大荔县');
INSERT INTO `province_city_district`
VALUES (610524, 6105, '合阳县');
INSERT INTO `province_city_district`
VALUES (610525, 6105, '澄城县');
INSERT INTO `province_city_district`
VALUES (610526, 6105, '蒲城县');
INSERT INTO `province_city_district`
VALUES (610527, 6105, '白水县');
INSERT INTO `province_city_district`
VALUES (610528, 6105, '富平县');
INSERT INTO `province_city_district`
VALUES (610581, 6105, '韩城市');
INSERT INTO `province_city_district`
VALUES (610582, 6105, '华阴市');
INSERT INTO `province_city_district`
VALUES (610601, 6106, '市辖区');
INSERT INTO `province_city_district`
VALUES (610602, 6106, '宝塔区');
INSERT INTO `province_city_district`
VALUES (610621, 6106, '延长县');
INSERT INTO `province_city_district`
VALUES (610622, 6106, '延川县');
INSERT INTO `province_city_district`
VALUES (610623, 6106, '子长县');
INSERT INTO `province_city_district`
VALUES (610624, 6106, '安塞县');
INSERT INTO `province_city_district`
VALUES (610625, 6106, '志丹县');
INSERT INTO `province_city_district`
VALUES (610626, 6106, '吴旗县');
INSERT INTO `province_city_district`
VALUES (610627, 6106, '甘泉县');
INSERT INTO `province_city_district`
VALUES (610628, 6106, '富  县');
INSERT INTO `province_city_district`
VALUES (610629, 6106, '洛川县');
INSERT INTO `province_city_district`
VALUES (610630, 6106, '宜川县');
INSERT INTO `province_city_district`
VALUES (610631, 6106, '黄龙县');
INSERT INTO `province_city_district`
VALUES (610632, 6106, '黄陵县');
INSERT INTO `province_city_district`
VALUES (610701, 6107, '市辖区');
INSERT INTO `province_city_district`
VALUES (610702, 6107, '汉台区');
INSERT INTO `province_city_district`
VALUES (610721, 6107, '南郑县');
INSERT INTO `province_city_district`
VALUES (610722, 6107, '城固县');
INSERT INTO `province_city_district`
VALUES (610723, 6107, '洋  县');
INSERT INTO `province_city_district`
VALUES (610724, 6107, '西乡县');
INSERT INTO `province_city_district`
VALUES (610725, 6107, '勉  县');
INSERT INTO `province_city_district`
VALUES (610726, 6107, '宁强县');
INSERT INTO `province_city_district`
VALUES (610727, 6107, '略阳县');
INSERT INTO `province_city_district`
VALUES (610728, 6107, '镇巴县');
INSERT INTO `province_city_district`
VALUES (610729, 6107, '留坝县');
INSERT INTO `province_city_district`
VALUES (610730, 6107, '佛坪县');
INSERT INTO `province_city_district`
VALUES (610801, 6108, '市辖区');
INSERT INTO `province_city_district`
VALUES (610802, 6108, '榆阳区');
INSERT INTO `province_city_district`
VALUES (610821, 6108, '神木县');
INSERT INTO `province_city_district`
VALUES (610822, 6108, '府谷县');
INSERT INTO `province_city_district`
VALUES (610823, 6108, '横山县');
INSERT INTO `province_city_district`
VALUES (610824, 6108, '靖边县');
INSERT INTO `province_city_district`
VALUES (610825, 6108, '定边县');
INSERT INTO `province_city_district`
VALUES (610826, 6108, '绥德县');
INSERT INTO `province_city_district`
VALUES (610827, 6108, '米脂县');
INSERT INTO `province_city_district`
VALUES (610828, 6108, '佳  县');
INSERT INTO `province_city_district`
VALUES (610829, 6108, '吴堡县');
INSERT INTO `province_city_district`
VALUES (610830, 6108, '清涧县');
INSERT INTO `province_city_district`
VALUES (610831, 6108, '子洲县');
INSERT INTO `province_city_district`
VALUES (610901, 6109, '市辖区');
INSERT INTO `province_city_district`
VALUES (610902, 6109, '汉滨区');
INSERT INTO `province_city_district`
VALUES (610921, 6109, '汉阴县');
INSERT INTO `province_city_district`
VALUES (610922, 6109, '石泉县');
INSERT INTO `province_city_district`
VALUES (610923, 6109, '宁陕县');
INSERT INTO `province_city_district`
VALUES (610924, 6109, '紫阳县');
INSERT INTO `province_city_district`
VALUES (610925, 6109, '岚皋县');
INSERT INTO `province_city_district`
VALUES (610926, 6109, '平利县');
INSERT INTO `province_city_district`
VALUES (610927, 6109, '镇坪县');
INSERT INTO `province_city_district`
VALUES (610928, 6109, '旬阳县');
INSERT INTO `province_city_district`
VALUES (610929, 6109, '白河县');
INSERT INTO `province_city_district`
VALUES (612501, 6125, '商州市');
INSERT INTO `province_city_district`
VALUES (612522, 6125, '洛南县');
INSERT INTO `province_city_district`
VALUES (612523, 6125, '丹凤县');
INSERT INTO `province_city_district`
VALUES (612524, 6125, '商南县');
INSERT INTO `province_city_district`
VALUES (612525, 6125, '山阳县');
INSERT INTO `province_city_district`
VALUES (612526, 6125, '镇安县');
INSERT INTO `province_city_district`
VALUES (612527, 6125, '柞水县');
INSERT INTO `province_city_district`
VALUES (620101, 6201, '市辖区');
INSERT INTO `province_city_district`
VALUES (620102, 6201, '城关区');
INSERT INTO `province_city_district`
VALUES (620103, 6201, '七里河区');
INSERT INTO `province_city_district`
VALUES (620104, 6201, '西固区');
INSERT INTO `province_city_district`
VALUES (620105, 6201, '安宁区');
INSERT INTO `province_city_district`
VALUES (620111, 6201, '红古区');
INSERT INTO `province_city_district`
VALUES (620121, 6201, '永登县');
INSERT INTO `province_city_district`
VALUES (620122, 6201, '皋兰县');
INSERT INTO `province_city_district`
VALUES (620123, 6201, '榆中县');
INSERT INTO `province_city_district`
VALUES (620201, 6202, '市辖区');
INSERT INTO `province_city_district`
VALUES (620301, 6203, '市辖区');
INSERT INTO `province_city_district`
VALUES (620302, 6203, '金川区');
INSERT INTO `province_city_district`
VALUES (620321, 6203, '永昌县');
INSERT INTO `province_city_district`
VALUES (620401, 6204, '市辖区');
INSERT INTO `province_city_district`
VALUES (620402, 6204, '白银区');
INSERT INTO `province_city_district`
VALUES (620403, 6204, '平川区');
INSERT INTO `province_city_district`
VALUES (620421, 6204, '靖远县');
INSERT INTO `province_city_district`
VALUES (620422, 6204, '会宁县');
INSERT INTO `province_city_district`
VALUES (620423, 6204, '景泰县');
INSERT INTO `province_city_district`
VALUES (620501, 6205, '市辖区');
INSERT INTO `province_city_district`
VALUES (620502, 6205, '秦城区');
INSERT INTO `province_city_district`
VALUES (620503, 6205, '北道区');
INSERT INTO `province_city_district`
VALUES (620521, 6205, '清水县');
INSERT INTO `province_city_district`
VALUES (620522, 6205, '秦安县');
INSERT INTO `province_city_district`
VALUES (620523, 6205, '甘谷县');
INSERT INTO `province_city_district`
VALUES (620524, 6205, '武山县');
INSERT INTO `province_city_district`
VALUES (620525, 6205, '张家川回族自治县');
INSERT INTO `province_city_district`
VALUES (622101, 6221, '玉门市');
INSERT INTO `province_city_district`
VALUES (622102, 6221, '酒泉市');
INSERT INTO `province_city_district`
VALUES (622103, 6221, '敦煌市');
INSERT INTO `province_city_district`
VALUES (622123, 6221, '金塔县');
INSERT INTO `province_city_district`
VALUES (622124, 6221, '肃北蒙古族自治县');
INSERT INTO `province_city_district`
VALUES (622125, 6221, '阿克塞哈萨克族自治县');
INSERT INTO `province_city_district`
VALUES (622126, 6221, '安西县');
INSERT INTO `province_city_district`
VALUES (622201, 6222, '张掖市');
INSERT INTO `province_city_district`
VALUES (622222, 6222, '肃南裕固族自治县');
INSERT INTO `province_city_district`
VALUES (622223, 6222, '民乐县');
INSERT INTO `province_city_district`
VALUES (622224, 6222, '临泽县');
INSERT INTO `province_city_district`
VALUES (622225, 6222, '高台县');
INSERT INTO `province_city_district`
VALUES (622226, 6222, '山丹县');
INSERT INTO `province_city_district`
VALUES (622301, 6223, '武威市');
INSERT INTO `province_city_district`
VALUES (622322, 6223, '民勤县');
INSERT INTO `province_city_district`
VALUES (622323, 6223, '古浪县');
INSERT INTO `province_city_district`
VALUES (622326, 6223, '天祝藏族自治县');
INSERT INTO `province_city_district`
VALUES (622421, 6224, '定西县');
INSERT INTO `province_city_district`
VALUES (622424, 6224, '通渭县');
INSERT INTO `province_city_district`
VALUES (622425, 6224, '陇西县');
INSERT INTO `province_city_district`
VALUES (622426, 6224, '渭源县');
INSERT INTO `province_city_district`
VALUES (622427, 6224, '临洮县');
INSERT INTO `province_city_district`
VALUES (622428, 6224, '漳  县');
INSERT INTO `province_city_district`
VALUES (622429, 6224, '岷  县');
INSERT INTO `province_city_district`
VALUES (622621, 6226, '武都县');
INSERT INTO `province_city_district`
VALUES (622623, 6226, '宕昌县');
INSERT INTO `province_city_district`
VALUES (622624, 6226, '成  县');
INSERT INTO `province_city_district`
VALUES (622625, 6226, '康  县');
INSERT INTO `province_city_district`
VALUES (622626, 6226, '文  县');
INSERT INTO `province_city_district`
VALUES (622627, 6226, '西和县');
INSERT INTO `province_city_district`
VALUES (622628, 6226, '礼  县');
INSERT INTO `province_city_district`
VALUES (622629, 6226, '两当县');
INSERT INTO `province_city_district`
VALUES (622630, 6226, '徽  县');
INSERT INTO `province_city_district`
VALUES (622701, 6227, '平凉市');
INSERT INTO `province_city_district`
VALUES (622722, 6227, '泾川县');
INSERT INTO `province_city_district`
VALUES (622723, 6227, '灵台县');
INSERT INTO `province_city_district`
VALUES (622724, 6227, '崇信县');
INSERT INTO `province_city_district`
VALUES (622725, 6227, '华亭县');
INSERT INTO `province_city_district`
VALUES (622726, 6227, '庄浪县');
INSERT INTO `province_city_district`
VALUES (622727, 6227, '静宁县');
INSERT INTO `province_city_district`
VALUES (622801, 6228, '西峰市');
INSERT INTO `province_city_district`
VALUES (622821, 6228, '庆阳县');
INSERT INTO `province_city_district`
VALUES (622822, 6228, '环  县');
INSERT INTO `province_city_district`
VALUES (622823, 6228, '华池县');
INSERT INTO `province_city_district`
VALUES (622824, 6228, '合水县');
INSERT INTO `province_city_district`
VALUES (622825, 6228, '正宁县');
INSERT INTO `province_city_district`
VALUES (622826, 6228, '宁  县');
INSERT INTO `province_city_district`
VALUES (622827, 6228, '镇原县');
INSERT INTO `province_city_district`
VALUES (622901, 6229, '临夏市');
INSERT INTO `province_city_district`
VALUES (622921, 6229, '临夏县');
INSERT INTO `province_city_district`
VALUES (622922, 6229, '康乐县');
INSERT INTO `province_city_district`
VALUES (622923, 6229, '永靖县');
INSERT INTO `province_city_district`
VALUES (622924, 6229, '广河县');
INSERT INTO `province_city_district`
VALUES (622925, 6229, '和政县');
INSERT INTO `province_city_district`
VALUES (622926, 6229, '东乡族自治县');
INSERT INTO `province_city_district`
VALUES (622927, 6229, '积石山保安族东乡族撒');
INSERT INTO `province_city_district`
VALUES (623001, 6230, '合作市');
INSERT INTO `province_city_district`
VALUES (623021, 6230, '临潭县');
INSERT INTO `province_city_district`
VALUES (623022, 6230, '卓尼县');
INSERT INTO `province_city_district`
VALUES (623023, 6230, '舟曲县');
INSERT INTO `province_city_district`
VALUES (623024, 6230, '迭部县');
INSERT INTO `province_city_district`
VALUES (623025, 6230, '玛曲县');
INSERT INTO `province_city_district`
VALUES (623026, 6230, '碌曲县');
INSERT INTO `province_city_district`
VALUES (623027, 6230, '夏河县');
INSERT INTO `province_city_district`
VALUES (630101, 6301, '市辖区');
INSERT INTO `province_city_district`
VALUES (630102, 6301, '城东区');
INSERT INTO `province_city_district`
VALUES (630103, 6301, '城中区');
INSERT INTO `province_city_district`
VALUES (630104, 6301, '城西区');
INSERT INTO `province_city_district`
VALUES (630105, 6301, '城北区');
INSERT INTO `province_city_district`
VALUES (630121, 6301, '大通回族土族自治县');
INSERT INTO `province_city_district`
VALUES (630122, 6301, '湟中县');
INSERT INTO `province_city_district`
VALUES (630123, 6301, '湟源县');
INSERT INTO `province_city_district`
VALUES (632121, 6321, '平安县');
INSERT INTO `province_city_district`
VALUES (632122, 6321, '民和回族土族自治县');
INSERT INTO `province_city_district`
VALUES (632123, 6321, '乐都县');
INSERT INTO `province_city_district`
VALUES (632126, 6321, '互助土族自治县');
INSERT INTO `province_city_district`
VALUES (632127, 6321, '化隆回族自治县');
INSERT INTO `province_city_district`
VALUES (632128, 6321, '循化撒拉族自治县');
INSERT INTO `province_city_district`
VALUES (632221, 6322, '门源回族自治县');
INSERT INTO `province_city_district`
VALUES (632222, 6322, '祁连县');
INSERT INTO `province_city_district`
VALUES (632223, 6322, '海晏县');
INSERT INTO `province_city_district`
VALUES (632224, 6322, '刚察县');
INSERT INTO `province_city_district`
VALUES (632321, 6323, '同仁县');
INSERT INTO `province_city_district`
VALUES (632322, 6323, '尖扎县');
INSERT INTO `province_city_district`
VALUES (632323, 6323, '泽库县');
INSERT INTO `province_city_district`
VALUES (632324, 6323, '河南蒙古族自治县');
INSERT INTO `province_city_district`
VALUES (632521, 6325, '共和县');
INSERT INTO `province_city_district`
VALUES (632522, 6325, '同德县');
INSERT INTO `province_city_district`
VALUES (632523, 6325, '贵德县');
INSERT INTO `province_city_district`
VALUES (632524, 6325, '兴海县');
INSERT INTO `province_city_district`
VALUES (632525, 6325, '贵南县');
INSERT INTO `province_city_district`
VALUES (632621, 6326, '玛沁县');
INSERT INTO `province_city_district`
VALUES (632622, 6326, '班玛县');
INSERT INTO `province_city_district`
VALUES (632623, 6326, '甘德县');
INSERT INTO `province_city_district`
VALUES (632624, 6326, '达日县');
INSERT INTO `province_city_district`
VALUES (632625, 6326, '久治县');
INSERT INTO `province_city_district`
VALUES (632626, 6326, '玛多县');
INSERT INTO `province_city_district`
VALUES (632721, 6327, '玉树县');
INSERT INTO `province_city_district`
VALUES (632722, 6327, '杂多县');
INSERT INTO `province_city_district`
VALUES (632723, 6327, '称多县');
INSERT INTO `province_city_district`
VALUES (632724, 6327, '治多县');
INSERT INTO `province_city_district`
VALUES (632725, 6327, '囊谦县');
INSERT INTO `province_city_district`
VALUES (632726, 6327, '曲麻莱县');
INSERT INTO `province_city_district`
VALUES (632801, 6328, '格尔木市');
INSERT INTO `province_city_district`
VALUES (632802, 6328, '德令哈市');
INSERT INTO `province_city_district`
VALUES (632821, 6328, '乌兰县');
INSERT INTO `province_city_district`
VALUES (632822, 6328, '都兰县');
INSERT INTO `province_city_district`
VALUES (632823, 6328, '天峻县');
INSERT INTO `province_city_district`
VALUES (640101, 6401, '市辖区');
INSERT INTO `province_city_district`
VALUES (640102, 6401, '城  区');
INSERT INTO `province_city_district`
VALUES (640103, 6401, '新城区');
INSERT INTO `province_city_district`
VALUES (640111, 6401, '郊  区');
INSERT INTO `province_city_district`
VALUES (640121, 6401, '永宁县');
INSERT INTO `province_city_district`
VALUES (640122, 6401, '贺兰县');
INSERT INTO `province_city_district`
VALUES (640201, 6402, '市辖区');
INSERT INTO `province_city_district`
VALUES (640202, 6402, '大武口区');
INSERT INTO `province_city_district`
VALUES (640203, 6402, '石嘴山区');
INSERT INTO `province_city_district`
VALUES (640204, 6402, '石炭井区');
INSERT INTO `province_city_district`
VALUES (640221, 6402, '平罗县');
INSERT INTO `province_city_district`
VALUES (640222, 6402, '陶乐县');
INSERT INTO `province_city_district`
VALUES (640223, 6402, '惠农县');
INSERT INTO `province_city_district`
VALUES (640301, 6403, '市辖区');
INSERT INTO `province_city_district`
VALUES (640302, 6403, '利通区');
INSERT INTO `province_city_district`
VALUES (640321, 6403, '中卫县');
INSERT INTO `province_city_district`
VALUES (640322, 6403, '中宁县');
INSERT INTO `province_city_district`
VALUES (640323, 6403, '盐池县');
INSERT INTO `province_city_district`
VALUES (640324, 6403, '同心县');
INSERT INTO `province_city_district`
VALUES (640381, 6403, '青铜峡市');
INSERT INTO `province_city_district`
VALUES (640382, 6403, '灵武市');
INSERT INTO `province_city_district`
VALUES (642221, 6422, '固原县');
INSERT INTO `province_city_district`
VALUES (642222, 6422, '海原县');
INSERT INTO `province_city_district`
VALUES (642223, 6422, '西吉县');
INSERT INTO `province_city_district`
VALUES (642224, 6422, '隆德县');
INSERT INTO `province_city_district`
VALUES (642225, 6422, '泾源县');
INSERT INTO `province_city_district`
VALUES (642226, 6422, '彭阳县');
INSERT INTO `province_city_district`
VALUES (650101, 6501, '市辖区');
INSERT INTO `province_city_district`
VALUES (650102, 6501, '天山区');
INSERT INTO `province_city_district`
VALUES (650103, 6501, '沙依巴克区');
INSERT INTO `province_city_district`
VALUES (650104, 6501, '新市区');
INSERT INTO `province_city_district`
VALUES (650105, 6501, '水磨沟区');
INSERT INTO `province_city_district`
VALUES (650106, 6501, '头屯河区');
INSERT INTO `province_city_district`
VALUES (650107, 6501, '南泉区');
INSERT INTO `province_city_district`
VALUES (650108, 6501, '东山区');
INSERT INTO `province_city_district`
VALUES (650121, 6501, '乌鲁木齐县');
INSERT INTO `province_city_district`
VALUES (650201, 6502, '市辖区');
INSERT INTO `province_city_district`
VALUES (650202, 6502, '独山子区');
INSERT INTO `province_city_district`
VALUES (650203, 6502, '克拉玛依区');
INSERT INTO `province_city_district`
VALUES (650204, 6502, '白碱滩区');
INSERT INTO `province_city_district`
VALUES (650205, 6502, '乌尔禾区');
INSERT INTO `province_city_district`
VALUES (652101, 6521, '吐鲁番市');
INSERT INTO `province_city_district`
VALUES (652122, 6521, '鄯善县');
INSERT INTO `province_city_district`
VALUES (652123, 6521, '托克逊县');
INSERT INTO `province_city_district`
VALUES (652201, 6522, '哈密市');
INSERT INTO `province_city_district`
VALUES (652222, 6522, '巴里坤哈萨克自治县');
INSERT INTO `province_city_district`
VALUES (652223, 6522, '伊吾县');
INSERT INTO `province_city_district`
VALUES (652301, 6523, '昌吉市');
INSERT INTO `province_city_district`
VALUES (652302, 6523, '阜康市');
INSERT INTO `province_city_district`
VALUES (652303, 6523, '米泉市');
INSERT INTO `province_city_district`
VALUES (652323, 6523, '呼图壁县');
INSERT INTO `province_city_district`
VALUES (652324, 6523, '玛纳斯县');
INSERT INTO `province_city_district`
VALUES (652325, 6523, '奇台县');
INSERT INTO `province_city_district`
VALUES (652327, 6523, '吉木萨尔县');
INSERT INTO `province_city_district`
VALUES (652328, 6523, '木垒哈萨克自治县');
INSERT INTO `province_city_district`
VALUES (652701, 6527, '博乐市');
INSERT INTO `province_city_district`
VALUES (652722, 6527, '精河县');
INSERT INTO `province_city_district`
VALUES (652723, 6527, '温泉县');
INSERT INTO `province_city_district`
VALUES (652801, 6528, '库尔勒市');
INSERT INTO `province_city_district`
VALUES (652822, 6528, '轮台县');
INSERT INTO `province_city_district`
VALUES (652823, 6528, '尉犁县');
INSERT INTO `province_city_district`
VALUES (652824, 6528, '若羌县');
INSERT INTO `province_city_district`
VALUES (652825, 6528, '且末县');
INSERT INTO `province_city_district`
VALUES (652826, 6528, '焉耆回族自治县');
INSERT INTO `province_city_district`
VALUES (652827, 6528, '和静县');
INSERT INTO `province_city_district`
VALUES (652828, 6528, '和硕县');
INSERT INTO `province_city_district`
VALUES (652829, 6528, '博湖县');
INSERT INTO `province_city_district`
VALUES (652901, 6529, '阿克苏市');
INSERT INTO `province_city_district`
VALUES (652922, 6529, '温宿县');
INSERT INTO `province_city_district`
VALUES (652923, 6529, '库车县');
INSERT INTO `province_city_district`
VALUES (652924, 6529, '沙雅县');
INSERT INTO `province_city_district`
VALUES (652925, 6529, '新和县');
INSERT INTO `province_city_district`
VALUES (652926, 6529, '拜城县');
INSERT INTO `province_city_district`
VALUES (652927, 6529, '乌什县');
INSERT INTO `province_city_district`
VALUES (652928, 6529, '阿瓦提县');
INSERT INTO `province_city_district`
VALUES (652929, 6529, '柯坪县');
INSERT INTO `province_city_district`
VALUES (653001, 6530, '阿图什市');
INSERT INTO `province_city_district`
VALUES (653022, 6530, '阿克陶县');
INSERT INTO `province_city_district`
VALUES (653023, 6530, '阿合奇县');
INSERT INTO `province_city_district`
VALUES (653024, 6530, '乌恰县');
INSERT INTO `province_city_district`
VALUES (653101, 6531, '喀什市');
INSERT INTO `province_city_district`
VALUES (653121, 6531, '疏附县');
INSERT INTO `province_city_district`
VALUES (653122, 6531, '疏勒县');
INSERT INTO `province_city_district`
VALUES (653123, 6531, '英吉沙县');
INSERT INTO `province_city_district`
VALUES (653124, 6531, '泽普县');
INSERT INTO `province_city_district`
VALUES (653125, 6531, '莎车县');
INSERT INTO `province_city_district`
VALUES (653126, 6531, '叶城县');
INSERT INTO `province_city_district`
VALUES (653127, 6531, '麦盖提县');
INSERT INTO `province_city_district`
VALUES (653128, 6531, '岳普湖县');
INSERT INTO `province_city_district`
VALUES (653129, 6531, '伽师县');
INSERT INTO `province_city_district`
VALUES (653130, 6531, '巴楚县');
INSERT INTO `province_city_district`
VALUES (653131, 6531, '塔什库尔干塔吉克自治');
INSERT INTO `province_city_district`
VALUES (653201, 6532, '和田市');
INSERT INTO `province_city_district`
VALUES (653221, 6532, '和田县');
INSERT INTO `province_city_district`
VALUES (653222, 6532, '墨玉县');
INSERT INTO `province_city_district`
VALUES (653223, 6532, '皮山县');
INSERT INTO `province_city_district`
VALUES (653224, 6532, '洛浦县');
INSERT INTO `province_city_district`
VALUES (653225, 6532, '策勒县');
INSERT INTO `province_city_district`
VALUES (653226, 6532, '于田县');
INSERT INTO `province_city_district`
VALUES (653227, 6532, '民丰县');
INSERT INTO `province_city_district`
VALUES (654001, 6540, '奎屯市');
INSERT INTO `province_city_district`
VALUES (654101, 6541, '伊宁市');
INSERT INTO `province_city_district`
VALUES (654121, 6541, '伊宁县');
INSERT INTO `province_city_district`
VALUES (654122, 6541, '察布查尔锡伯自治县');
INSERT INTO `province_city_district`
VALUES (654123, 6541, '霍城县');
INSERT INTO `province_city_district`
VALUES (654124, 6541, '巩留县');
INSERT INTO `province_city_district`
VALUES (654125, 6541, '新源县');
INSERT INTO `province_city_district`
VALUES (654126, 6541, '昭苏县');
INSERT INTO `province_city_district`
VALUES (654127, 6541, '特克斯县');
INSERT INTO `province_city_district`
VALUES (654128, 6541, '尼勒克县');
INSERT INTO `province_city_district`
VALUES (654201, 6542, '塔城市');
INSERT INTO `province_city_district`
VALUES (654202, 6542, '乌苏市');
INSERT INTO `province_city_district`
VALUES (654221, 6542, '额敏县');
INSERT INTO `province_city_district`
VALUES (654223, 6542, '沙湾县');
INSERT INTO `province_city_district`
VALUES (654224, 6542, '托里县');
INSERT INTO `province_city_district`
VALUES (654225, 6542, '裕民县');
INSERT INTO `province_city_district`
VALUES (654226, 6542, '和布克赛尔蒙古自治县');
INSERT INTO `province_city_district`
VALUES (654301, 6543, '阿勒泰市');
INSERT INTO `province_city_district`
VALUES (654321, 6543, '布尔津县');
INSERT INTO `province_city_district`
VALUES (654322, 6543, '富蕴县');
INSERT INTO `province_city_district`
VALUES (654323, 6543, '福海县');
INSERT INTO `province_city_district`
VALUES (654324, 6543, '哈巴河县');
INSERT INTO `province_city_district`
VALUES (654325, 6543, '青河县');
INSERT INTO `province_city_district`
VALUES (654326, 6543, '吉木乃县');
INSERT INTO `province_city_district`
VALUES (659001, 6590, '石河子市');
INSERT INTO `province_city_district`
VALUES (710101, 7101, '请选择');
INSERT INTO `province_city_district`
VALUES (710102, 7101, '市辖区');
INSERT INTO `province_city_district`
VALUES (710103, 7101, '台湾省');
INSERT INTO `province_city_district`
VALUES (810101, 8101, '请选择');
INSERT INTO `province_city_district`
VALUES (810102, 8101, '市辖区');
INSERT INTO `province_city_district`
VALUES (810103, 8101, '香港特区');
INSERT INTO `province_city_district`
VALUES (910101, 9101, '请选择');
INSERT INTO `province_city_district`
VALUES (910102, 9101, '市辖区');
INSERT INTO `province_city_district`
VALUES (910103, 9101, '澳门特区');

-- ----------------------------
-- Table structure for table_file_generation
-- ----------------------------
DROP TABLE IF EXISTS `table_file_generation`;
CREATE TABLE `table_file_generation`
(
    `pid`         bigint(20)                                                    NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    `table_id`    bigint(20)                                                    NULL DEFAULT NULL COMMENT '表ID',
    `template_id` bigint(20)                                                    NULL DEFAULT NULL COMMENT '模板ID',
    `file_name`   varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '文件名称',
    `save_path`   varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '保存路径',
    PRIMARY KEY (`pid`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 1
  CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_general_ci COMMENT = '表文件生成记录表'
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of table_file_generation
-- ----------------------------

-- ----------------------------
-- Table structure for template_file_generation
-- ----------------------------
DROP TABLE IF EXISTS `template_file_generation`;
CREATE TABLE `template_file_generation`
(
    `pid`         bigint(20)                                                    NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    `task_id`     varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '代码生成任务ID',
    `file_name`   varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '文件名称',
    `template_id` bigint(20)                                                    NULL DEFAULT NULL COMMENT '模板ID',
    `save_path`   varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '保存路径',
    `remark`      varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注信息',
    `builtin`     tinyint(1)                                                    NULL DEFAULT NULL COMMENT '是否内置',
    PRIMARY KEY (`pid`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 1
  CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_general_ci COMMENT = '模板文件生成关联表'
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of template_file_generation
-- ----------------------------
INSERT INTO `template_file_generation`
VALUES (8, NULL, 'Mapper.java', 1, NULL, '12212', 1);
INSERT INTO `template_file_generation`
VALUES (9, NULL, 'Entity.java', 2, NULL, '121212', 1);
INSERT INTO `template_file_generation`
VALUES (10, NULL, 'Service.java', 3, NULL, '232323', 1);
INSERT INTO `template_file_generation`
VALUES (11, NULL, 'ServiceImpl.java', 4, NULL, '34343', 1);
INSERT INTO `template_file_generation`
VALUES (12, NULL, 'VO.java', 5, NULL, '12121212', 1);
INSERT INTO `template_file_generation`
VALUES (16, NULL, 'Controller.java', 6, NULL, 'wrewerwer', 1);

-- ----------------------------
-- Table structure for template_info
-- ----------------------------
DROP TABLE IF EXISTS `template_info`;
CREATE TABLE `template_info`
(
    `template_id`   bigint(20)                                                    NOT NULL AUTO_INCREMENT COMMENT '模板ID主键',
    `template_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '模板名称',
    `type`          tinyint(4)                                                    NULL DEFAULT NULL COMMENT '模板类型',
    `provider`      varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci  NULL DEFAULT NULL COMMENT '技术提供方',
    `content`       text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci         NULL COMMENT '字符串模板内容',
    `path`          varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '文件模板路径',
    `create_time`   datetime                                                      NULL DEFAULT NULL COMMENT '创建时间',
    `update_time`   datetime                                                      NULL DEFAULT NULL COMMENT '更新时间',
    `remark`        varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注信息',
    `deleted`       tinyint(4)                                                    NULL DEFAULT NULL COMMENT '逻辑删除状态',
    PRIMARY KEY (`template_id`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 1
  CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_general_ci COMMENT = '模板记录表'
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of template_info
-- ----------------------------
INSERT INTO `template_info`
VALUES (1, 'Mapper.ftl', 2, 'FreeMarker',
        '<#assign dbTime = \"now()\">\n<#if dbType==\"SQLServer\">\n    <#assign dbTime = \"getDate()\">\n</#if>\n\n-- 初始化菜单\nINSERT INTO sys_menu (pid, name, url, authority, type, open_style, icon, sort, version, deleted, creator, create_time, updater, update_time) VALUES (1, \'${tableComment!}\', \'${moduleName}/${functionName}/index\', NULL, 0, 0, \'icon-menu\', 0, 0, 0, 10000, ${dbTime}, 10000, ${dbTime});\n\nINSERT INTO sys_menu (pid, name, url, authority, type, open_style, icon, sort, version, deleted, creator, create_time, updater, update_time) VALUES ((SELECT max(id) from sys_menu where name = \'${tableComment!}\'), \'查看\', \'\', \'${moduleName}:${functionName}:page\', 1, 0, \'\', 0, 0, 0, 10000, ${dbTime}, 10000, ${dbTime});\nINSERT INTO sys_menu (pid, name, url, authority, type, open_style, icon, sort, version, deleted, creator, create_time, updater, update_time) VALUES ((SELECT max(id) from sys_menu where name = \'${tableComment!}\'), \'新增\', \'\', \'${moduleName}:${functionName}:save\', 1, 0, \'\', 1, 0, 0, 10000, ${dbTime}, 10000, ${dbTime});\nINSERT INTO sys_menu (pid, name, url, authority, type, open_style, icon, sort, version, deleted, creator, create_time, updater, update_time) VALUES ((SELECT max(id) from sys_menu where name = \'${tableComment!}\'), \'修改\', \'\', \'${moduleName}:${functionName}:update,${moduleName}:${functionName}:info\', 1, 0, \'\', 2, 0, 0, 10000, ${dbTime}, 10000, ${dbTime});\nINSERT INTO sys_menu (pid, name, url, authority, type, open_style, icon, sort, version, deleted, creator, create_time, updater, update_time) VALUES ((SELECT max(id) from sys_menu where name = \'${tableComment!}\'), \'删除\', \'\', \'${moduleName}:${functionName}:delete\', 1, 0, \'\', 3, 0, 0, 10000, ${dbTime}, 10000, ${dbTime});\n',
        '', '2023-07-11 15:56:30', '2023-07-11 15:56:30', NULL, 0);
INSERT INTO `template_info`
VALUES (2, 'Entity.java.ftl', 2, 'FreeMarker',
        'package ${package}.${moduleName}.entity;\n\nimport lombok.Data;\nimport lombok.EqualsAndHashCode;\nimport com.baomidou.mybatisplus.annotation.*;\n<#list importList as i>\n    import ${i!};\n</#list>\n<#if baseClass??>\n    import ${baseClass.packageName}.${baseClass.code};\n</#if>\n\n/**\n* ${tableComment}\n*\n* @author ${author} ${email}\n* @since ${version} ${date}\n*/\n<#if baseClass??>@EqualsAndHashCode(callSuper=false)</#if>\n@Data\n@TableName(\"${tableName}\")\npublic class ${ClassName}Entity<#if baseClass??> extends ${baseClass.code}</#if> {\n<#list fieldList as field>\n    <#if !field.baseField>\n        <#if field.fieldComment!?length gt 0>\n            /**\n            * ${field.fieldComment}\n            */\n        </#if>\n        <#if field.autoFill == \"INSERT\">\n            @TableField(fill = FieldFill.INSERT)\n        </#if>\n        <#if field.autoFill == \"INSERT_UPDATE\">\n            @TableField(fill = FieldFill.INSERT_UPDATE)\n        </#if>\n        <#if field.autoFill == \"UPDATE\">\n            @TableField(fill = FieldFill.UPDATE)\n        </#if>\n        <#if field.primaryKey>\n            @TableId\n        </#if>\n        private ${field.attrType} ${field.attrName};\n    </#if>\n\n</#list>\n}\n',
        '', '2023-07-20 17:48:43', '2023-07-20 17:48:43', NULL, 0);
INSERT INTO `template_info`
VALUES (3, 'Service.java.ftl', 2, 'FreeMarker',
        'package ${package}.${moduleName}.service;\n\nimport ${package}.framework.common.utils.PageResult;\nimport ${package}.framework.mybatis.service.BaseService;\nimport ${package}.${moduleName}.vo.${ClassName}VO;\nimport ${package}.${moduleName}.query.${ClassName}Query;\nimport ${package}.${moduleName}.entity.${ClassName}Entity;\n\nimport java.util.List;\n\n/**\n* ${tableComment}\n*\n* @author ${author} ${email}\n* @since ${version} ${date}\n*/\npublic interface ${ClassName}Service extends BaseService\n<${ClassName}Entity> {\n\n    PageResult\n    <${ClassName}VO> page(${ClassName}Query query);\n\n        void save(${ClassName}VO vo);\n\n        void update(${ClassName}VO vo);\n\n        void delete(List\n        <Long> idList);\n            }\n',
        '', '2023-07-20 17:52:30', '2023-07-20 17:52:30', NULL, 0);
INSERT INTO `template_info`
VALUES (4, 'ServiceImpl.java.ftl', 2, 'FreeMarker',
        'package ${package}.${moduleName}.service;\n\nimport ${package}.framework.common.utils.PageResult;\nimport ${package}.framework.mybatis.service.BaseService;\nimport ${package}.${moduleName}.vo.${ClassName}VO;\nimport ${package}.${moduleName}.query.${ClassName}Query;\nimport ${package}.${moduleName}.entity.${ClassName}Entity;\n\nimport java.util.List;\n\n/**\n* ${tableComment}\n*\n* @author ${author} ${email}\n* @since ${version} ${date}\n*/\npublic interface ${ClassName}Service extends BaseService\n<${ClassName}Entity> {\n\n    PageResult\n    <${ClassName}VO> page(${ClassName}Query query);\n\n        void save(${ClassName}VO vo);\n\n        void update(${ClassName}VO vo);\n\n        void delete(List\n        <Long> idList);\n            }\n',
        '', '2023-07-20 17:52:51', '2023-07-20 17:52:51', NULL, 0);
INSERT INTO `template_info`
VALUES (5, 'VO.java.ftl', 2, 'FreeMarker',
        'package ${package}.${moduleName}.vo;\n\nimport io.swagger.v3.oas.annotations.media.Schema;\nimport com.fasterxml.jackson.annotation.JsonFormat;\nimport lombok.Data;\nimport java.io.Serializable;\nimport ${package}.framework.common.utils.DateUtils;\n<#list importList as i>\n    import ${i!};\n</#list>\n\n/**\n* ${tableComment}\n*\n* @author ${author} ${email}\n* @since ${version} ${date}\n*/\n@Data\n@Schema(description = \"${tableComment}\")\npublic class ${ClassName}VO implements Serializable {\nprivate static final long serialVersionUID = 1L;\n\n<#list fieldList as field>\n    <#if field.fieldComment!?length gt 0>\n        @Schema(description = \"${field.fieldComment}\")\n    </#if>\n    <#if field.attrType == \'Date\'>\n        @JsonFormat(pattern = DateUtils.DATE_TIME_PATTERN)\n    </#if>\n    private ${field.attrType} ${field.attrName};\n\n</#list>\n\n}\n',
        '', '2023-07-20 17:53:55', '2023-07-20 17:53:55', NULL, 0);
INSERT INTO `template_info`
VALUES (6, 'Controller.java.ftl', 2, 'FreeMarker',
        'package ${package}.${moduleName}.controller;\n\nimport io.swagger.v3.oas.annotations.Operation;\nimport io.swagger.v3.oas.annotations.tags.Tag;\nimport lombok.AllArgsConstructor;\nimport ${package}.framework.common.utils.PageResult;\nimport ${package}.framework.common.utils.Result;\nimport ${package}.${moduleName}.convert.${ClassName}Convert;\nimport ${package}.${moduleName}.entity.${ClassName}Entity;\nimport ${package}.${moduleName}.service.${ClassName}Service;\nimport ${package}.${moduleName}.query.${ClassName}Query;\nimport ${package}.${moduleName}.vo.${ClassName}VO;\nimport org.springdoc.core.annotations.ParameterObject;\nimport org.springframework.security.access.prepost.PreAuthorize;\nimport org.springframework.web.bind.annotation.*;\n\nimport jakarta.validation.Valid;\nimport java.util.List;\n\n/**\n* ${tableComment}\n*\n* @author ${author} ${email}\n* @since ${version} ${date}\n*/\n@RestController\n@RequestMapping(\"${moduleName}/${functionName}\")\n@Tag(name=\"${tableComment}\")\n@AllArgsConstructor\npublic class ${ClassName}Controller {\nprivate final ${ClassName}Service ${className}Service;\n\n@GetMapping(\"page\")\n@Operation(summary = \"分页\")\n@PreAuthorize(\"hasAuthority(\'${moduleName}:${functionName}:page\')\")\npublic Result\n<PageResult\n<${ClassName}VO>> page(@ParameterObject @Valid ${ClassName}Query query){\n    PageResult\n    <${ClassName}VO> page = ${className}Service.page(query);\n\n        return Result.ok(page);\n        }\n\n        @GetMapping(\"{id}\")\n        @Operation(summary = \"信息\")\n        @PreAuthorize(\"hasAuthority(\'${moduleName}:${functionName}:info\')\")\n        public Result\n        <${ClassName}VO> get(@PathVariable(\"id\") Long id){\n            ${ClassName}Entity entity = ${className}Service.getById(id);\n\n            return Result.ok(${ClassName}Convert.INSTANCE.convert(entity));\n            }\n\n            @PostMapping\n            @Operation(summary = \"保存\")\n            @PreAuthorize(\"hasAuthority(\'${moduleName}:${functionName}:save\')\")\n            public Result\n            <String> save(@RequestBody ${ClassName}VO vo){\n                ${className}Service.save(vo);\n\n                return Result.ok();\n                }\n\n                @PutMapping\n                @Operation(summary = \"修改\")\n                @PreAuthorize(\"hasAuthority(\'${moduleName}:${functionName}:update\')\")\n                public Result\n                <String> update(@RequestBody @Valid ${ClassName}VO vo){\n                    ${className}Service.update(vo);\n\n                    return Result.ok();\n                    }\n\n                    @DeleteMapping\n                    @Operation(summary = \"删除\")\n                    @PreAuthorize(\"hasAuthority(\'${moduleName}:${functionName}:delete\')\")\n                    public Result\n                    <String> delete(@RequestBody List\n                        <Long> idList){\n                            ${className}Service.delete(idList);\n\n                            return Result.ok();\n                            }\n                            }\n',
        '', '2023-07-20 17:54:53', '2023-07-20 17:54:53', NULL, 0);
INSERT INTO `template_info`
VALUES (8, 'VO.java.ftl', 1, NULL, '', 'template\\VO.java.ftl', '2023-08-05 19:52:29', '2023-08-05 19:52:29', NULL, 0);
INSERT INTO `template_info`
VALUES (9, 'menu.sql.ftl', 1, NULL, '', 'template\\menu.sql.ftl', '2023-08-05 20:03:44', '2023-08-05 20:03:44', NULL,
        0);
INSERT INTO `template_info`
VALUES (10, 'add-or-update.vue.ftl', 1, NULL, '', 'template\\add-or-update.vue.ftl', '2023-08-05 20:04:34',
        '2023-08-05 20:04:34', NULL, 0);
INSERT INTO `template_info`
VALUES (11, 'api.ts.ftl', 1, NULL, '', 'template\\api.ts.ftl', '2023-08-05 20:04:43', '2023-08-05 20:04:43', NULL, 0);
INSERT INTO `template_info`
VALUES (12, 'api.ts.ftl', 1, NULL, '', 'template\\api.ts.ftl', '2023-08-05 20:05:04', '2023-08-05 20:05:04', NULL, 0);
INSERT INTO `template_info`
VALUES (13, 'index.vue.ftl', 1, NULL, '', 'template\\index.vue.ftl', '2023-08-05 20:05:22', '2023-08-05 20:05:22', NULL,
        0);

-- ----------------------------
-- Table structure for template_param
-- ----------------------------
DROP TABLE IF EXISTS `template_param`;
CREATE TABLE `template_param`
(
    `id`          int(11)                                                       NOT NULL COMMENT '主键ID',
    `template_id` int(11)                                                       NULL DEFAULT NULL COMMENT '模板ID',
    `param_key`   varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '参数key, 一般为出现在模板中的变量名,单个模板内唯一',
    `param_name`  varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '参数名',
    `param_value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '参数值,默认参数值, 未提供该参数时使用此值',
    `data_type`   varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '数据类型, 统一所有的数据类型',
    `remark`      varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注信息',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_general_ci COMMENT = '模板参数元数据表'
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of template_param
-- ----------------------------

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`
(
    `user_id`   varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户ID',
    `user_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户名称',
    `email`     varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '邮箱'
) ENGINE = InnoDB
  CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_general_ci COMMENT = '开发者信息表'
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;

/**
  数据库表信息记录表
 */
DROP TABLE IF EXISTS `table_info`;
CREATE TABLE `table_info`
(
    `id`                        bigint unsigned PRIMARY KEY AUTO_INCREMENT COMMENT '自增主键',
    `table_cat`                 VARCHAR(255) NULL COMMENT 'table catalog (may be null)',
    `table_schem`               VARCHAR(255) NULL COMMENT 'table schema (maybe null)',
    `table_name`                VARCHAR(255) NULL COMMENT '表名称',
    `table_type`                VARCHAR(20)  NULL COMMENT '表类型. 常见类型包括"TABLE", "VIEW", "SYSTEM TABLE", "GLOBAL TEMPORARY", "LOCAL TEMPORARY", "ALIAS", "SYNONYM".',
    `remarks`                   VARCHAR(255) NULL COMMENT '该表的描述文本',
    `type_cat`                  VARCHAR(255) NULL COMMENT 'the types catalog (maybe null)',
    `type_schem`                VARCHAR(255) NULL COMMENT 'the types schema (maybe null)',
    `type_name`                 VARCHAR(255) NULL COMMENT '类型名称',
    `self_referencing_col_name` VARCHAR(255) NULL COMMENT 'name of the designated "identifier" column of a typed table (may be null)',
    `ref_generation`            VARCHAR(255) NULL COMMENT 'specifies how values in SELF_REFERENCING_COL_NAME are created. Values are "SYSTEM", "USER", "DERIVED". (may be null)'
) ENGINE = InnoDB
  AUTO_INCREMENT = 1
  DEFAULT CHARSET = utf8mb4 COMMENT ='数据库表信息记录表'
  ROW_FORMAT = Dynamic;

/**
  数据库表的列信息记录表
 */
DROP TABLE IF EXISTS `column_info`;
CREATE TABLE `column_info`
(
    `id`                bigint unsigned PRIMARY KEY AUTO_INCREMENT COMMENT '自增主键',
    `table_id`          bigint unsigned COMMENT '所属表的ID',
    `table_cat`         varchar(255)        DEFAULT NULL COMMENT 'table catalog (maybe null)',
    `table_schem`       varchar(255)        DEFAULT NULL COMMENT 'table schema (maybe null)',
    `table_name`        varchar(255)        DEFAULT NULL COMMENT '表名称',
    `column_name`       varchar(255)        DEFAULT NULL COMMENT '列名称',
    `data_type`         int(11)             DEFAULT NULL COMMENT 'SQL type from java.sql.Type',
    `type_name`         varchar(255)        DEFAULT NULL COMMENT '数据源独立的类型名称, for a UDT the type name is fully qualified',
    `column_size`       int(11)             DEFAULT NULL COMMENT 'column size.有符号数长度会减少1，比如bigint(20)，此时columnSize=19',
    `buffer_length`     int(11)             DEFAULT NULL COMMENT 'not used.',
    `decimal_digits`    int(11)             DEFAULT NULL COMMENT '小数位数',
    `num_prec_radix`    int(11)             DEFAULT NULL COMMENT 'NUM_PREC_RADIX int => Radix (typically either 10 or 2) (基数,即十进制或者二进制)',
    `nullable`          int(11) unsigned    DEFAULT NULL COMMENT '是否允许NULL. 0 - Indicates that the column definitely allows NULL values. 1 - Indicates that the column definitely allows NULL values. 2 - Indicates that the nullability of columns is unknown.',
    `remarks`           varchar(255)        DEFAULT NULL COMMENT '该列的描述信息，可为null',
    `column_def`        varchar(255)        DEFAULT NULL COMMENT '该列的默认值, 如果值被单引号引起来，则表示该值是字符串(maybe null)',
    `sql_data_type`     int(11)             DEFAULT NULL COMMENT 'unused',
    `sql_datetime_sub`  int(11)             DEFAULT NULL COMMENT 'unused',
    `char_octet_length` int(11)             DEFAULT NULL COMMENT '字符类型的最大字节数 CHAR_OCTET_LENGTH int => for char types the maximum number of bytes in the column',
    `ordinal_position`  int(11)             DEFAULT NULL COMMENT '该列在表中的位置，开始为1',
    `is_nullable`       tinyint(1) unsigned DEFAULT NULL COMMENT 'ISO rules are used to determine the nullability for a column. YES --- if the column can include NULLs NO --- if the column cannot include NULLs empty string --- if the nullability for the column is unknown',
    `scope_catalog`     varchar(255)        DEFAULT NULL COMMENT 'catalog of table that is the scope of a reference attribute (null if DATA_TYPE is not REF)',
    `scope_schema`      varchar(255)        DEFAULT NULL COMMENT 'schema of table that is the scope of a reference attribute (null if the DATA_TYPE is not REF)',
    `scope_table`       varchar(255)        DEFAULT NULL COMMENT 'table name that this the scope of a reference attribute (null if the DATA_TYPE is not REF)',
    `source_data_type`  varchar(255)        DEFAULT NULL COMMENT 'source type of distinct type or user-generated Ref type, SQL type from java.sql.Types (null if DATA_TYPE is not DISTINCT or user-generated REF)',
    `is_autoincrement`  tinyint(1) unsigned DEFAULT NULL COMMENT 'Indicates whether this column is auto incremented YES --- if the column is auto incremented NO --- if the column is not auto incremented empty string --- if it cannot be determined whether the column is auto incremented',
    `is_generated`      tinyint(1) unsigned DEFAULT NULL COMMENT 'Indicates whether this is a generated column YES --- if this a generated column NO --- if this not a generated column empty string --- if it cannot be determined whether this is a generated column'
) ENGINE = InnoDB
  AUTO_INCREMENT = 1
  DEFAULT CHARSET = utf8mb4 COMMENT ='数据库表列信息记录表'
  ROW_FORMAT = Dynamic;

ALTER TABLE devpl.datasource_info
    ADD database_name varchar(100) NULL COMMENT '数据库名称';
ALTER TABLE devpl.datasource_info
    ADD driver_props json NULL COMMENT '驱动属性';
