-- MySQL dump 10.13  Distrib 5.7.40, for Win64 (x86_64)
--
-- Host: localhost    Database: devpl
-- ------------------------------------------------------
-- Server version	5.7.40-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `column_info`
--

DROP TABLE IF EXISTS `column_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `column_info` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `table_id` bigint(20) unsigned DEFAULT NULL COMMENT '所属表的ID',
  `table_cat` varchar(255) DEFAULT NULL COMMENT 'table catalog (maybe null)',
  `table_schem` varchar(255) DEFAULT NULL COMMENT 'table schema (maybe null)',
  `table_name` varchar(255) DEFAULT NULL COMMENT '表名称',
  `column_name` varchar(255) DEFAULT NULL COMMENT '列名称',
  `data_type` int(11) DEFAULT NULL COMMENT 'SQL type from java.sql.Type',
  `type_name` varchar(255) DEFAULT NULL COMMENT '数据源独立的类型名称, for a UDT the type name is fully qualified',
  `column_size` int(11) DEFAULT NULL COMMENT 'column size.有符号数长度会减少1，比如bigint(20)，此时columnSize=19',
  `buffer_length` int(11) DEFAULT NULL COMMENT 'not used.',
  `decimal_digits` int(11) DEFAULT NULL COMMENT '小数位数',
  `num_prec_radix` int(11) DEFAULT NULL COMMENT 'NUM_PREC_RADIX int => Radix (typically either 10 or 2) (基数,即十进制或者二进制)',
  `nullable` int(11) unsigned DEFAULT NULL COMMENT '是否允许NULL. 0 - Indicates that the column definitely allows NULL values. 1 - Indicates that the column definitely allows NULL values. 2 - Indicates that the nullability of columns is unknown.',
  `remarks` varchar(255) DEFAULT NULL COMMENT '该列的描述信息，可为null',
  `column_def` varchar(255) DEFAULT NULL COMMENT '该列的默认值, 如果值被单引号引起来，则表示该值是字符串(maybe null)',
  `sql_data_type` int(11) DEFAULT NULL COMMENT 'unused',
  `sql_datetime_sub` int(11) DEFAULT NULL COMMENT 'unused',
  `char_octet_length` int(11) DEFAULT NULL COMMENT '字符类型的最大字节数 CHAR_OCTET_LENGTH int => for char types the maximum number of bytes in the column',
  `ordinal_position` int(11) DEFAULT NULL COMMENT '该列在表中的位置，开始为1',
  `is_nullable` tinyint(1) unsigned DEFAULT NULL COMMENT 'ISO rules are used to determine the nullability for a column. YES --- if the column can include NULLs NO --- if the column cannot include NULLs empty string --- if the nullability for the column is unknown',
  `scope_catalog` varchar(255) DEFAULT NULL COMMENT 'catalog of table that is the scope of a reference attribute (null if DATA_TYPE is not REF)',
  `scope_schema` varchar(255) DEFAULT NULL COMMENT 'schema of table that is the scope of a reference attribute (null if the DATA_TYPE is not REF)',
  `scope_table` varchar(255) DEFAULT NULL COMMENT 'table name that this the scope of a reference attribute (null if the DATA_TYPE is not REF)',
  `source_data_type` varchar(255) DEFAULT NULL COMMENT 'source type of distinct type or user-generated Ref type, SQL type from java.sql.Types (null if DATA_TYPE is not DISTINCT or user-generated REF)',
  `is_autoincrement` tinyint(1) unsigned DEFAULT NULL COMMENT 'Indicates whether this column is auto incremented YES --- if the column is auto incremented NO --- if the column is not auto incremented empty string --- if it cannot be determined whether the column is auto incremented',
  `is_generated` tinyint(1) unsigned DEFAULT NULL COMMENT 'Indicates whether this is a generated column YES --- if this a generated column NO --- if this not a generated column empty string --- if it cannot be determined whether this is a generated column',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='数据库表列信息记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `column_info`
--

LOCK TABLES `column_info` WRITE;
/*!40000 ALTER TABLE `column_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `column_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `connection_config`
--

DROP TABLE IF EXISTS `connection_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `connection_config` (
  `id` varchar(36) NOT NULL COMMENT '主键ID',
  `name` varchar(255) DEFAULT NULL COMMENT '连接名称',
  `host` varchar(255) DEFAULT NULL COMMENT '主机地址，IP地址',
  `port` varchar(255) DEFAULT NULL COMMENT '端口号',
  `db_type` varchar(255) DEFAULT NULL COMMENT '数据库类型',
  `db_name` varchar(255) DEFAULT NULL COMMENT '数据库名称',
  `username` varchar(255) DEFAULT NULL COMMENT '用户名',
  `password` varchar(255) DEFAULT NULL COMMENT '密码',
  `encoding` varchar(255) DEFAULT NULL COMMENT '连接编码',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unk_conn_name` (`name`),
  UNIQUE KEY `unk_ip_port` (`host`,`port`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='连接配置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `connection_config`
--

LOCK TABLES `connection_config` WRITE;
/*!40000 ALTER TABLE `connection_config` DISABLE KEYS */;
INSERT INTO `connection_config` VALUES ('01H320PDJQGCW97923WYYYJESA','127.0.0.1_3306','127.0.0.1','3307','MySQL8','MYSQL5','null','root','123456'),('9c4c93ee-c0d6-4b10-b83d-2702756c6d11','127.0.0.1-3306-MySQL5','127.0.0.1','3306','MySQL5',NULL,'root','123456','utf8');
/*!40000 ALTER TABLE `connection_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_type_group`
--

DROP TABLE IF EXISTS `data_type_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_type_group` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `group_id` varchar(255) DEFAULT NULL COMMENT '分组ID',
  `group_name` varchar(255) DEFAULT NULL COMMENT '分组名称',
  `internal` tinyint(4) DEFAULT '0' COMMENT '是否内置类型分组，内置类型分组不可更改',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `is_deleted` tinyint(4) DEFAULT '0' COMMENT '是否逻辑删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COMMENT='数据类型分组';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_type_group`
--

LOCK TABLES `data_type_group` WRITE;
/*!40000 ALTER TABLE `data_type_group` DISABLE KEYS */;
INSERT INTO `data_type_group` VALUES (1,'JSON','标准JSON类型',1,NULL,NULL,0),(2,'JDBC','JDBC类型',1,NULL,NULL,0),(3,'JAVA','Java类型',1,NULL,NULL,0);
/*!40000 ALTER TABLE `data_type_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_type_item`
--

DROP TABLE IF EXISTS `data_type_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_type_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `type_group_id` varchar(255) DEFAULT NULL COMMENT '类型分组名称',
  `type_key` varchar(255) DEFAULT NULL COMMENT '类型ID',
  `type_name` varchar(255) DEFAULT NULL COMMENT '类型名称',
  `value_type` varchar(255) DEFAULT NULL COMMENT '该数据类型的值类型',
  `min_length` double DEFAULT NULL COMMENT '最小长度',
  `max_length` double DEFAULT NULL COMMENT '最大长度',
  `default_value` varchar(255) DEFAULT NULL COMMENT '类型默认值',
  `precision` varchar(255) DEFAULT NULL COMMENT '精度',
  `remark` varchar(255) DEFAULT NULL COMMENT '描述信息',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `is_deleted` tinyint(1) unsigned zerofill DEFAULT NULL COMMENT '是否删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=148 DEFAULT CHARSET=utf8mb4 COMMENT='数据类型表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_type_item`
--

LOCK TABLES `data_type_item` WRITE;
/*!40000 ALTER TABLE `data_type_item` DISABLE KEYS */;
INSERT INTO `data_type_item` VALUES (144,'JSON','JsonNumber','JSON数字类型',NULL,10,50,'0','3434','dfsvssvdsvd',NULL,'2023-10-21 10:20:55',NULL),(145,'JSON','JsonString','JSON字符串',NULL,NULL,NULL,'','','JSON字符串',NULL,'2023-10-21 10:06:05',NULL),(146,'JSON','JsonNumber','JSON数字类型',NULL,NULL,NULL,'0','3434','sdfwe',NULL,NULL,NULL),(147,'','','',NULL,0,0,'0','','',NULL,NULL,NULL);
/*!40000 ALTER TABLE `data_type_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_type_mapping`
--

DROP TABLE IF EXISTS `data_type_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_type_mapping` (
  `id` bigint(20) NOT NULL COMMENT '主键ID',
  `type_id` bigint(20) DEFAULT NULL COMMENT '主数据类型ID',
  `another_type_id` bigint(20) DEFAULT NULL COMMENT '映射数据类型ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='数据类型映射关系表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_type_mapping`
--

LOCK TABLES `data_type_mapping` WRITE;
/*!40000 ALTER TABLE `data_type_mapping` DISABLE KEYS */;
/*!40000 ALTER TABLE `data_type_mapping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `database_backup_history`
--

DROP TABLE IF EXISTS `database_backup_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `database_backup_history` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `save_location` varchar(255) DEFAULT NULL COMMENT '保存位置',
  `backup_time` datetime DEFAULT NULL COMMENT '备份时间',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `database_backup_history`
--

LOCK TABLES `database_backup_history` WRITE;
/*!40000 ALTER TABLE `database_backup_history` DISABLE KEYS */;
INSERT INTO `database_backup_history` VALUES (1,'D:\\Develop\\Code\\Github\\devpl-backend\\devpl-backend\\db\\backup\\devpl-20231022102818.sql','2023-10-22 10:28:19','2023-10-22 10:28:18'),(2,'D:\\Develop\\Code\\Github\\devpl-backend\\devpl-backend\\db\\backup\\devpl-20231022103801.sql','2023-10-22 10:38:01','2023-10-22 10:38:01'),(3,'D:\\Develop\\Code\\Github\\devpl-backend\\devpl-backend\\db\\backup\\devpl-20231022103906.sql','2023-10-22 10:39:06','2023-10-22 10:39:06'),(4,'D:\\Develop\\Code\\Github\\devpl-backend\\devpl-backend\\db\\backup\\devpl-20231022115533.sql','2023-10-22 11:55:34','2023-10-22 11:55:34'),(5,'D:\\Develop\\Code\\Github\\devpl-backend\\devpl-backend\\db\\backup\\devpl-20231022153037.sql','2023-10-22 15:30:38','2023-10-22 15:30:37'),(6,'D:\\Develop\\Code\\Github\\devpl-backend\\devpl-backend\\db\\backup\\devpl-20231022153202.sql','2023-10-22 15:32:03','2023-10-22 15:32:03'),(7,'D:\\Develop\\Code\\Github\\devpl-backend\\devpl-backend\\db\\backup\\devpl-20231022164904.sql','2023-10-22 16:49:05','2023-10-22 16:49:04'),(8,'D:\\Develop\\Code\\Github\\devpl-backend\\devpl-backend\\db\\backup\\devpl-20231022171500.sql','2023-10-22 17:15:01','2023-10-22 17:15:01'),(9,'D:\\Develop\\Code\\Github\\devpl-backend\\devpl-backend\\db\\backup\\devpl-20231022171931.sql','2023-10-22 17:19:32','2023-10-22 17:19:31');
/*!40000 ALTER TABLE `database_backup_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `datasource_info`
--

DROP TABLE IF EXISTS `datasource_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `datasource_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `db_type` varchar(200) DEFAULT NULL COMMENT '数据库类型',
  `database_name` varchar(100) DEFAULT NULL COMMENT '数据库名称',
  `conn_name` varchar(200) NOT NULL COMMENT '连接名',
  `conn_url` varchar(500) DEFAULT NULL COMMENT 'URL',
  `username` varchar(200) DEFAULT NULL COMMENT '用户名',
  `password` varchar(200) DEFAULT NULL COMMENT '密码',
  `driver_props` json DEFAULT NULL COMMENT '驱动属性',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COMMENT='数据源管理';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `datasource_info`
--

LOCK TABLES `datasource_info` WRITE;
/*!40000 ALTER TABLE `datasource_info` DISABLE KEYS */;
INSERT INTO `datasource_info` VALUES (1,'MySQL',NULL,'lgdb_campusintelligentportrait','jdbc:mysql://192.168.129.82:3306/lgdb_campusintelligentportrait?useUnicode=true&characterEncoding=UTF-8&useSSL=true&serverTimezone=GMT%2B8','root','LancooECP',NULL,'2023-08-01 09:34:10'),(2,'MySQL',NULL,'lgdb_univ_exam_management','jdbc:mysql://192.168.129.82:3306/lgdb_univ_exam_management?useUnicode=true&characterEncoding=UTF-8&useSSL=true&serverTimezone=GMT%2B8','root','LancooECP',NULL,'2023-09-22 15:52:53'),(3,'MySQL','','1212','sdff','root','123456',NULL,'2023-10-09 19:32:36'),(4,'MySQL','','sdfdfs','123456','root','123456',NULL,'2023-10-09 19:33:56'),(5,'MySQL','1121212','12','sfds122','root','123456',NULL,'2023-10-09 20:10:54');
/*!40000 ALTER TABLE `datasource_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dbs`
--

DROP TABLE IF EXISTS `dbs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dbs` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `value` json DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COMMENT='数据库信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dbs`
--

LOCK TABLES `dbs` WRITE;
/*!40000 ALTER TABLE `dbs` DISABLE KEYS */;
INSERT INTO `dbs` VALUES (2,'mysql_learn','{\"host\": \"127.0.0.1\", \"name\": \"mysql_learn\", \"port\": \"3306\", \"dbType\": \"MySQL5\", \"schema\": \"mysql_learn\", \"encoding\": \"utf8\", \"password\": \"123456\", \"username\": \"root\"}'),(3,'ruoyi','{\"host\": \"127.0.0.1\", \"name\": \"ruoyi\", \"port\": \"3306\", \"dbType\": \"MySQL5\", \"schema\": \"ruoyi\", \"encoding\": \"utf8\", \"password\": \"123456\", \"username\": \"root\"}');
/*!40000 ALTER TABLE `dbs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_info`
--

DROP TABLE IF EXISTS `field_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_info` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `field_key` varchar(36) NOT NULL COMMENT '字段ID',
  `field_name` varchar(100) DEFAULT NULL COMMENT '字段名',
  `data_type` varchar(100) DEFAULT NULL COMMENT '数据类型',
  `description` varchar(100) DEFAULT NULL COMMENT '描述信息',
  `field_value` varchar(100) DEFAULT NULL COMMENT '默认值',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `is_deleted` tinyint(1) DEFAULT NULL COMMENT '是否删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COMMENT='字段信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_info`
--

LOCK TABLES `field_info` WRITE;
/*!40000 ALTER TABLE `field_info` DISABLE KEYS */;
INSERT INTO `field_info` VALUES (1,'sdfsd','sdfsd','int','1212','1212',NULL,NULL,NULL),(2,'userName','userName','int','','',NULL,NULL,NULL),(3,'ewwe','ewwe','int','','',NULL,NULL,NULL),(4,'sdfsdf','sdfsdf','int','','',NULL,NULL,NULL),(5,'fgdsf','fgdsf','int','','',NULL,NULL,NULL),(6,'sdsd','sdsd','int','','',NULL,NULL,NULL),(7,'dsfsdfd','dsfsdfd','int','','',NULL,NULL,NULL),(8,'gdfs','gdfs','int','','',NULL,NULL,NULL),(9,'gdfdgf','gdfdgf','int','','',NULL,NULL,NULL),(10,'42323','42323','int','','',NULL,NULL,NULL),(11,'hngh','hngh','int','','',NULL,NULL,NULL);
/*!40000 ALTER TABLE `field_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `file_gen_group`
--

DROP TABLE IF EXISTS `file_gen_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `file_gen_group` (
  `group_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id, 多个文件生成',
  `group_name` varchar(200) DEFAULT NULL COMMENT '表名',
  `file_id` varchar(200) DEFAULT NULL COMMENT '生成文件ID,关联template_file_generatioin表主键ID',
  `table_comment` varchar(200) DEFAULT NULL COMMENT '说明',
  `author` varchar(200) DEFAULT NULL COMMENT '作者',
  `email` varchar(200) DEFAULT NULL COMMENT '邮箱',
  `package_name` varchar(200) DEFAULT NULL COMMENT '项目包名',
  `version` varchar(200) DEFAULT NULL COMMENT '项目版本号',
  `generator_type` tinyint(4) DEFAULT NULL COMMENT '生成方式  0：zip压缩包   1：自定义目录',
  `backend_path` varchar(500) DEFAULT NULL COMMENT '后端生成路径',
  `frontend_path` varchar(500) DEFAULT NULL COMMENT '前端生成路径',
  `module_name` varchar(200) DEFAULT NULL COMMENT '模块名',
  `function_name` varchar(200) DEFAULT NULL COMMENT '功能名',
  `form_layout` tinyint(4) DEFAULT NULL COMMENT '表单布局  1：一列   2：两列',
  `datasource_id` bigint(20) DEFAULT NULL COMMENT '数据源ID',
  `baseclass_id` bigint(20) DEFAULT NULL COMMENT '基类ID',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='文件生成组记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `file_gen_group`
--

LOCK TABLES `file_gen_group` WRITE;
/*!40000 ALTER TABLE `file_gen_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `file_gen_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gen_base_class`
--

DROP TABLE IF EXISTS `gen_base_class`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gen_base_class` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `package_name` varchar(200) DEFAULT NULL COMMENT '基类包名',
  `code` varchar(200) DEFAULT NULL COMMENT '基类编码',
  `fields` varchar(500) DEFAULT NULL COMMENT '基类字段，多个用英文逗号分隔',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='基类管理';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gen_base_class`
--

LOCK TABLES `gen_base_class` WRITE;
/*!40000 ALTER TABLE `gen_base_class` DISABLE KEYS */;
INSERT INTO `gen_base_class` VALUES (1,'net.maku.framework.mybatis.entity','BaseEntity','id,creator,create_time,updater,update_time,version,deleted','使用该基类，则需要表里有这些字段','2023-06-30 10:25:16');
/*!40000 ALTER TABLE `gen_base_class` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gen_field_type`
--

DROP TABLE IF EXISTS `gen_field_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gen_field_type` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `column_type` varchar(200) DEFAULT NULL COMMENT '字段类型',
  `attr_type` varchar(200) DEFAULT NULL COMMENT '属性类型',
  `package_name` varchar(200) DEFAULT NULL COMMENT '属性包名',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `json_type` varchar(100) DEFAULT NULL COMMENT 'JSON数据类型',
  `mysql_sql_type` varchar(100) DEFAULT NULL COMMENT 'MySQL SQL数据类型',
  PRIMARY KEY (`id`),
  UNIQUE KEY `column_type` (`column_type`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COMMENT='字段类型管理';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gen_field_type`
--

LOCK TABLES `gen_field_type` WRITE;
/*!40000 ALTER TABLE `gen_field_type` DISABLE KEYS */;
INSERT INTO `gen_field_type` VALUES (1,'datetime','Date','java.util.Date','2023-06-30 10:25:16',NULL,NULL),(2,'date','Date','java.util.Date','2023-06-30 10:25:16',NULL,NULL),(3,'tinyint','Integer',NULL,'2023-06-30 10:25:16',NULL,NULL),(4,'smallint','Integer',NULL,'2023-06-30 10:25:16',NULL,NULL),(5,'mediumint','Integer',NULL,'2023-06-30 10:25:16',NULL,NULL),(6,'int','Integer',NULL,'2023-06-30 10:25:16',NULL,NULL),(7,'integer','Integer',NULL,'2023-06-30 10:25:16',NULL,NULL),(8,'bigint','Long',NULL,'2023-06-30 10:25:16',NULL,NULL),(9,'float','Float',NULL,'2023-06-30 10:25:16',NULL,NULL),(10,'double','Double',NULL,'2023-06-30 10:25:16',NULL,NULL),(11,'decimal','BigDecimal','java.math.BigDecimal','2023-06-30 10:25:16',NULL,NULL),(12,'bit','Boolean',NULL,'2023-06-30 10:25:16',NULL,NULL),(13,'char','String',NULL,'2023-06-30 10:25:16',NULL,NULL),(14,'varchar','String',NULL,'2023-06-30 10:25:16',NULL,NULL),(15,'tinytext','String',NULL,'2023-06-30 10:25:16',NULL,NULL),(16,'text','String',NULL,'2023-06-30 10:25:16',NULL,NULL),(17,'mediumtext','String',NULL,'2023-06-30 10:25:16',NULL,NULL),(18,'longtext','String',NULL,'2023-06-30 10:25:16',NULL,NULL),(19,'timestamp','Date','java.util.Date','2023-06-30 10:25:16',NULL,NULL),(20,'NUMBER','Integer',NULL,'2023-06-30 10:25:16',NULL,NULL),(21,'BINARY_INTEGER','Integer',NULL,'2023-06-30 10:25:16',NULL,NULL),(22,'BINARY_FLOAT','Float',NULL,'2023-06-30 10:25:16',NULL,NULL),(23,'BINARY_DOUBLE','Double',NULL,'2023-06-30 10:25:16',NULL,NULL),(24,'VARCHAR2','String',NULL,'2023-06-30 10:25:16',NULL,NULL),(25,'NVARCHAR','String',NULL,'2023-06-30 10:25:16',NULL,NULL),(26,'NVARCHAR2','String',NULL,'2023-06-30 10:25:16',NULL,NULL),(27,'CLOB','String',NULL,'2023-06-30 10:25:16',NULL,NULL),(28,'int8','Long',NULL,'2023-06-30 10:25:16',NULL,NULL),(29,'int4','Integer',NULL,'2023-06-30 10:25:16',NULL,NULL),(30,'int2','Integer','11111','2023-06-30 10:25:16',NULL,NULL),(31,'numeric','BigDecimal','java.math.BigDecimal','2023-06-30 10:25:16',NULL,NULL),(32,'',NULL,NULL,'2023-10-21 19:51:34',NULL,NULL);
/*!40000 ALTER TABLE `gen_field_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gen_project_modify`
--

DROP TABLE IF EXISTS `gen_project_modify`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gen_project_modify` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `project_name` varchar(100) DEFAULT NULL COMMENT '项目名',
  `project_code` varchar(100) DEFAULT NULL COMMENT '项目标识',
  `project_package` varchar(100) DEFAULT NULL COMMENT '项目包名',
  `project_path` varchar(200) DEFAULT NULL COMMENT '项目路径',
  `modify_project_name` varchar(100) DEFAULT NULL COMMENT '变更项目名',
  `modify_project_code` varchar(100) DEFAULT NULL COMMENT '变更标识',
  `modify_project_package` varchar(100) DEFAULT NULL COMMENT '变更包名',
  `exclusions` varchar(200) DEFAULT NULL COMMENT '排除文件',
  `modify_suffix` varchar(200) DEFAULT NULL COMMENT '变更文件',
  `modify_tmp_path` varchar(100) DEFAULT NULL COMMENT '变更临时路径',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COMMENT='项目名变更';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gen_project_modify`
--

LOCK TABLES `gen_project_modify` WRITE;
/*!40000 ALTER TABLE `gen_project_modify` DISABLE KEYS */;
INSERT INTO `gen_project_modify` VALUES (1,'maku-boot','maku','net.maku','D:/makunet/maku-boot','baba-boot','baba','com.baba','.git,.idea,target,logs','java,xml,yml,txt',NULL,'2023-06-30 10:25:16'),(2,'maku-cloud','maku','net.maku','D:/makunet/maku-cloud','baba-cloud','baba','com.baba','.git,.idea,target,logs','java,xml,yml,txt',NULL,'2023-06-30 10:25:16');
/*!40000 ALTER TABLE `gen_project_modify` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gen_table`
--

DROP TABLE IF EXISTS `gen_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gen_table` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `table_name` varchar(200) DEFAULT NULL COMMENT '表名',
  `class_name` varchar(200) DEFAULT NULL COMMENT '类名',
  `table_comment` varchar(200) DEFAULT NULL COMMENT '说明',
  `author` varchar(200) DEFAULT NULL COMMENT '作者',
  `email` varchar(200) DEFAULT NULL COMMENT '邮箱',
  `package_name` varchar(200) DEFAULT NULL COMMENT '项目包名',
  `version` varchar(200) DEFAULT NULL COMMENT '项目版本号',
  `generator_type` tinyint(4) DEFAULT NULL COMMENT '生成方式  0：zip压缩包   1：自定义目录',
  `backend_path` varchar(500) DEFAULT NULL COMMENT '后端生成路径',
  `frontend_path` varchar(500) DEFAULT NULL COMMENT '前端生成路径',
  `module_name` varchar(200) DEFAULT NULL COMMENT '模块名',
  `function_name` varchar(200) DEFAULT NULL COMMENT '功能名',
  `form_layout` tinyint(4) DEFAULT NULL COMMENT '表单布局  1：一列   2：两列',
  `datasource_id` bigint(20) DEFAULT NULL COMMENT '数据源ID',
  `baseclass_id` bigint(20) DEFAULT NULL COMMENT '基类ID',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `table_name` (`table_name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COMMENT='代码生成表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gen_table`
--

LOCK TABLES `gen_table` WRITE;
/*!40000 ALTER TABLE `gen_table` DISABLE KEYS */;
INSERT INTO `gen_table` VALUES (1,'data_type_group','DataTypeGroup','数据类型分组','vonlinee','vonlinee@163.com','io.devpl','1.0.0',0,'backend','frontend','devpl','group',1,0,NULL,'2023-10-12 09:08:50'),(2,'data_type_item','DataTypeItem','数据类型表','vonlinee','vonlinee@163.com','io.devpl','1.0.0',1,'backend','frontend','devpl','item',1,0,NULL,'2023-10-12 09:08:50'),(3,'data_type_mapping','DataTypeMapping','数据类型映射关系表','vonlinee','vonlinee@163.com','io.devpl','1.0.0',1,'backend','frontend','devpl','mapping',1,0,NULL,'2023-10-12 09:08:50');
/*!40000 ALTER TABLE `gen_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gen_table_field`
--

DROP TABLE IF EXISTS `gen_table_field`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gen_table_field` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `table_id` bigint(20) DEFAULT NULL COMMENT '表ID',
  `field_name` varchar(200) DEFAULT NULL COMMENT '字段名称',
  `field_type` varchar(200) DEFAULT NULL COMMENT '字段类型',
  `field_comment` varchar(200) DEFAULT NULL COMMENT '字段说明',
  `attr_name` varchar(200) DEFAULT NULL COMMENT '属性名',
  `attr_type` varchar(200) DEFAULT NULL COMMENT '属性类型',
  `package_name` varchar(200) DEFAULT NULL COMMENT '属性包名',
  `sort` int(11) DEFAULT NULL COMMENT '排序',
  `auto_fill` varchar(20) DEFAULT NULL COMMENT '自动填充  DEFAULT、INSERT、UPDATE、INSERT_UPDATE',
  `primary_key` tinyint(4) DEFAULT NULL COMMENT '主键 0：否  1：是',
  `base_field` tinyint(4) DEFAULT NULL COMMENT '基类字段 0：否  1：是',
  `form_item` tinyint(4) DEFAULT NULL COMMENT '表单项 0：否  1：是',
  `form_required` tinyint(4) DEFAULT NULL COMMENT '表单必填 0：否  1：是',
  `form_type` varchar(200) DEFAULT NULL COMMENT '表单类型',
  `form_dict` varchar(200) DEFAULT NULL COMMENT '表单字典类型',
  `form_validator` varchar(200) DEFAULT NULL COMMENT '表单效验',
  `grid_item` tinyint(4) DEFAULT NULL COMMENT '列表项 0：否  1：是',
  `grid_sort` tinyint(4) DEFAULT NULL COMMENT '列表排序 0：否  1：是',
  `query_item` tinyint(4) DEFAULT NULL COMMENT '查询项 0：否  1：是',
  `query_type` varchar(200) DEFAULT NULL COMMENT '查询方式',
  `query_form_type` varchar(200) DEFAULT NULL COMMENT '查询表单类型',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COMMENT='代码生成表字段';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gen_table_field`
--

LOCK TABLES `gen_table_field` WRITE;
/*!40000 ALTER TABLE `gen_table_field` DISABLE KEYS */;
INSERT INTO `gen_table_field` VALUES (1,1,'id','bigint','主键','id','Long',NULL,0,'DEFAULT',1,0,1,0,'text',NULL,NULL,1,0,0,'=','text'),(2,1,'group_id','int','分组ID','groupId','Integer',NULL,1,'DEFAULT',0,0,1,0,'text',NULL,NULL,1,0,0,'=','text'),(3,1,'group_name','varchar','分组名称','groupName','String',NULL,2,'DEFAULT',0,0,1,0,'text',NULL,NULL,1,0,0,'=','text'),(4,2,'id','bigint','主键ID','id','Long',NULL,0,'DEFAULT',1,0,1,0,'text',NULL,NULL,1,0,0,'=','text'),(5,2,'type_group_id','varchar','类型分组名称','typeGroupId','String',NULL,1,'DEFAULT',0,0,1,0,'text',NULL,NULL,1,0,0,'=','text'),(6,2,'type_key','varchar','类型ID','typeKey','String',NULL,2,'DEFAULT',0,0,1,0,'text',NULL,NULL,1,0,0,'=','text'),(7,2,'type_name','varchar','类型名称','typeName','String',NULL,3,'DEFAULT',0,0,1,0,'text',NULL,NULL,1,0,0,'=','text'),(8,2,'value_type','varchar','该数据类型的值类型','valueType','String',NULL,4,'DEFAULT',0,0,1,0,'text',NULL,NULL,1,0,0,'=','text'),(9,2,'min_length','double','最小长度','minLength','Double',NULL,5,'DEFAULT',0,0,1,0,'text',NULL,NULL,1,0,0,'=','text'),(10,2,'max_length','double','最大长度','maxLength','Double',NULL,6,'DEFAULT',0,0,1,0,'text',NULL,NULL,1,0,0,'=','text'),(11,2,'default_value','varchar','类型默认值','defaultValue','String',NULL,7,'DEFAULT',0,0,1,0,'text',NULL,NULL,1,0,0,'=','text'),(12,2,'precision','varchar','精度','precision','String',NULL,8,'DEFAULT',0,0,1,0,'text',NULL,NULL,1,0,0,'=','text'),(13,2,'create_time','datetime','创建时间','createTime','Date','java.util.Date',9,'DEFAULT',0,0,1,0,'text',NULL,NULL,1,0,0,'=','text'),(14,2,'update_time','datetime','更新时间','updateTime','Date','java.util.Date',10,'DEFAULT',0,0,1,0,'text',NULL,NULL,1,0,0,'=','text'),(15,2,'is_deleted','tinyint','是否删除','isDeleted','Integer',NULL,11,'DEFAULT',0,0,1,0,'text',NULL,NULL,1,0,0,'=','text'),(16,3,'id','int','主键ID','id','Integer',NULL,0,'DEFAULT',1,0,1,0,'text',NULL,NULL,1,0,0,'=','text'),(17,3,'type_key','varchar','SQL数据类型','typeKey','String',NULL,1,'DEFAULT',0,0,1,0,'text',NULL,NULL,1,0,0,'=','text');
/*!40000 ALTER TABLE `gen_table_field` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gen_test_student`
--

DROP TABLE IF EXISTS `gen_test_student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gen_test_student` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '学生ID',
  `name` varchar(50) DEFAULT NULL COMMENT '姓名',
  `gender` tinyint(4) DEFAULT NULL COMMENT '性别',
  `age` int(11) DEFAULT NULL COMMENT '年龄',
  `class_name` varchar(50) DEFAULT NULL COMMENT '班级',
  `version` int(11) DEFAULT NULL COMMENT '版本号',
  `deleted` tinyint(4) DEFAULT NULL COMMENT '删除标识',
  `creator` bigint(20) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` bigint(20) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='测试2';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gen_test_student`
--

LOCK TABLES `gen_test_student` WRITE;
/*!40000 ALTER TABLE `gen_test_student` DISABLE KEYS */;
/*!40000 ALTER TABLE `gen_test_student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `generator_config`
--

DROP TABLE IF EXISTS `generator_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `generator_config` (
  `name` text,
  `value` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='代码生成配置信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `generator_config`
--

LOCK TABLES `generator_config` WRITE;
/*!40000 ALTER TABLE `generator_config` DISABLE KEYS */;
INSERT INTO `generator_config` VALUES ('蓝鸽','{\"name\":\"蓝鸽\",\"projectRootFolder\":\"D:\\\\Temp\",\"parentPackage\":\"com.lancoo.campuspotrait\",\"entityPackageName\":\"entity\",\"entityPackageFolder\":\"src/main/java\",\"mapperPackageName\":\"mapper\",\"mapperFolder\":\"src/main/java\",\"mapperXmlPackage\":\"mapping\",\"mapperXmlFolder\":\"src/main/resources\",\"authors\":null,\"projectLayout\":null}');
/*!40000 ALTER TABLE `generator_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `input_history`
--

DROP TABLE IF EXISTS `input_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `input_history` (
  `pid` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `item_key` varchar(100) DEFAULT NULL COMMENT '输入位置',
  `item_value` varchar(100) DEFAULT NULL COMMENT '输入值',
  PRIMARY KEY (`pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='输入历史';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `input_history`
--

LOCK TABLES `input_history` WRITE;
/*!40000 ALTER TABLE `input_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `input_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project`
--

DROP TABLE IF EXISTS `project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project` (
  `project_id` varchar(100) DEFAULT NULL COMMENT '项目ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='项目信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project`
--

LOCK TABLES `project` WRITE;
/*!40000 ALTER TABLE `project` DISABLE KEYS */;
/*!40000 ALTER TABLE `project` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `province_city_district`
--

DROP TABLE IF EXISTS `province_city_district`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `province_city_district` (
  `id` int(11) NOT NULL COMMENT '地区代码',
  `pid` int(11) DEFAULT NULL COMMENT '当前地区的上一级地区代码',
  `name` varchar(10) DEFAULT NULL COMMENT '地区名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='省市县数据表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `province_city_district`
--

LOCK TABLES `province_city_district` WRITE;
/*!40000 ALTER TABLE `province_city_district` DISABLE KEYS */;
INSERT INTO `province_city_district` VALUES (11,0,'北京'),(12,0,'天津'),(13,0,'河北'),(14,0,'山西'),(15,0,'内蒙古'),(21,0,'辽宁'),(22,0,'吉林'),(23,0,'黑龙江'),(31,0,'上海'),(32,0,'江苏'),(33,0,'浙江'),(34,0,'安徽'),(35,0,'福建'),(36,0,'江西'),(37,0,'山东'),(41,0,'河南'),(42,0,'湖北'),(43,0,'湖南'),(44,0,'广东'),(45,0,'广西'),(46,0,'海南'),(50,0,'重庆'),(51,0,'四川'),(52,0,'贵州'),(53,0,'云南'),(54,0,'西藏'),(61,0,'陕西'),(62,0,'甘肃'),(63,0,'青海'),(64,0,'宁夏'),(65,0,'新疆'),(71,0,'台湾'),(81,0,'香港'),(91,0,'澳门'),(1101,11,'北京市辖'),(1102,11,'北京县辖'),(1201,12,'天津市辖'),(1202,12,'天津县辖'),(1301,13,'石家庄'),(1302,13,'唐山'),(1303,13,'秦皇岛'),(1304,13,'邯郸'),(1305,13,'邢台'),(1306,13,'保定'),(1307,13,'张家口'),(1308,13,'承德'),(1309,13,'沧州'),(1310,13,'廊坊'),(1311,13,'衡水'),(1401,14,'太原'),(1402,14,'大同'),(1403,14,'阳泉'),(1404,14,'长治'),(1405,14,'晋城'),(1406,14,'朔州'),(1407,14,'晋中'),(1408,14,'运城'),(1409,14,'忻州'),(1410,14,'临汾'),(1423,14,'吕梁地区'),(1501,15,'呼和浩特'),(1502,15,'包头'),(1503,15,'乌海'),(1504,15,'赤峰'),(1505,15,'通辽'),(1521,15,'呼伦贝尔盟'),(1522,15,'兴安盟'),(1525,15,'锡林郭勒盟'),(1526,15,'乌兰察布盟'),(1527,15,'伊克昭盟'),(1528,15,'巴彦淖尔盟'),(1529,15,'阿拉善盟'),(2101,21,'沈阳'),(2102,21,'大连'),(2103,21,'鞍山'),(2104,21,'抚顺'),(2105,21,'本溪'),(2106,21,'丹东'),(2107,21,'锦州'),(2108,21,'营口'),(2109,21,'阜新'),(2110,21,'辽阳'),(2111,21,'盘锦'),(2112,21,'铁岭'),(2113,21,'朝阳'),(2114,21,'葫芦岛'),(2201,22,'长春'),(2202,22,'吉林'),(2203,22,'四平'),(2204,22,'辽源'),(2205,22,'通化'),(2206,22,'白山'),(2207,22,'松原'),(2208,22,'白城'),(2224,22,'延边朝鲜族自治州'),(2301,23,'哈尔滨'),(2302,23,'齐齐哈尔'),(2303,23,'鸡西'),(2304,23,'鹤岗'),(2305,23,'双鸭山'),(2306,23,'大庆'),(2307,23,'伊春'),(2308,23,'佳木斯'),(2309,23,'七台河'),(2310,23,'牡丹江'),(2311,23,'黑河'),(2312,23,'绥化'),(2327,23,'大兴安岭地区'),(3101,31,'上海市辖'),(3102,31,'上海县辖'),(3201,32,'南京'),(3202,32,'无锡'),(3203,32,'徐州'),(3204,32,'常州'),(3205,32,'苏州'),(3206,32,'南通'),(3207,32,'连云港'),(3208,32,'淮安'),(3209,32,'盐城'),(3210,32,'扬州'),(3211,32,'镇江'),(3212,32,'泰州'),(3213,32,'宿迁'),(3301,33,'杭州'),(3302,33,'宁波'),(3303,33,'温州'),(3304,33,'嘉兴'),(3305,33,'湖州'),(3306,33,'绍兴'),(3307,33,'金华'),(3308,33,'衢州'),(3309,33,'舟山'),(3310,33,'台州'),(3311,33,'丽水'),(3401,34,'合肥'),(3402,34,'芜湖'),(3403,34,'蚌埠'),(3404,34,'淮南'),(3405,34,'马鞍山'),(3406,34,'淮北'),(3407,34,'铜陵'),(3408,34,'安庆'),(3410,34,'黄山'),(3411,34,'滁州'),(3412,34,'阜阳'),(3413,34,'宿州'),(3414,34,'巢湖'),(3415,34,'六安'),(3416,34,'亳州'),(3417,34,'池州'),(3418,34,'宣城'),(3501,35,'福州'),(3502,35,'厦门'),(3503,35,'莆田'),(3504,35,'三明'),(3505,35,'泉州'),(3506,35,'漳州'),(3507,35,'南平'),(3508,35,'龙岩'),(3509,35,'宁德'),(3601,36,'南昌'),(3602,36,'景德镇'),(3603,36,'萍乡'),(3604,36,'九江'),(3605,36,'新余'),(3606,36,'鹰潭'),(3607,36,'赣州'),(3608,36,'吉安'),(3609,36,'宜春'),(3610,36,'抚州'),(3611,36,'上饶'),(3701,37,'济南'),(3702,37,'青岛'),(3703,37,'淄博'),(3704,37,'枣庄'),(3705,37,'东营'),(3706,37,'烟台'),(3707,37,'潍坊'),(3708,37,'济宁'),(3709,37,'泰安'),(3710,37,'威海'),(3711,37,'日照'),(3712,37,'莱芜'),(3713,37,'临沂'),(3714,37,'德州'),(3715,37,'聊城'),(3716,37,'滨州'),(3717,37,'菏泽'),(4101,41,'郑州'),(4102,41,'开封'),(4103,41,'洛阳'),(4104,41,'平顶山'),(4105,41,'安阳'),(4106,41,'鹤壁'),(4107,41,'新乡'),(4108,41,'焦作'),(4109,41,'濮阳'),(4110,41,'许昌'),(4111,41,'漯河'),(4112,41,'三门峡'),(4113,41,'南阳'),(4114,41,'商丘'),(4115,41,'信阳'),(4116,41,'周口'),(4117,41,'驻马店'),(4201,42,'武汉'),(4202,42,'黄石'),(4203,42,'十堰'),(4205,42,'宜昌'),(4206,42,'襄樊'),(4207,42,'鄂州'),(4208,42,'荆门'),(4209,42,'孝感'),(4210,42,'荆州'),(4211,42,'黄冈'),(4212,42,'咸宁'),(4213,42,'随州'),(4228,42,'恩施土家族苗族自治州'),(4290,42,'省直辖行政单位'),(4301,43,'长沙'),(4302,43,'株洲'),(4303,43,'湘潭'),(4304,43,'衡阳'),(4305,43,'邵阳'),(4306,43,'岳阳'),(4307,43,'常德'),(4308,43,'张家界'),(4309,43,'益阳'),(4310,43,'郴州'),(4311,43,'永州'),(4312,43,'怀化'),(4313,43,'娄底'),(4331,43,'湘西土家族苗族自治州'),(4401,44,'广州'),(4402,44,'韶关'),(4403,44,'深圳'),(4404,44,'珠海'),(4405,44,'汕头'),(4406,44,'佛山'),(4407,44,'江门'),(4408,44,'湛江'),(4409,44,'茂名'),(4412,44,'肇庆'),(4413,44,'惠州'),(4414,44,'梅州'),(4415,44,'汕尾'),(4416,44,'河源'),(4417,44,'阳江'),(4418,44,'清远'),(4419,44,'东莞'),(4420,44,'中山'),(4451,44,'潮州'),(4452,44,'揭阳'),(4453,44,'云浮'),(4501,45,'南宁'),(4502,45,'柳州'),(4503,45,'桂林'),(4504,45,'梧州'),(4505,45,'北海'),(4506,45,'防城港'),(4507,45,'钦州'),(4508,45,'贵港'),(4509,45,'玉林'),(4521,45,'南宁地区'),(4522,45,'柳州地区'),(4524,45,'贺州地区'),(4526,45,'百色地区'),(4527,45,'河池地区'),(4601,46,'海南'),(4602,46,'海口'),(4603,46,'三亚'),(5001,50,'重庆市辖'),(5002,50,'重庆县辖'),(5003,50,'重庆县级'),(5101,51,'成都'),(5103,51,'自贡'),(5104,51,'攀枝花'),(5105,51,'泸州'),(5106,51,'德阳'),(5107,51,'绵阳'),(5108,51,'广元'),(5109,51,'遂宁'),(5110,51,'内江'),(5111,51,'乐山'),(5113,51,'南充'),(5114,51,'眉山'),(5115,51,'宜宾'),(5116,51,'广安'),(5117,51,'达州'),(5118,51,'雅安'),(5119,51,'巴中'),(5120,51,'资阳'),(5132,51,'阿坝藏族羌族自治州'),(5133,51,'甘孜藏族自治州'),(5134,51,'凉山彝族自治州'),(5201,52,'贵阳'),(5202,52,'六盘水'),(5203,52,'遵义'),(5204,52,'安顺'),(5222,52,'铜仁地区'),(5223,52,'黔西南布依族苗族自治'),(5224,52,'毕节地区'),(5226,52,'黔东南苗族侗族自治州'),(5227,52,'黔南布依族苗族自治州'),(5301,53,'昆明'),(5303,53,'曲靖'),(5304,53,'玉溪'),(5305,53,'保山'),(5321,53,'昭通地区'),(5323,53,'楚雄彝族自治州'),(5325,53,'红河哈尼族彝族自治州'),(5326,53,'文山壮族苗族自治州'),(5327,53,'思茅地区'),(5328,53,'西双版纳傣族自治州'),(5329,53,'大理白族自治州'),(5331,53,'德宏傣族景颇族自治州'),(5332,53,'丽江地区'),(5333,53,'怒江傈僳族自治州'),(5334,53,'迪庆藏族自治州'),(5335,53,'临沧地区'),(5401,54,'拉萨'),(5421,54,'昌都地区'),(5422,54,'山南地区'),(5423,54,'日喀则地区'),(5424,54,'那曲地区'),(5425,54,'阿里地区'),(5426,54,'林芝地区'),(6101,61,'西安'),(6102,61,'铜川'),(6103,61,'宝鸡'),(6104,61,'咸阳'),(6105,61,'渭南'),(6106,61,'延安'),(6107,61,'汉中'),(6108,61,'榆林'),(6109,61,'安康'),(6125,61,'商洛地区'),(6201,62,'兰州'),(6202,62,'嘉峪关'),(6203,62,'金昌'),(6204,62,'白银'),(6205,62,'天水'),(6221,62,'酒泉地区'),(6222,62,'张掖地区'),(6223,62,'武威地区'),(6224,62,'定西地区'),(6226,62,'陇南地区'),(6227,62,'平凉地区'),(6228,62,'庆阳地区'),(6229,62,'临夏回族自治州'),(6230,62,'甘南藏族自治州'),(6301,63,'西宁'),(6321,63,'海东地区'),(6322,63,'海北藏族自治州'),(6323,63,'黄南藏族自治州'),(6325,63,'海南藏族自治州'),(6326,63,'果洛藏族自治州'),(6327,63,'玉树藏族自治州'),(6328,63,'海西蒙古族藏族自治州'),(6401,64,'银川'),(6402,64,'石嘴山'),(6403,64,'吴忠'),(6422,64,'固原地区'),(6501,65,'乌鲁木齐'),(6502,65,'克拉玛依'),(6521,65,'吐鲁番地区'),(6522,65,'哈密地区'),(6523,65,'昌吉回族自治州'),(6527,65,'博尔塔拉蒙古自治州'),(6528,65,'巴音郭楞蒙古自治州'),(6529,65,'阿克苏地区'),(6530,65,'克孜勒苏柯尔克孜自治'),(6531,65,'喀什地区'),(6532,65,'和田地区'),(6540,65,'伊犁哈萨克自治州'),(6541,65,'伊犁地区'),(6542,65,'塔城地区'),(6543,65,'阿勒泰地区'),(6590,65,'省直辖行政单位'),(7101,71,'台湾市辖'),(8101,81,'香港特区'),(9101,91,'澳门特区'),(110101,1101,'东城区'),(110102,1101,'西城区'),(110103,1101,'崇文区'),(110104,1101,'宣武区'),(110105,1101,'朝阳区'),(110106,1101,'丰台区'),(110107,1101,'石景山区'),(110108,1101,'海淀区'),(110109,1101,'门头沟区'),(110111,1101,'房山区'),(110112,1101,'通州区'),(110113,1101,'顺义区'),(110114,1101,'昌平区'),(110224,1102,'大兴县'),(110226,1102,'平谷县'),(110227,1102,'怀柔县'),(110228,1102,'密云县'),(110229,1102,'延庆县'),(120101,1201,'和平区'),(120102,1201,'河东区'),(120103,1201,'河西区'),(120104,1201,'南开区'),(120105,1201,'河北区'),(120106,1201,'红桥区'),(120107,1201,'塘沽区'),(120108,1201,'汉沽区'),(120109,1201,'大港区'),(120110,1201,'东丽区'),(120111,1201,'西青区'),(120112,1201,'津南区'),(120113,1201,'北辰区'),(120114,1201,'武清区'),(120221,1202,'宁河县'),(120223,1202,'静海县'),(120224,1202,'宝坻县'),(120225,1202,'蓟  县'),(130101,1301,'市辖区'),(130102,1301,'长安区'),(130103,1301,'桥东区'),(130104,1301,'桥西区'),(130105,1301,'新华区'),(130106,1301,'郊  区'),(130107,1301,'井陉矿区'),(130121,1301,'井陉县'),(130123,1301,'正定县'),(130124,1301,'栾城县'),(130125,1301,'行唐县'),(130126,1301,'灵寿县'),(130127,1301,'高邑县'),(130128,1301,'深泽县'),(130129,1301,'赞皇县'),(130130,1301,'无极县'),(130131,1301,'平山县'),(130132,1301,'元氏县'),(130133,1301,'赵  县'),(130181,1301,'辛集市'),(130182,1301,'藁城市'),(130183,1301,'晋州市'),(130184,1301,'新乐市'),(130185,1301,'鹿泉市'),(130201,1302,'市辖区'),(130202,1302,'路南区'),(130203,1302,'路北区'),(130204,1302,'古冶区'),(130205,1302,'开平区'),(130206,1302,'新  区'),(130221,1302,'丰润县'),(130223,1302,'滦  县'),(130224,1302,'滦南县'),(130225,1302,'乐亭县'),(130227,1302,'迁西县'),(130229,1302,'玉田县'),(130230,1302,'唐海县'),(130281,1302,'遵化市'),(130282,1302,'丰南市'),(130283,1302,'迁安市'),(130301,1303,'市辖区'),(130302,1303,'海港区'),(130303,1303,'山海关区'),(130304,1303,'北戴河区'),(130321,1303,'青龙满族自治县'),(130322,1303,'昌黎县'),(130323,1303,'抚宁县'),(130324,1303,'卢龙县'),(130401,1304,'市辖区'),(130402,1304,'邯山区'),(130403,1304,'丛台区'),(130404,1304,'复兴区'),(130406,1304,'峰峰矿区'),(130421,1304,'邯郸县'),(130423,1304,'临漳县'),(130424,1304,'成安县'),(130425,1304,'大名县'),(130426,1304,'涉  县'),(130427,1304,'磁  县'),(130428,1304,'肥乡县'),(130429,1304,'永年县'),(130430,1304,'邱  县'),(130431,1304,'鸡泽县'),(130432,1304,'广平县'),(130433,1304,'馆陶县'),(130434,1304,'魏  县'),(130435,1304,'曲周县'),(130481,1304,'武安市'),(130501,1305,'市辖区'),(130502,1305,'桥东区'),(130503,1305,'桥西区'),(130521,1305,'邢台县'),(130522,1305,'临城县'),(130523,1305,'内丘县'),(130524,1305,'柏乡县'),(130525,1305,'隆尧县'),(130526,1305,'任  县'),(130527,1305,'南和县'),(130528,1305,'宁晋县'),(130529,1305,'巨鹿县'),(130530,1305,'新河县'),(130531,1305,'广宗县'),(130532,1305,'平乡县'),(130533,1305,'威  县'),(130534,1305,'清河县'),(130535,1305,'临西县'),(130581,1305,'南宫市'),(130582,1305,'沙河市'),(130601,1306,'市辖区'),(130602,1306,'新市区'),(130603,1306,'北市区'),(130604,1306,'南市区'),(130621,1306,'满城县'),(130622,1306,'清苑县'),(130623,1306,'涞水县'),(130624,1306,'阜平县'),(130625,1306,'徐水县'),(130626,1306,'定兴县'),(130627,1306,'唐  县'),(130628,1306,'高阳县'),(130629,1306,'容城县'),(130630,1306,'涞源县'),(130631,1306,'望都县'),(130632,1306,'安新县'),(130633,1306,'易  县'),(130634,1306,'曲阳县'),(130635,1306,'蠡  县'),(130636,1306,'顺平县'),(130637,1306,'博野县'),(130638,1306,'雄  县'),(130681,1306,'涿州市'),(130682,1306,'定州市'),(130683,1306,'安国市'),(130684,1306,'高碑店市'),(130701,1307,'市辖区'),(130702,1307,'桥东区'),(130703,1307,'桥西区'),(130705,1307,'宣化区'),(130706,1307,'下花园区'),(130721,1307,'宣化县'),(130722,1307,'张北县'),(130723,1307,'康保县'),(130724,1307,'沽源县'),(130725,1307,'尚义县'),(130726,1307,'蔚  县'),(130727,1307,'阳原县'),(130728,1307,'怀安县'),(130729,1307,'万全县'),(130730,1307,'怀来县'),(130731,1307,'涿鹿县'),(130732,1307,'赤城县'),(130733,1307,'崇礼县'),(130801,1308,'市辖区'),(130802,1308,'双桥区'),(130803,1308,'双滦区'),(130804,1308,'鹰手营子矿区'),(130821,1308,'承德县'),(130822,1308,'兴隆县'),(130823,1308,'平泉县'),(130824,1308,'滦平县'),(130825,1308,'隆化县'),(130826,1308,'丰宁满族自治县'),(130827,1308,'宽城满族自治县'),(130828,1308,'围场满族蒙古族自治县'),(130901,1309,'市辖区'),(130902,1309,'新华区'),(130903,1309,'运河区'),(130921,1309,'沧  县'),(130922,1309,'青  县'),(130923,1309,'东光县'),(130924,1309,'海兴县'),(130925,1309,'盐山县'),(130926,1309,'肃宁县'),(130927,1309,'南皮县'),(130928,1309,'吴桥县'),(130929,1309,'献  县'),(130930,1309,'孟村回族自治县'),(130981,1309,'泊头市'),(130982,1309,'任丘市'),(130983,1309,'黄骅市'),(130984,1309,'河间市'),(131001,1310,'市辖区'),(131002,1310,'安次区'),(131003,1310,'廊坊市广阳区'),(131022,1310,'固安县'),(131023,1310,'永清县'),(131024,1310,'香河县'),(131025,1310,'大城县'),(131026,1310,'文安县'),(131028,1310,'大厂回族自治县'),(131081,1310,'霸州市'),(131082,1310,'三河市'),(131101,1311,'市辖区'),(131102,1311,'桃城区'),(131121,1311,'枣强县'),(131122,1311,'武邑县'),(131123,1311,'武强县'),(131124,1311,'饶阳县'),(131125,1311,'安平县'),(131126,1311,'故城县'),(131127,1311,'景  县'),(131128,1311,'阜城县'),(131181,1311,'冀州市'),(131182,1311,'深州市'),(140101,1401,'市辖区'),(140105,1401,'小店区'),(140106,1401,'迎泽区'),(140107,1401,'杏花岭区'),(140108,1401,'尖草坪区'),(140109,1401,'万柏林区'),(140110,1401,'晋源区'),(140121,1401,'清徐县'),(140122,1401,'阳曲县'),(140123,1401,'娄烦县'),(140181,1401,'古交市'),(140201,1402,'市辖区'),(140202,1402,'城  区'),(140203,1402,'矿  区'),(140211,1402,'南郊区'),(140212,1402,'新荣区'),(140221,1402,'阳高县'),(140222,1402,'天镇县'),(140223,1402,'广灵县'),(140224,1402,'灵丘县'),(140225,1402,'浑源县'),(140226,1402,'左云县'),(140227,1402,'大同县'),(140301,1403,'市辖区'),(140302,1403,'城  区'),(140303,1403,'矿  区'),(140311,1403,'郊  区'),(140321,1403,'平定县'),(140322,1403,'盂  县'),(140401,1404,'市辖区'),(140402,1404,'城  区'),(140411,1404,'郊  区'),(140421,1404,'长治县'),(140423,1404,'襄垣县'),(140424,1404,'屯留县'),(140425,1404,'平顺县'),(140426,1404,'黎城县'),(140427,1404,'壶关县'),(140428,1404,'长子县'),(140429,1404,'武乡县'),(140430,1404,'沁  县'),(140431,1404,'沁源县'),(140481,1404,'潞城市'),(140501,1405,'市辖区'),(140502,1405,'城  区'),(140521,1405,'沁水县'),(140522,1405,'阳城县'),(140524,1405,'陵川县'),(140525,1405,'泽州县'),(140581,1405,'高平市'),(140601,1406,'市辖区'),(140602,1406,'朔城区'),(140603,1406,'平鲁区'),(140621,1406,'山阴县'),(140622,1406,'应  县'),(140623,1406,'右玉县'),(140624,1406,'怀仁县'),(140701,1407,'市辖区'),(140702,1407,'榆次区'),(140721,1407,'榆社县'),(140722,1407,'左权县'),(140723,1407,'和顺县'),(140724,1407,'昔阳县'),(140725,1407,'寿阳县'),(140726,1407,'太谷县'),(140727,1407,'祁  县'),(140728,1407,'平遥县'),(140729,1407,'灵石县'),(140781,1407,'介休市'),(140801,1408,'市辖区'),(140802,1408,'盐湖区'),(140821,1408,'临猗县'),(140822,1408,'万荣县'),(140823,1408,'闻喜县'),(140824,1408,'稷山县'),(140825,1408,'新绛县'),(140826,1408,'绛  县'),(140827,1408,'垣曲县'),(140828,1408,'夏  县'),(140829,1408,'平陆县'),(140830,1408,'芮城县'),(140881,1408,'永济市'),(140882,1408,'河津市'),(140901,1409,'市辖区'),(140902,1409,'忻府区'),(140921,1409,'定襄县'),(140922,1409,'五台县'),(140923,1409,'代  县'),(140924,1409,'繁峙县'),(140925,1409,'宁武县'),(140926,1409,'静乐县'),(140927,1409,'神池县'),(140928,1409,'五寨县'),(140929,1409,'岢岚县'),(140930,1409,'河曲县'),(140931,1409,'保德县'),(140932,1409,'偏关县'),(140981,1409,'原平市'),(141001,1410,'市辖区'),(141002,1410,'尧都区'),(141021,1410,'曲沃县'),(141022,1410,'翼城县'),(141023,1410,'襄汾县'),(141024,1410,'洪洞县'),(141025,1410,'古  县'),(141026,1410,'安泽县'),(141027,1410,'浮山县'),(141028,1410,'吉  县'),(141029,1410,'乡宁县'),(141030,1410,'大宁县'),(141031,1410,'隰  县'),(141032,1410,'永和县'),(141033,1410,'蒲  县'),(141034,1410,'汾西县'),(141081,1410,'侯马市'),(141082,1410,'霍州市'),(142301,1423,'孝义市'),(142302,1423,'离石市'),(142303,1423,'汾阳市'),(142322,1423,'文水县'),(142323,1423,'交城县'),(142325,1423,'兴  县'),(142326,1423,'临  县'),(142327,1423,'柳林县'),(142328,1423,'石楼县'),(142329,1423,'岚  县'),(142330,1423,'方山县'),(142332,1423,'中阳县'),(142333,1423,'交口县'),(150101,1501,'市辖区'),(150102,1501,'新城区'),(150103,1501,'回民区'),(150104,1501,'玉泉区'),(150105,1501,'赛罕区'),(150121,1501,'土默特左旗'),(150122,1501,'托克托县'),(150123,1501,'和林格尔县'),(150124,1501,'清水河县'),(150125,1501,'武川县'),(150201,1502,'市辖区'),(150202,1502,'东河区'),(150203,1502,'昆都伦区'),(150204,1502,'青山区'),(150205,1502,'石拐区'),(150206,1502,'白云矿区'),(150207,1502,'九原区'),(150221,1502,'土默特右旗'),(150222,1502,'固阳县'),(150223,1502,'达尔罕茂明安联合旗'),(150301,1503,'市辖区'),(150302,1503,'海勃湾区'),(150303,1503,'海南区'),(150304,1503,'乌达区'),(150401,1504,'市辖区'),(150402,1504,'红山区'),(150403,1504,'元宝山区'),(150404,1504,'松山区'),(150421,1504,'阿鲁科尔沁旗'),(150422,1504,'巴林左旗'),(150423,1504,'巴林右旗'),(150424,1504,'林西县'),(150425,1504,'克什克腾旗'),(150426,1504,'翁牛特旗'),(150428,1504,'喀喇沁旗'),(150429,1504,'宁城县'),(150430,1504,'敖汉旗'),(150501,1505,'市辖区'),(150502,1505,'科尔沁区'),(150521,1505,'科尔沁左翼中旗'),(150522,1505,'科尔沁左翼后旗'),(150523,1505,'开鲁县'),(150524,1505,'库伦旗'),(150525,1505,'奈曼旗'),(150526,1505,'扎鲁特旗'),(150581,1505,'霍林郭勒市'),(152101,1521,'海拉尔市'),(152102,1521,'满洲里市'),(152103,1521,'扎兰屯市'),(152104,1521,'牙克石市'),(152105,1521,'根河市'),(152106,1521,'额尔古纳市'),(152122,1521,'阿荣旗'),(152123,1521,'莫力达瓦达斡尔族自治'),(152127,1521,'鄂伦春自治旗'),(152128,1521,'鄂温克族自治旗'),(152129,1521,'新巴尔虎右旗'),(152130,1521,'新巴尔虎左旗'),(152131,1521,'陈巴尔虎旗'),(152201,1522,'乌兰浩特市'),(152202,1522,'阿尔山市'),(152221,1522,'科尔沁右翼前旗'),(152222,1522,'科尔沁右翼中旗'),(152223,1522,'扎赉特旗'),(152224,1522,'突泉县'),(152501,1525,'二连浩特市'),(152502,1525,'锡林浩特市'),(152522,1525,'阿巴嘎旗'),(152523,1525,'苏尼特左旗'),(152524,1525,'苏尼特右旗'),(152525,1525,'东乌珠穆沁旗'),(152526,1525,'西乌珠穆沁旗'),(152527,1525,'太仆寺旗'),(152528,1525,'镶黄旗'),(152529,1525,'正镶白旗'),(152530,1525,'正蓝旗'),(152531,1525,'多伦县'),(152601,1526,'集宁市'),(152602,1526,'丰镇市'),(152624,1526,'卓资县'),(152625,1526,'化德县'),(152626,1526,'商都县'),(152627,1526,'兴和县'),(152629,1526,'凉城县'),(152630,1526,'察哈尔右翼前旗'),(152631,1526,'察哈尔右翼中旗'),(152632,1526,'察哈尔右翼后旗'),(152634,1526,'四子王旗'),(152701,1527,'东胜市'),(152722,1527,'达拉特旗'),(152723,1527,'准格尔旗'),(152724,1527,'鄂托克前旗'),(152725,1527,'鄂托克旗'),(152726,1527,'杭锦旗'),(152727,1527,'乌审旗'),(152728,1527,'伊金霍洛旗'),(152801,1528,'临河市'),(152822,1528,'五原县'),(152823,1528,'磴口县'),(152824,1528,'乌拉特前旗'),(152825,1528,'乌拉特中旗'),(152826,1528,'乌拉特后旗'),(152827,1528,'杭锦后旗'),(152921,1529,'阿拉善左旗'),(152922,1529,'阿拉善右旗'),(152923,1529,'额济纳旗'),(210101,2101,'市辖区'),(210102,2101,'和平区'),(210103,2101,'沈河区'),(210104,2101,'大东区'),(210105,2101,'皇姑区'),(210106,2101,'铁西区'),(210111,2101,'苏家屯区'),(210112,2101,'东陵区'),(210113,2101,'新城子区'),(210114,2101,'于洪区'),(210122,2101,'辽中县'),(210123,2101,'康平县'),(210124,2101,'法库县'),(210181,2101,'新民市'),(210201,2102,'市辖区'),(210202,2102,'中山区'),(210203,2102,'西岗区'),(210204,2102,'沙河口区'),(210211,2102,'甘井子区'),(210212,2102,'旅顺口区'),(210213,2102,'金州区'),(210224,2102,'长海县'),(210281,2102,'瓦房店市'),(210282,2102,'普兰店市'),(210283,2102,'庄河市'),(210301,2103,'市辖区'),(210302,2103,'铁东区'),(210303,2103,'铁西区'),(210304,2103,'立山区'),(210311,2103,'千山区'),(210321,2103,'台安县'),(210323,2103,'岫岩满族自治县'),(210381,2103,'海城市'),(210401,2104,'市辖区'),(210402,2104,'新抚区'),(210403,2104,'东洲区'),(210404,2104,'望花区'),(210411,2104,'顺城区'),(210421,2104,'抚顺县'),(210422,2104,'新宾满族自治县'),(210423,2104,'清原满族自治县'),(210501,2105,'市辖区'),(210502,2105,'平山区'),(210503,2105,'溪湖区'),(210504,2105,'明山区'),(210505,2105,'南芬区'),(210521,2105,'本溪满族自治县'),(210522,2105,'桓仁满族自治县'),(210601,2106,'市辖区'),(210602,2106,'元宝区'),(210603,2106,'振兴区'),(210604,2106,'振安区'),(210624,2106,'宽甸满族自治县'),(210681,2106,'东港市'),(210682,2106,'凤城市'),(210701,2107,'市辖区'),(210702,2107,'古塔区'),(210703,2107,'凌河区'),(210711,2107,'太和区'),(210726,2107,'黑山县'),(210727,2107,'义  县'),(210781,2107,'凌海市'),(210782,2107,'北宁市'),(210801,2108,'市辖区'),(210802,2108,'站前区'),(210803,2108,'西市区'),(210804,2108,'鲅鱼圈区'),(210811,2108,'老边区'),(210881,2108,'盖州市'),(210882,2108,'大石桥市'),(210901,2109,'市辖区'),(210902,2109,'海州区'),(210903,2109,'新邱区'),(210904,2109,'太平区'),(210905,2109,'清河门区'),(210911,2109,'细河区'),(210921,2109,'阜新蒙古族自治县'),(210922,2109,'彰武县'),(211001,2110,'市辖区'),(211002,2110,'白塔区'),(211003,2110,'文圣区'),(211004,2110,'宏伟区'),(211005,2110,'弓长岭区'),(211011,2110,'太子河区'),(211021,2110,'辽阳县'),(211081,2110,'灯塔市'),(211101,2111,'市辖区'),(211102,2111,'双台子区'),(211103,2111,'兴隆台区'),(211121,2111,'大洼县'),(211122,2111,'盘山县'),(211201,2112,'市辖区'),(211202,2112,'银州区'),(211204,2112,'清河区'),(211221,2112,'铁岭县'),(211223,2112,'西丰县'),(211224,2112,'昌图县'),(211281,2112,'铁法市'),(211282,2112,'开原市'),(211301,2113,'市辖区'),(211302,2113,'双塔区'),(211303,2113,'龙城区'),(211321,2113,'朝阳县'),(211322,2113,'建平县'),(211324,2113,'喀喇沁左翼蒙古族自治'),(211381,2113,'北票市'),(211382,2113,'凌源市'),(211401,2114,'市辖区'),(211402,2114,'连山区'),(211403,2114,'龙港区'),(211404,2114,'南票区'),(211421,2114,'绥中县'),(211422,2114,'建昌县'),(211481,2114,'兴城市'),(220101,2201,'市辖区'),(220102,2201,'南关区'),(220103,2201,'宽城区'),(220104,2201,'朝阳区'),(220105,2201,'二道区'),(220106,2201,'绿园区'),(220112,2201,'双阳区'),(220122,2201,'农安县'),(220181,2201,'九台市'),(220182,2201,'榆树市'),(220183,2201,'德惠市'),(220201,2202,'市辖区'),(220202,2202,'昌邑区'),(220203,2202,'龙潭区'),(220204,2202,'船营区'),(220211,2202,'丰满区'),(220221,2202,'永吉县'),(220281,2202,'蛟河市'),(220282,2202,'桦甸市'),(220283,2202,'舒兰市'),(220284,2202,'磐石市'),(220301,2203,'市辖区'),(220302,2203,'铁西区'),(220303,2203,'铁东区'),(220322,2203,'梨树县'),(220323,2203,'伊通满族自治县'),(220381,2203,'公主岭市'),(220382,2203,'双辽市'),(220401,2204,'市辖区'),(220402,2204,'龙山区'),(220403,2204,'西安区'),(220421,2204,'东丰县'),(220422,2204,'东辽县'),(220501,2205,'市辖区'),(220502,2205,'东昌区'),(220503,2205,'二道江区'),(220521,2205,'通化县'),(220523,2205,'辉南县'),(220524,2205,'柳河县'),(220581,2205,'梅河口市'),(220582,2205,'集安市'),(220601,2206,'市辖区'),(220602,2206,'八道江区'),(220621,2206,'抚松县'),(220622,2206,'靖宇县'),(220623,2206,'长白朝鲜族自治县'),(220625,2206,'江源县'),(220681,2206,'临江市'),(220701,2207,'市辖区'),(220702,2207,'宁江区'),(220721,2207,'前郭尔罗斯蒙古族自治'),(220722,2207,'长岭县'),(220723,2207,'乾安县'),(220724,2207,'扶余县'),(220801,2208,'市辖区'),(220802,2208,'洮北区'),(220821,2208,'镇赉县'),(220822,2208,'通榆县'),(220881,2208,'洮南市'),(220882,2208,'大安市'),(222401,2224,'延吉市'),(222402,2224,'图们市'),(222403,2224,'敦化市'),(222404,2224,'珲春市'),(222405,2224,'龙井市'),(222406,2224,'和龙市'),(222424,2224,'汪清县'),(222426,2224,'安图县'),(230101,2301,'市辖区'),(230102,2301,'道里区'),(230103,2301,'南岗区'),(230104,2301,'道外区'),(230105,2301,'太平区'),(230106,2301,'香坊区'),(230107,2301,'动力区'),(230108,2301,'平房区'),(230121,2301,'呼兰县'),(230123,2301,'依兰县'),(230124,2301,'方正县'),(230125,2301,'宾  县'),(230126,2301,'巴彦县'),(230127,2301,'木兰县'),(230128,2301,'通河县'),(230129,2301,'延寿县'),(230181,2301,'阿城市'),(230182,2301,'双城市'),(230183,2301,'尚志市'),(230184,2301,'五常市'),(230201,2302,'市辖区'),(230202,2302,'龙沙区'),(230203,2302,'建华区'),(230204,2302,'铁锋区'),(230205,2302,'昂昂溪区'),(230206,2302,'富拉尔基区'),(230207,2302,'碾子山区'),(230208,2302,'梅里斯达斡尔族区'),(230221,2302,'龙江县'),(230223,2302,'依安县'),(230224,2302,'泰来县'),(230225,2302,'甘南县'),(230227,2302,'富裕县'),(230229,2302,'克山县'),(230230,2302,'克东县'),(230231,2302,'拜泉县'),(230281,2302,'讷河市'),(230301,2303,'市辖区'),(230302,2303,'鸡冠区'),(230303,2303,'恒山区'),(230304,2303,'滴道区'),(230305,2303,'梨树区'),(230306,2303,'城子河区'),(230307,2303,'麻山区'),(230321,2303,'鸡东县'),(230381,2303,'虎林市'),(230382,2303,'密山市'),(230401,2304,'市辖区'),(230402,2304,'向阳区'),(230403,2304,'工农区'),(230404,2304,'南山区'),(230405,2304,'兴安区'),(230406,2304,'东山区'),(230407,2304,'兴山区'),(230421,2304,'萝北县'),(230422,2304,'绥滨县'),(230501,2305,'市辖区'),(230502,2305,'尖山区'),(230503,2305,'岭东区'),(230505,2305,'四方台区'),(230506,2305,'宝山区'),(230521,2305,'集贤县'),(230522,2305,'友谊县'),(230523,2305,'宝清县'),(230524,2305,'饶河县'),(230601,2306,'市辖区'),(230602,2306,'萨尔图区'),(230603,2306,'龙凤区'),(230604,2306,'让胡路区'),(230605,2306,'红岗区'),(230606,2306,'大同区'),(230621,2306,'肇州县'),(230622,2306,'肇源县'),(230623,2306,'林甸县'),(230624,2306,'杜尔伯特蒙古族自治县'),(230701,2307,'市辖区'),(230702,2307,'伊春区'),(230703,2307,'南岔区'),(230704,2307,'友好区'),(230705,2307,'西林区'),(230706,2307,'翠峦区'),(230707,2307,'新青区'),(230708,2307,'美溪区'),(230709,2307,'金山屯区'),(230710,2307,'五营区'),(230711,2307,'乌马河区'),(230712,2307,'汤旺河区'),(230713,2307,'带岭区'),(230714,2307,'乌伊岭区'),(230715,2307,'红星区'),(230716,2307,'上甘岭区'),(230722,2307,'嘉荫县'),(230781,2307,'铁力市'),(230801,2308,'市辖区'),(230802,2308,'永红区'),(230803,2308,'向阳区'),(230804,2308,'前进区'),(230805,2308,'东风区'),(230811,2308,'郊  区'),(230822,2308,'桦南县'),(230826,2308,'桦川县'),(230828,2308,'汤原县'),(230833,2308,'抚远县'),(230881,2308,'同江市'),(230882,2308,'富锦市'),(230901,2309,'市辖区'),(230902,2309,'新兴区'),(230903,2309,'桃山区'),(230904,2309,'茄子河区'),(230921,2309,'勃利县'),(231001,2310,'市辖区'),(231002,2310,'东安区'),(231003,2310,'阳明区'),(231004,2310,'爱民区'),(231005,2310,'西安区'),(231024,2310,'东宁县'),(231025,2310,'林口县'),(231081,2310,'绥芬河市'),(231083,2310,'海林市'),(231084,2310,'宁安市'),(231085,2310,'穆棱市'),(231101,2311,'市辖区'),(231102,2311,'爱辉区'),(231121,2311,'嫩江县'),(231123,2311,'逊克县'),(231124,2311,'孙吴县'),(231181,2311,'北安市'),(231182,2311,'五大连池市'),(231201,2312,'市辖区'),(231202,2312,'北林区'),(231221,2312,'望奎县'),(231222,2312,'兰西县'),(231223,2312,'青冈县'),(231224,2312,'庆安县'),(231225,2312,'明水县'),(231226,2312,'绥棱县'),(231281,2312,'安达市'),(231282,2312,'肇东市'),(231283,2312,'海伦市'),(232721,2327,'呼玛县'),(232722,2327,'塔河县'),(232723,2327,'漠河县'),(310101,3101,'黄浦区'),(310103,3101,'卢湾区'),(310104,3101,'徐汇区'),(310105,3101,'长宁区'),(310106,3101,'静安区'),(310107,3101,'普陀区'),(310108,3101,'闸北区'),(310109,3101,'虹口区'),(310110,3101,'杨浦区'),(310112,3101,'闵行区'),(310113,3101,'宝山区'),(310114,3101,'嘉定区'),(310115,3101,'浦东新区'),(310116,3101,'金山区'),(310117,3101,'松江区'),(310118,3101,'青浦区'),(310225,3102,'南汇县'),(310226,3102,'奉贤县'),(310230,3102,'崇明县'),(320101,3201,'市辖区'),(320102,3201,'玄武区'),(320103,3201,'白下区'),(320104,3201,'秦淮区'),(320105,3201,'建邺区'),(320106,3201,'鼓楼区'),(320107,3201,'下关区'),(320111,3201,'浦口区'),(320112,3201,'大厂区'),(320113,3201,'栖霞区'),(320114,3201,'雨花台区'),(320115,3201,'江宁区'),(320122,3201,'江浦县'),(320123,3201,'六合县'),(320124,3201,'溧水县'),(320125,3201,'高淳县'),(320201,3202,'市辖区'),(320202,3202,'崇安区'),(320203,3202,'南长区'),(320204,3202,'北塘区'),(320205,3202,'锡山区'),(320206,3202,'惠山区'),(320211,3202,'滨湖区'),(320281,3202,'江阴市'),(320282,3202,'宜兴市'),(320301,3203,'市辖区'),(320302,3203,'鼓楼区'),(320303,3203,'云龙区'),(320304,3203,'九里区'),(320305,3203,'贾汪区'),(320311,3203,'泉山区'),(320321,3203,'丰  县'),(320322,3203,'沛  县'),(320323,3203,'铜山县'),(320324,3203,'睢宁县'),(320381,3203,'新沂市'),(320382,3203,'邳州市'),(320401,3204,'市辖区'),(320402,3204,'天宁区'),(320404,3204,'钟楼区'),(320405,3204,'戚墅堰区'),(320411,3204,'郊  区'),(320481,3204,'溧阳市'),(320482,3204,'金坛市'),(320483,3204,'武进市'),(320501,3205,'市辖区'),(320502,3205,'沧浪区'),(320503,3205,'平江区'),(320504,3205,'金阊区'),(320505,3205,'虎丘区'),(320506,3205,'吴中区'),(320507,3205,'相城区'),(320581,3205,'常熟市'),(320582,3205,'张家港市'),(320583,3205,'昆山市'),(320584,3205,'吴江市'),(320585,3205,'太仓市'),(320601,3206,'市辖区'),(320602,3206,'崇川区'),(320611,3206,'港闸区'),(320621,3206,'海安县'),(320623,3206,'如东县'),(320681,3206,'启东市'),(320682,3206,'如皋市'),(320683,3206,'通州市'),(320684,3206,'海门市'),(320701,3207,'市辖区'),(320703,3207,'连云区'),(320704,3207,'云台区'),(320705,3207,'新浦区'),(320706,3207,'海州区'),(320721,3207,'赣榆县'),(320722,3207,'东海县'),(320723,3207,'灌云县'),(320724,3207,'灌南县'),(320801,3208,'市辖区'),(320802,3208,'清河区'),(320803,3208,'楚州区'),(320804,3208,'淮阴区'),(320811,3208,'清浦区'),(320826,3208,'涟水县'),(320829,3208,'洪泽县'),(320830,3208,'盱眙县'),(320831,3208,'金湖县'),(320901,3209,'市辖区'),(320902,3209,'城  区'),(320921,3209,'响水县'),(320922,3209,'滨海县'),(320923,3209,'阜宁县'),(320924,3209,'射阳县'),(320925,3209,'建湖县'),(320928,3209,'盐都县'),(320981,3209,'东台市'),(320982,3209,'大丰市'),(321001,3210,'市辖区'),(321002,3210,'广陵区'),(321003,3210,'邗江区'),(321011,3210,'郊  区'),(321023,3210,'宝应县'),(321081,3210,'仪征市'),(321084,3210,'高邮市'),(321088,3210,'江都市'),(321101,3211,'市辖区'),(321102,3211,'京口区'),(321111,3211,'润州区'),(321121,3211,'丹徒县'),(321181,3211,'丹阳市'),(321182,3211,'扬中市'),(321183,3211,'句容市'),(321201,3212,'市辖区'),(321202,3212,'海陵区'),(321203,3212,'高港区'),(321281,3212,'兴化市'),(321282,3212,'靖江市'),(321283,3212,'泰兴市'),(321284,3212,'姜堰市'),(321301,3213,'市辖区'),(321302,3213,'宿城区'),(321321,3213,'宿豫县'),(321322,3213,'沭阳县'),(321323,3213,'泗阳县'),(321324,3213,'泗洪县'),(330101,3301,'市辖区'),(330102,3301,'上城区'),(330103,3301,'下城区'),(330104,3301,'江干区'),(330105,3301,'拱墅区'),(330106,3301,'西湖区'),(330108,3301,'滨江区'),(330122,3301,'桐庐县'),(330127,3301,'淳安县'),(330181,3301,'萧山市'),(330182,3301,'建德市'),(330183,3301,'富阳市'),(330184,3301,'余杭市'),(330185,3301,'临安市'),(330201,3302,'市辖区'),(330203,3302,'海曙区'),(330204,3302,'江东区'),(330205,3302,'江北区'),(330206,3302,'北仑区'),(330211,3302,'镇海区'),(330225,3302,'象山县'),(330226,3302,'宁海县'),(330227,3302,'鄞  县'),(330281,3302,'余姚市'),(330282,3302,'慈溪市'),(330283,3302,'奉化市'),(330301,3303,'市辖区'),(330302,3303,'鹿城区'),(330303,3303,'龙湾区'),(330304,3303,'瓯海区'),(330322,3303,'洞头县'),(330324,3303,'永嘉县'),(330326,3303,'平阳县'),(330327,3303,'苍南县'),(330328,3303,'文成县'),(330329,3303,'泰顺县'),(330381,3303,'瑞安市'),(330382,3303,'乐清市'),(330401,3304,'市辖区'),(330402,3304,'秀城区'),(330411,3304,'秀洲区'),(330421,3304,'嘉善县'),(330424,3304,'海盐县'),(330481,3304,'海宁市'),(330482,3304,'平湖市'),(330483,3304,'桐乡市'),(330501,3305,'市辖区'),(330521,3305,'德清县'),(330522,3305,'长兴县'),(330523,3305,'安吉县'),(330601,3306,'市辖区'),(330602,3306,'越城区'),(330621,3306,'绍兴县'),(330624,3306,'新昌县'),(330681,3306,'诸暨市'),(330682,3306,'上虞市'),(330683,3306,'嵊州市'),(330701,3307,'市辖区'),(330702,3307,'婺城区'),(330703,3307,'金东区'),(330723,3307,'武义县'),(330726,3307,'浦江县'),(330727,3307,'磐安县'),(330781,3307,'兰溪市'),(330782,3307,'义乌市'),(330783,3307,'东阳市'),(330784,3307,'永康市'),(330801,3308,'市辖区'),(330802,3308,'柯城区'),(330821,3308,'衢  县'),(330822,3308,'常山县'),(330824,3308,'开化县'),(330825,3308,'龙游县'),(330881,3308,'江山市'),(330901,3309,'市辖区'),(330902,3309,'定海区'),(330903,3309,'普陀区'),(330921,3309,'岱山县'),(330922,3309,'嵊泗县'),(331001,3310,'市辖区'),(331002,3310,'椒江区'),(331003,3310,'黄岩区'),(331004,3310,'路桥区'),(331021,3310,'玉环县'),(331022,3310,'三门县'),(331023,3310,'天台县'),(331024,3310,'仙居县'),(331081,3310,'温岭市'),(331082,3310,'临海市'),(331101,3311,'市辖区'),(331102,3311,'莲都区'),(331121,3311,'青田县'),(331122,3311,'缙云县'),(331123,3311,'遂昌县'),(331124,3311,'松阳县'),(331125,3311,'云和县'),(331126,3311,'庆元县'),(331127,3311,'景宁畲族自治县'),(331181,3311,'龙泉市'),(340101,3401,'市辖区'),(340102,3401,'东市区'),(340103,3401,'中市区'),(340104,3401,'西市区'),(340111,3401,'郊  区'),(340121,3401,'长丰县'),(340122,3401,'肥东县'),(340123,3401,'肥西县'),(340201,3402,'市辖区'),(340202,3402,'镜湖区'),(340203,3402,'马塘区'),(340204,3402,'新芜区'),(340207,3402,'鸠江区'),(340221,3402,'芜湖县'),(340222,3402,'繁昌县'),(340223,3402,'南陵县'),(340301,3403,'市辖区'),(340302,3403,'东市区'),(340303,3403,'中市区'),(340304,3403,'西市区'),(340311,3403,'郊  区'),(340321,3403,'怀远县'),(340322,3403,'五河县'),(340323,3403,'固镇县'),(340401,3404,'市辖区'),(340402,3404,'大通区'),(340403,3404,'田家庵区'),(340404,3404,'谢家集区'),(340405,3404,'八公山区'),(340406,3404,'潘集区'),(340421,3404,'凤台县'),(340501,3405,'市辖区'),(340502,3405,'金家庄区'),(340503,3405,'花山区'),(340504,3405,'雨山区'),(340505,3405,'向山区'),(340521,3405,'当涂县'),(340601,3406,'市辖区'),(340602,3406,'杜集区'),(340603,3406,'相山区'),(340604,3406,'烈山区'),(340621,3406,'濉溪县'),(340701,3407,'市辖区'),(340702,3407,'铜官山区'),(340703,3407,'狮子山区'),(340711,3407,'郊  区'),(340721,3407,'铜陵县'),(340801,3408,'市辖区'),(340802,3408,'迎江区'),(340803,3408,'大观区'),(340811,3408,'郊  区'),(340822,3408,'怀宁县'),(340823,3408,'枞阳县'),(340824,3408,'潜山县'),(340825,3408,'太湖县'),(340826,3408,'宿松县'),(340827,3408,'望江县'),(340828,3408,'岳西县'),(340881,3408,'桐城市'),(341001,3410,'市辖区'),(341002,3410,'屯溪区'),(341003,3410,'黄山区'),(341004,3410,'徽州区'),(341021,3410,'歙  县'),(341022,3410,'休宁县'),(341023,3410,'黟  县'),(341024,3410,'祁门县'),(341101,3411,'市辖区'),(341102,3411,'琅琊区'),(341103,3411,'南谯区'),(341122,3411,'来安县'),(341124,3411,'全椒县'),(341125,3411,'定远县'),(341126,3411,'凤阳县'),(341181,3411,'天长市'),(341182,3411,'明光市'),(341201,3412,'市辖区'),(341202,3412,'颍州区'),(341203,3412,'颍东区'),(341204,3412,'颍泉区'),(341221,3412,'临泉县'),(341222,3412,'太和县'),(341225,3412,'阜南县'),(341226,3412,'颍上县'),(341282,3412,'界首市'),(341301,3413,'市辖区'),(341302,3413,'墉桥区'),(341321,3413,'砀山县'),(341322,3413,'萧  县'),(341323,3413,'灵璧县'),(341324,3413,'泗  县'),(341401,3414,'市辖区'),(341402,3414,'居巢区'),(341421,3414,'庐江县'),(341422,3414,'无为县'),(341423,3414,'含山县'),(341424,3414,'和  县'),(341501,3415,'市辖区'),(341502,3415,'金安区'),(341503,3415,'裕安区'),(341521,3415,'寿  县'),(341522,3415,'霍邱县'),(341523,3415,'舒城县'),(341524,3415,'金寨县'),(341525,3415,'霍山县'),(341601,3416,'市辖区'),(341602,3416,'谯城区'),(341621,3416,'涡阳县'),(341622,3416,'蒙城县'),(341623,3416,'利辛县'),(341701,3417,'市辖区'),(341702,3417,'贵池区'),(341721,3417,'东至县'),(341722,3417,'石台县'),(341723,3417,'青阳县'),(341801,3418,'市辖区'),(341802,3418,'宣州区'),(341821,3418,'郎溪县'),(341822,3418,'广德县'),(341823,3418,'泾  县'),(341824,3418,'绩溪县'),(341825,3418,'旌德县'),(341881,3418,'宁国市'),(350101,3501,'市辖区'),(350102,3501,'鼓楼区'),(350103,3501,'台江区'),(350104,3501,'仓山区'),(350105,3501,'马尾区'),(350111,3501,'晋安区'),(350121,3501,'闽侯县'),(350122,3501,'连江县'),(350123,3501,'罗源县'),(350124,3501,'闽清县'),(350125,3501,'永泰县'),(350128,3501,'平潭县'),(350181,3501,'福清市'),(350182,3501,'长乐市'),(350201,3502,'市辖区'),(350202,3502,'鼓浪屿区'),(350203,3502,'思明区'),(350204,3502,'开元区'),(350205,3502,'杏林区'),(350206,3502,'湖里区'),(350211,3502,'集美区'),(350212,3502,'同安区'),(350301,3503,'市辖区'),(350302,3503,'城厢区'),(350303,3503,'涵江区'),(350321,3503,'莆田县'),(350322,3503,'仙游县'),(350401,3504,'市辖区'),(350402,3504,'梅列区'),(350403,3504,'三元区'),(350421,3504,'明溪县'),(350423,3504,'清流县'),(350424,3504,'宁化县'),(350425,3504,'大田县'),(350426,3504,'尤溪县'),(350427,3504,'沙  县'),(350428,3504,'将乐县'),(350429,3504,'泰宁县'),(350430,3504,'建宁县'),(350481,3504,'永安市'),(350501,3505,'市辖区'),(350502,3505,'鲤城区'),(350503,3505,'丰泽区'),(350504,3505,'洛江区'),(350505,3505,'泉港区'),(350521,3505,'惠安县'),(350524,3505,'安溪县'),(350525,3505,'永春县'),(350526,3505,'德化县'),(350527,3505,'金门县'),(350581,3505,'石狮市'),(350582,3505,'晋江市'),(350583,3505,'南安市'),(350601,3506,'市辖区'),(350602,3506,'芗城区'),(350603,3506,'龙文区'),(350622,3506,'云霄县'),(350623,3506,'漳浦县'),(350624,3506,'诏安县'),(350625,3506,'长泰县'),(350626,3506,'东山县'),(350627,3506,'南靖县'),(350628,3506,'平和县'),(350629,3506,'华安县'),(350681,3506,'龙海市'),(350701,3507,'市辖区'),(350702,3507,'延平区'),(350721,3507,'顺昌县'),(350722,3507,'浦城县'),(350723,3507,'光泽县'),(350724,3507,'松溪县'),(350725,3507,'政和县'),(350781,3507,'邵武市'),(350782,3507,'武夷山市'),(350783,3507,'建瓯市'),(350784,3507,'建阳市'),(350801,3508,'市辖区'),(350802,3508,'新罗区'),(350821,3508,'长汀县'),(350822,3508,'永定县'),(350823,3508,'上杭县'),(350824,3508,'武平县'),(350825,3508,'连城县'),(350881,3508,'漳平市'),(350901,3509,'市辖区'),(350902,3509,'蕉城区'),(350921,3509,'霞浦县'),(350922,3509,'古田县'),(350923,3509,'屏南县'),(350924,3509,'寿宁县'),(350925,3509,'周宁县'),(350926,3509,'柘荣县'),(350981,3509,'福安市'),(350982,3509,'福鼎市'),(360101,3601,'市辖区'),(360102,3601,'东湖区'),(360103,3601,'西湖区'),(360104,3601,'青云谱区'),(360105,3601,'湾里区'),(360111,3601,'郊  区'),(360121,3601,'南昌县'),(360122,3601,'新建县'),(360123,3601,'安义县'),(360124,3601,'进贤县'),(360201,3602,'市辖区'),(360202,3602,'昌江区'),(360203,3602,'珠山区'),(360222,3602,'浮梁县'),(360281,3602,'乐平市'),(360301,3603,'市辖区'),(360302,3603,'安源区'),(360313,3603,'湘东区'),(360321,3603,'莲花县'),(360322,3603,'上栗县'),(360323,3603,'芦溪县'),(360401,3604,'市辖区'),(360402,3604,'庐山区'),(360403,3604,'浔阳区'),(360421,3604,'九江县'),(360423,3604,'武宁县'),(360424,3604,'修水县'),(360425,3604,'永修县'),(360426,3604,'德安县'),(360427,3604,'星子县'),(360428,3604,'都昌县'),(360429,3604,'湖口县'),(360430,3604,'彭泽县'),(360481,3604,'瑞昌市'),(360501,3605,'市辖区'),(360502,3605,'渝水区'),(360521,3605,'分宜县'),(360601,3606,'市辖区'),(360602,3606,'月湖区'),(360622,3606,'余江县'),(360681,3606,'贵溪市'),(360701,3607,'市辖区'),(360702,3607,'章贡区'),(360721,3607,'赣  县'),(360722,3607,'信丰县'),(360723,3607,'大余县'),(360724,3607,'上犹县'),(360725,3607,'崇义县'),(360726,3607,'安远县'),(360727,3607,'龙南县'),(360728,3607,'定南县'),(360729,3607,'全南县'),(360730,3607,'宁都县'),(360731,3607,'于都县'),(360732,3607,'兴国县'),(360733,3607,'会昌县'),(360734,3607,'寻乌县'),(360735,3607,'石城县'),(360781,3607,'瑞金市'),(360782,3607,'南康市'),(360801,3608,'市辖区'),(360802,3608,'吉州区'),(360803,3608,'青原区'),(360821,3608,'吉安县'),(360822,3608,'吉水县'),(360823,3608,'峡江县'),(360824,3608,'新干县'),(360825,3608,'永丰县'),(360826,3608,'泰和县'),(360827,3608,'遂川县'),(360828,3608,'万安县'),(360829,3608,'安福县'),(360830,3608,'永新县'),(360881,3608,'井冈山市'),(360901,3609,'市辖区'),(360902,3609,'袁州区'),(360921,3609,'奉新县'),(360922,3609,'万载县'),(360923,3609,'上高县'),(360924,3609,'宜丰县'),(360925,3609,'靖安县'),(360926,3609,'铜鼓县'),(360981,3609,'丰城市'),(360982,3609,'樟树市'),(360983,3609,'高安市'),(361001,3610,'市辖区'),(361002,3610,'临川区'),(361021,3610,'南城县'),(361022,3610,'黎川县'),(361023,3610,'南丰县'),(361024,3610,'崇仁县'),(361025,3610,'乐安县'),(361026,3610,'宜黄县'),(361027,3610,'金溪县'),(361028,3610,'资溪县'),(361029,3610,'东乡县'),(361030,3610,'广昌县'),(361101,3611,'市辖区'),(361102,3611,'信州区'),(361121,3611,'上饶县'),(361122,3611,'广丰县'),(361123,3611,'玉山县'),(361124,3611,'铅山县'),(361125,3611,'横峰县'),(361126,3611,'弋阳县'),(361127,3611,'余干县'),(361128,3611,'波阳县'),(361129,3611,'万年县'),(361130,3611,'婺源县'),(361181,3611,'德兴市'),(370101,3701,'市辖区'),(370102,3701,'历下区'),(370103,3701,'市中区'),(370104,3701,'槐荫区'),(370105,3701,'天桥区'),(370112,3701,'历城区'),(370123,3701,'长清县'),(370124,3701,'平阴县'),(370125,3701,'济阳县'),(370126,3701,'商河县'),(370181,3701,'章丘市'),(370201,3702,'市辖区'),(370202,3702,'市南区'),(370203,3702,'市北区'),(370205,3702,'四方区'),(370211,3702,'黄岛区'),(370212,3702,'崂山区'),(370213,3702,'李沧区'),(370214,3702,'城阳区'),(370281,3702,'胶州市'),(370282,3702,'即墨市'),(370283,3702,'平度市'),(370284,3702,'胶南市'),(370285,3702,'莱西市'),(370301,3703,'市辖区'),(370302,3703,'淄川区'),(370303,3703,'张店区'),(370304,3703,'博山区'),(370305,3703,'临淄区'),(370306,3703,'周村区'),(370321,3703,'桓台县'),(370322,3703,'高青县'),(370323,3703,'沂源县'),(370401,3704,'市辖区'),(370402,3704,'市中区'),(370403,3704,'薛城区'),(370404,3704,'峄城区'),(370405,3704,'台儿庄区'),(370406,3704,'山亭区'),(370481,3704,'滕州市'),(370501,3705,'市辖区'),(370502,3705,'东营区'),(370503,3705,'河口区'),(370521,3705,'垦利县'),(370522,3705,'利津县'),(370523,3705,'广饶县'),(370601,3706,'市辖区'),(370602,3706,'芝罘区'),(370611,3706,'福山区'),(370612,3706,'牟平区'),(370613,3706,'莱山区'),(370634,3706,'长岛县'),(370681,3706,'龙口市'),(370682,3706,'莱阳市'),(370683,3706,'莱州市'),(370684,3706,'蓬莱市'),(370685,3706,'招远市'),(370686,3706,'栖霞市'),(370687,3706,'海阳市'),(370701,3707,'市辖区'),(370702,3707,'潍城区'),(370703,3707,'寒亭区'),(370704,3707,'坊子区'),(370705,3707,'奎文区'),(370724,3707,'临朐县'),(370725,3707,'昌乐县'),(370781,3707,'青州市'),(370782,3707,'诸城市'),(370783,3707,'寿光市'),(370784,3707,'安丘市'),(370785,3707,'高密市'),(370786,3707,'昌邑市'),(370801,3708,'市辖区'),(370802,3708,'市中区'),(370811,3708,'任城区'),(370826,3708,'微山县'),(370827,3708,'鱼台县'),(370828,3708,'金乡县'),(370829,3708,'嘉祥县'),(370830,3708,'汶上县'),(370831,3708,'泗水县'),(370832,3708,'梁山县'),(370881,3708,'曲阜市'),(370882,3708,'兖州市'),(370883,3708,'邹城市'),(370901,3709,'市辖区'),(370902,3709,'泰山区'),(370903,3709,'岱岳区'),(370921,3709,'宁阳县'),(370923,3709,'东平县'),(370982,3709,'新泰市'),(370983,3709,'肥城市'),(371001,3710,'市辖区'),(371002,3710,'环翠区'),(371081,3710,'文登市'),(371082,3710,'荣成市'),(371083,3710,'乳山市'),(371101,3711,'市辖区'),(371102,3711,'东港区'),(371121,3711,'五莲县'),(371122,3711,'莒  县'),(371201,3712,'市辖区'),(371202,3712,'莱城区'),(371203,3712,'钢城区'),(371301,3713,'市辖区'),(371302,3713,'兰山区'),(371311,3713,'罗庄区'),(371312,3713,'河东区'),(371321,3713,'沂南县'),(371322,3713,'郯城县'),(371323,3713,'沂水县'),(371324,3713,'苍山县'),(371325,3713,'费  县'),(371326,3713,'平邑县'),(371327,3713,'莒南县'),(371328,3713,'蒙阴县'),(371329,3713,'临沭县'),(371401,3714,'市辖区'),(371402,3714,'德城区'),(371421,3714,'陵  县'),(371422,3714,'宁津县'),(371423,3714,'庆云县'),(371424,3714,'临邑县'),(371425,3714,'齐河县'),(371426,3714,'平原县'),(371427,3714,'夏津县'),(371428,3714,'武城县'),(371481,3714,'乐陵市'),(371482,3714,'禹城市'),(371501,3715,'市辖区'),(371502,3715,'东昌府区'),(371521,3715,'阳谷县'),(371522,3715,'莘  县'),(371523,3715,'茌平县'),(371524,3715,'东阿县'),(371525,3715,'冠  县'),(371526,3715,'高唐县'),(371581,3715,'临清市'),(371601,3716,'市辖区'),(371603,3716,'滨城区'),(371621,3716,'惠民县'),(371622,3716,'阳信县'),(371623,3716,'无棣县'),(371624,3716,'沾化县'),(371625,3716,'博兴县'),(371626,3716,'邹平县'),(371701,3717,'市辖区'),(371702,3717,'牡丹区'),(371721,3717,'曹  县'),(371722,3717,'单  县'),(371723,3717,'成武县'),(371724,3717,'巨野县'),(371725,3717,'郓城县'),(371726,3717,'鄄城县'),(371727,3717,'定陶县'),(371728,3717,'东明县'),(410101,4101,'市辖区'),(410102,4101,'中原区'),(410103,4101,'二七区'),(410104,4101,'管城回族区'),(410105,4101,'金水区'),(410106,4101,'上街区'),(410108,4101,'邙山区'),(410122,4101,'中牟县'),(410181,4101,'巩义市'),(410182,4101,'荥阳市'),(410183,4101,'新密市'),(410184,4101,'新郑市'),(410185,4101,'登封市'),(410201,4102,'市辖区'),(410202,4102,'龙亭区'),(410203,4102,'顺河回族区'),(410204,4102,'鼓楼区'),(410205,4102,'南关区'),(410211,4102,'郊  区'),(410221,4102,'杞  县'),(410222,4102,'通许县'),(410223,4102,'尉氏县'),(410224,4102,'开封县'),(410225,4102,'兰考县'),(410301,4103,'市辖区'),(410302,4103,'老城区'),(410303,4103,'西工区'),(410304,4103,'廛河回族区'),(410305,4103,'涧西区'),(410306,4103,'吉利区'),(410307,4103,'洛龙区'),(410322,4103,'孟津县'),(410323,4103,'新安县'),(410324,4103,'栾川县'),(410325,4103,'嵩  县'),(410326,4103,'汝阳县'),(410327,4103,'宜阳县'),(410328,4103,'洛宁县'),(410329,4103,'伊川县'),(410381,4103,'偃师市'),(410401,4104,'市辖区'),(410402,4104,'新华区'),(410403,4104,'卫东区'),(410404,4104,'石龙区'),(410411,4104,'湛河区'),(410421,4104,'宝丰县'),(410422,4104,'叶  县'),(410423,4104,'鲁山县'),(410425,4104,'郏  县'),(410481,4104,'舞钢市'),(410482,4104,'汝州市'),(410501,4105,'市辖区'),(410502,4105,'文峰区'),(410503,4105,'北关区'),(410504,4105,'铁西区'),(410511,4105,'郊  区'),(410522,4105,'安阳县'),(410523,4105,'汤阴县'),(410526,4105,'滑  县'),(410527,4105,'内黄县'),(410581,4105,'林州市'),(410601,4106,'市辖区'),(410602,4106,'鹤山区'),(410603,4106,'山城区'),(410611,4106,'郊  区'),(410621,4106,'浚  县'),(410622,4106,'淇  县'),(410701,4107,'市辖区'),(410702,4107,'红旗区'),(410703,4107,'新华区'),(410704,4107,'北站区'),(410711,4107,'郊  区'),(410721,4107,'新乡县'),(410724,4107,'获嘉县'),(410725,4107,'原阳县'),(410726,4107,'延津县'),(410727,4107,'封丘县'),(410728,4107,'长垣县'),(410781,4107,'卫辉市'),(410782,4107,'辉县市'),(410801,4108,'市辖区'),(410802,4108,'解放区'),(410803,4108,'中站区'),(410804,4108,'马村区'),(410811,4108,'山阳区'),(410821,4108,'修武县'),(410822,4108,'博爱县'),(410823,4108,'武陟县'),(410825,4108,'温  县'),(410881,4108,'济源市'),(410882,4108,'沁阳市'),(410883,4108,'孟州市'),(410901,4109,'市辖区'),(410902,4109,'市  区'),(410922,4109,'清丰县'),(410923,4109,'南乐县'),(410926,4109,'范  县'),(410927,4109,'台前县'),(410928,4109,'濮阳县'),(411001,4110,'市辖区'),(411002,4110,'魏都区'),(411023,4110,'许昌县'),(411024,4110,'鄢陵县'),(411025,4110,'襄城县'),(411081,4110,'禹州市'),(411082,4110,'长葛市'),(411101,4111,'市辖区'),(411102,4111,'源汇区'),(411121,4111,'舞阳县'),(411122,4111,'临颍县'),(411123,4111,'郾城县'),(411201,4112,'市辖区'),(411202,4112,'湖滨区'),(411221,4112,'渑池县'),(411222,4112,'陕  县'),(411224,4112,'卢氏县'),(411281,4112,'义马市'),(411282,4112,'灵宝市'),(411301,4113,'市辖区'),(411302,4113,'宛城区'),(411303,4113,'卧龙区'),(411321,4113,'南召县'),(411322,4113,'方城县'),(411323,4113,'西峡县'),(411324,4113,'镇平县'),(411325,4113,'内乡县'),(411326,4113,'淅川县'),(411327,4113,'社旗县'),(411328,4113,'唐河县'),(411329,4113,'新野县'),(411330,4113,'桐柏县'),(411381,4113,'邓州市'),(411401,4114,'市辖区'),(411402,4114,'梁园区'),(411403,4114,'睢阳区'),(411421,4114,'民权县'),(411422,4114,'睢  县'),(411423,4114,'宁陵县'),(411424,4114,'柘城县'),(411425,4114,'虞城县'),(411426,4114,'夏邑县'),(411481,4114,'永城市'),(411501,4115,'市辖区'),(411502,4115,'师河区'),(411503,4115,'平桥区'),(411521,4115,'罗山县'),(411522,4115,'光山县'),(411523,4115,'新  县'),(411524,4115,'商城县'),(411525,4115,'固始县'),(411526,4115,'潢川县'),(411527,4115,'淮滨县'),(411528,4115,'息  县'),(411601,4116,'市辖区'),(411602,4116,'川汇区'),(411621,4116,'扶沟县'),(411622,4116,'西华县'),(411623,4116,'商水县'),(411624,4116,'沈丘县'),(411625,4116,'郸城县'),(411626,4116,'淮阳县'),(411627,4116,'太康县'),(411628,4116,'鹿邑县'),(411681,4116,'项城市'),(411701,4117,'市辖区'),(411702,4117,'驿城区'),(411721,4117,'西平县'),(411722,4117,'上蔡县'),(411723,4117,'平舆县'),(411724,4117,'正阳县'),(411725,4117,'确山县'),(411726,4117,'泌阳县'),(411727,4117,'汝南县'),(411728,4117,'遂平县'),(411729,4117,'新蔡县'),(420101,4201,'市辖区'),(420102,4201,'江岸区'),(420103,4201,'江汉区'),(420104,4201,'乔口区'),(420105,4201,'汉阳区'),(420106,4201,'武昌区'),(420107,4201,'青山区'),(420111,4201,'洪山区'),(420112,4201,'东西湖区'),(420113,4201,'汉南区'),(420114,4201,'蔡甸区'),(420115,4201,'江夏区'),(420116,4201,'黄陂区'),(420117,4201,'新洲区'),(420201,4202,'市辖区'),(420202,4202,'黄石港区'),(420203,4202,'石灰窑区'),(420204,4202,'下陆区'),(420205,4202,'铁山区'),(420222,4202,'阳新县'),(420281,4202,'大冶市'),(420301,4203,'市辖区'),(420302,4203,'茅箭区'),(420303,4203,'张湾区'),(420321,4203,'郧  县'),(420322,4203,'郧西县'),(420323,4203,'竹山县'),(420324,4203,'竹溪县'),(420325,4203,'房  县'),(420381,4203,'丹江口市'),(420501,4205,'市辖区'),(420502,4205,'西陵区'),(420503,4205,'伍家岗区'),(420504,4205,'点军区'),(420505,4205,'虎亭区'),(420521,4205,'宜昌县'),(420525,4205,'远安县'),(420526,4205,'兴山县'),(420527,4205,'秭归县'),(420528,4205,'长阳土家族自治县'),(420529,4205,'五峰土家族自治县'),(420581,4205,'宜都市'),(420582,4205,'当阳市'),(420583,4205,'枝江市'),(420601,4206,'市辖区'),(420602,4206,'襄城区'),(420606,4206,'樊城区'),(420621,4206,'襄阳县'),(420624,4206,'南漳县'),(420625,4206,'谷城县'),(420626,4206,'保康县'),(420682,4206,'老河口市'),(420683,4206,'枣阳市'),(420684,4206,'宜城市'),(420701,4207,'市辖区'),(420702,4207,'梁子湖区'),(420703,4207,'华容区'),(420704,4207,'鄂城区'),(420801,4208,'市辖区'),(420802,4208,'东宝区'),(420821,4208,'京山县'),(420822,4208,'沙洋县'),(420881,4208,'钟祥市'),(420901,4209,'市辖区'),(420902,4209,'孝南区'),(420921,4209,'孝昌县'),(420922,4209,'大悟县'),(420923,4209,'云梦县'),(420981,4209,'应城市'),(420982,4209,'安陆市'),(420984,4209,'汉川市'),(421001,4210,'市辖区'),(421002,4210,'沙市区'),(421003,4210,'荆州区'),(421022,4210,'公安县'),(421023,4210,'监利县'),(421024,4210,'江陵县'),(421081,4210,'石首市'),(421083,4210,'洪湖市'),(421087,4210,'松滋市'),(421101,4211,'市辖区'),(421102,4211,'黄州区'),(421121,4211,'团风县'),(421122,4211,'红安县'),(421123,4211,'罗田县'),(421124,4211,'英山县'),(421125,4211,'浠水县'),(421126,4211,'蕲春县'),(421127,4211,'黄梅县'),(421181,4211,'麻城市'),(421182,4211,'武穴市'),(421201,4212,'市辖区'),(421202,4212,'咸安区'),(421221,4212,'嘉鱼县'),(421222,4212,'通城县'),(421223,4212,'崇阳县'),(421224,4212,'通山县'),(421281,4212,'赤壁市'),(421301,4213,'市辖区'),(421302,4213,'曾都区'),(421381,4213,'广水市'),(422801,4228,'恩施市'),(422802,4228,'利川市'),(422822,4228,'建始县'),(422823,4228,'巴东县'),(422825,4228,'宣恩县'),(422826,4228,'咸丰县'),(422827,4228,'来凤县'),(422828,4228,'鹤峰县'),(429004,4290,'仙桃市'),(429005,4290,'潜江市'),(429006,4290,'天门市'),(429021,4290,'神农架林区'),(430101,4301,'市辖区'),(430102,4301,'芙蓉区'),(430103,4301,'天心区'),(430104,4301,'岳麓区'),(430105,4301,'开福区'),(430111,4301,'雨花区'),(430121,4301,'长沙县'),(430122,4301,'望城县'),(430124,4301,'宁乡县'),(430181,4301,'浏阳市'),(430201,4302,'市辖区'),(430202,4302,'荷塘区'),(430203,4302,'芦淞区'),(430204,4302,'石峰区'),(430211,4302,'天元区'),(430221,4302,'株洲县'),(430223,4302,'攸  县'),(430224,4302,'茶陵县'),(430225,4302,'炎陵县'),(430281,4302,'醴陵市'),(430301,4303,'市辖区'),(430302,4303,'雨湖区'),(430304,4303,'岳塘区'),(430321,4303,'湘潭县'),(430381,4303,'湘乡市'),(430382,4303,'韶山市'),(430401,4304,'市辖区'),(430402,4304,'江东区'),(430403,4304,'城南区'),(430404,4304,'城北区'),(430411,4304,'郊   区'),(430412,4304,'南岳区'),(430421,4304,'衡阳县'),(430422,4304,'衡南县'),(430423,4304,'衡山县'),(430424,4304,'衡东县'),(430426,4304,'祁东县'),(430481,4304,'耒阳市'),(430482,4304,'常宁市'),(430501,4305,'市辖区'),(430502,4305,'双清区'),(430503,4305,'大祥区'),(430511,4305,'北塔区'),(430521,4305,'邵东县'),(430522,4305,'新邵县'),(430523,4305,'邵阳县'),(430524,4305,'隆回县'),(430525,4305,'洞口县'),(430527,4305,'绥宁县'),(430528,4305,'新宁县'),(430529,4305,'城步苗族自治县'),(430581,4305,'武冈市'),(430601,4306,'市辖区'),(430602,4306,'岳阳楼区'),(430603,4306,'云溪区'),(430611,4306,'君山区'),(430621,4306,'岳阳县'),(430623,4306,'华容县'),(430624,4306,'湘阴县'),(430626,4306,'平江县'),(430681,4306,'汨罗市'),(430682,4306,'临湘市'),(430701,4307,'市辖区'),(430702,4307,'武陵区'),(430703,4307,'鼎城区'),(430721,4307,'安乡县'),(430722,4307,'汉寿县'),(430723,4307,'澧  县'),(430724,4307,'临澧县'),(430725,4307,'桃源县'),(430726,4307,'石门县'),(430781,4307,'津市市'),(430801,4308,'市辖区'),(430802,4308,'永定区'),(430811,4308,'武陵源区'),(430821,4308,'慈利县'),(430822,4308,'桑植县'),(430901,4309,'市辖区'),(430902,4309,'资阳区'),(430903,4309,'赫山区'),(430921,4309,'南  县'),(430922,4309,'桃江县'),(430923,4309,'安化县'),(430981,4309,'沅江市'),(431001,4310,'市辖区'),(431002,4310,'北湖区'),(431003,4310,'苏仙区'),(431021,4310,'桂阳县'),(431022,4310,'宜章县'),(431023,4310,'永兴县'),(431024,4310,'嘉禾县'),(431025,4310,'临武县'),(431026,4310,'汝城县'),(431027,4310,'桂东县'),(431028,4310,'安仁县'),(431081,4310,'资兴市'),(431101,4311,'市辖区'),(431102,4311,'芝山区'),(431103,4311,'冷水滩区'),(431121,4311,'祁阳县'),(431122,4311,'东安县'),(431123,4311,'双牌县'),(431124,4311,'道  县'),(431125,4311,'江永县'),(431126,4311,'宁远县'),(431127,4311,'蓝山县'),(431128,4311,'新田县'),(431129,4311,'江华瑶族自治县'),(431201,4312,'市辖区'),(431202,4312,'鹤城区'),(431221,4312,'中方县'),(431222,4312,'沅陵县'),(431223,4312,'辰溪县'),(431224,4312,'溆浦县'),(431225,4312,'会同县'),(431226,4312,'麻阳苗族自治县'),(431227,4312,'新晃侗族自治县'),(431228,4312,'芷江侗族自治县'),(431229,4312,'靖州苗族侗族自治县'),(431230,4312,'通道侗族自治县'),(431281,4312,'洪江市'),(431301,4313,'市辖区'),(431302,4313,'娄星区'),(431321,4313,'双峰县'),(431322,4313,'新化县'),(431381,4313,'冷水江市'),(431382,4313,'涟源市'),(433101,4331,'吉首市'),(433122,4331,'泸溪县'),(433123,4331,'凤凰县'),(433124,4331,'花垣县'),(433125,4331,'保靖县'),(433126,4331,'古丈县'),(433127,4331,'永顺县'),(433130,4331,'龙山县'),(440101,4401,'市辖区'),(440102,4401,'东山区'),(440103,4401,'荔湾区'),(440104,4401,'越秀区'),(440105,4401,'海珠区'),(440106,4401,'天河区'),(440107,4401,'芳村区'),(440111,4401,'白云区'),(440112,4401,'黄埔区'),(440113,4401,'番禺区'),(440114,4401,'花都区'),(440183,4401,'增城市'),(440184,4401,'从化市'),(440201,4402,'市辖区'),(440202,4402,'北江区'),(440203,4402,'武江区'),(440204,4402,'浈江区'),(440221,4402,'曲江县'),(440222,4402,'始兴县'),(440224,4402,'仁化县'),(440229,4402,'翁源县'),(440232,4402,'乳源瑶族自治县'),(440233,4402,'新丰县'),(440281,4402,'乐昌市'),(440282,4402,'南雄市'),(440301,4403,'市辖区'),(440303,4403,'罗湖区'),(440304,4403,'福田区'),(440305,4403,'南山区'),(440306,4403,'宝安区'),(440307,4403,'龙岗区'),(440308,4403,'盐田区'),(440401,4404,'市辖区'),(440402,4404,'香洲区'),(440421,4404,'斗门县'),(440501,4405,'市辖区'),(440506,4405,'达濠区'),(440507,4405,'龙湖区'),(440508,4405,'金园区'),(440509,4405,'升平区'),(440510,4405,'河浦区'),(440523,4405,'南澳县'),(440582,4405,'潮阳市'),(440583,4405,'澄海市'),(440601,4406,'市辖区'),(440602,4406,'城  区'),(440603,4406,'石湾区'),(440681,4406,'顺德市'),(440682,4406,'南海市'),(440683,4406,'三水市'),(440684,4406,'高明市'),(440701,4407,'市辖区'),(440703,4407,'蓬江区'),(440704,4407,'江海区'),(440781,4407,'台山市'),(440782,4407,'新会市'),(440783,4407,'开平市'),(440784,4407,'鹤山市'),(440785,4407,'恩平市'),(440801,4408,'市辖区'),(440802,4408,'赤坎区'),(440803,4408,'霞山区'),(440804,4408,'坡头区'),(440811,4408,'麻章区'),(440823,4408,'遂溪县'),(440825,4408,'徐闻县'),(440881,4408,'廉江市'),(440882,4408,'雷州市'),(440883,4408,'吴川市'),(440901,4409,'市辖区'),(440902,4409,'茂南区'),(440923,4409,'电白县'),(440981,4409,'高州市'),(440982,4409,'化州市'),(440983,4409,'信宜市'),(441201,4412,'市辖区'),(441202,4412,'端州区'),(441203,4412,'鼎湖区'),(441223,4412,'广宁县'),(441224,4412,'怀集县'),(441225,4412,'封开县'),(441226,4412,'德庆县'),(441283,4412,'高要市'),(441284,4412,'四会市'),(441301,4413,'市辖区'),(441302,4413,'惠城区'),(441322,4413,'博罗县'),(441323,4413,'惠东县'),(441324,4413,'龙门县'),(441381,4413,'惠阳市'),(441401,4414,'市辖区'),(441402,4414,'梅江区'),(441421,4414,'梅  县'),(441422,4414,'大埔县'),(441423,4414,'丰顺县'),(441424,4414,'五华县'),(441426,4414,'平远县'),(441427,4414,'蕉岭县'),(441481,4414,'兴宁市'),(441501,4415,'市辖区'),(441502,4415,'城  区'),(441521,4415,'海丰县'),(441523,4415,'陆河县'),(441581,4415,'陆丰市'),(441601,4416,'市辖区'),(441602,4416,'源城区'),(441621,4416,'紫金县'),(441622,4416,'龙川县'),(441623,4416,'连平县'),(441624,4416,'和平县'),(441625,4416,'东源县'),(441701,4417,'市辖区'),(441702,4417,'江城区'),(441721,4417,'阳西县'),(441723,4417,'阳东县'),(441781,4417,'阳春市'),(441801,4418,'市辖区'),(441802,4418,'清城区'),(441821,4418,'佛冈县'),(441823,4418,'阳山县'),(441825,4418,'连山壮族瑶族自治县'),(441826,4418,'连南瑶族自治县'),(441827,4418,'清新县'),(441881,4418,'英德市'),(441882,4418,'连州市'),(441901,4419,'莞城区'),(441902,4419,'东城区'),(441903,4419,'南城区'),(441904,4419,'万江区'),(442001,4420,'石岐区'),(442002,4420,'东区'),(442003,4420,'西区'),(442004,4420,'南区'),(442005,4420,'五桂山'),(445101,4451,'市辖区'),(445102,4451,'湘桥区'),(445121,4451,'潮安县'),(445122,4451,'饶平县'),(445201,4452,'市辖区'),(445202,4452,'榕城区'),(445221,4452,'揭东县'),(445222,4452,'揭西县'),(445224,4452,'惠来县'),(445281,4452,'普宁市'),(445301,4453,'市辖区'),(445302,4453,'云城区'),(445321,4453,'新兴县'),(445322,4453,'郁南县'),(445323,4453,'云安县'),(445381,4453,'罗定市'),(450101,4501,'市辖区'),(450102,4501,'兴宁区'),(450103,4501,'新城区'),(450104,4501,'城北区'),(450105,4501,'江南区'),(450106,4501,'永新区'),(450111,4501,'市郊区'),(450121,4501,'邕宁县'),(450122,4501,'武鸣县'),(450201,4502,'市辖区'),(450202,4502,'城中区'),(450203,4502,'鱼峰区'),(450204,4502,'柳南区'),(450205,4502,'柳北区'),(450211,4502,'市郊区'),(450221,4502,'柳江县'),(450222,4502,'柳城县'),(450301,4503,'市辖区'),(450302,4503,'秀峰区'),(450303,4503,'叠彩区'),(450304,4503,'象山区'),(450305,4503,'七星区'),(450311,4503,'雁山区'),(450321,4503,'阳朔县'),(450322,4503,'临桂县'),(450323,4503,'灵川县'),(450324,4503,'全州县'),(450325,4503,'兴安县'),(450326,4503,'永福县'),(450327,4503,'灌阳县'),(450328,4503,'龙胜各县自治区'),(450329,4503,'资源县'),(450330,4503,'平乐县'),(450331,4503,'荔蒲县'),(450332,4503,'恭城瑶族自治县'),(450401,4504,'市辖区'),(450403,4504,'万秀区'),(450404,4504,'蝶山区'),(450411,4504,'市郊区'),(450421,4504,'苍梧县'),(450422,4504,'藤  县'),(450423,4504,'蒙山县'),(450481,4504,'岑溪市'),(450501,4505,'市辖区'),(450502,4505,'海城区'),(450503,4505,'银海区'),(450512,4505,'铁山港区'),(450521,4505,'合浦县'),(450601,4506,'市辖区'),(450602,4506,'港口区'),(450603,4506,'防城区'),(450621,4506,'上思县'),(450681,4506,'东兴市'),(450701,4507,'市辖区'),(450702,4507,'钦南区'),(450703,4507,'钦北区'),(450721,4507,'浦北县'),(450722,4507,'灵山县'),(450801,4508,'市辖区'),(450802,4508,'港北区'),(450803,4508,'港南区'),(450821,4508,'平南县'),(450881,4508,'桂平市'),(450901,4509,'市辖区'),(450902,4509,'玉州区'),(450921,4509,'容  县'),(450922,4509,'陆川县'),(450923,4509,'博白县'),(450924,4509,'兴业县'),(450981,4509,'北流市'),(452101,4521,'凭祥市'),(452122,4521,'横  县'),(452123,4521,'宾阳县'),(452124,4521,'上林县'),(452126,4521,'隆安县'),(452127,4521,'马山县'),(452128,4521,'扶绥县'),(452129,4521,'崇左县'),(452130,4521,'大新县'),(452131,4521,'天等县'),(452132,4521,'宁明县'),(452133,4521,'龙州县'),(452201,4522,'合山市'),(452223,4522,'鹿寨县'),(452224,4522,'象州县'),(452225,4522,'武宣县'),(452226,4522,'来宾县'),(452227,4522,'融安县'),(452228,4522,'三江侗族自治县'),(452229,4522,'融水苗族自治县'),(452230,4522,'金秀瑶族自治县'),(452231,4522,'忻城县'),(452402,4524,'贺州市'),(452424,4524,'昭平县'),(452427,4524,'钟山县'),(452428,4524,'富川瑶族自治县'),(452601,4526,'百色市'),(452622,4526,'田阳县'),(452623,4526,'田东县'),(452624,4526,'平果县'),(452625,4526,'德保县'),(452626,4526,'靖西县'),(452627,4526,'那坡县'),(452628,4526,'凌云县'),(452629,4526,'乐业县'),(452630,4526,'田林县'),(452631,4526,'隆林各族自治县'),(452632,4526,'西林县'),(452701,4527,'河池市'),(452702,4527,'宜州市'),(452723,4527,'罗城仫佬族自治县'),(452724,4527,'环江毛南族自治县'),(452725,4527,'南丹县'),(452726,4527,'天峨县'),(452727,4527,'凤山县'),(452728,4527,'东兰县'),(452729,4527,'巴马瑶族自治县'),(452730,4527,'都安瑶族自治县'),(452731,4527,'大化瑶族自治县'),(460101,4601,'通什市'),(460102,4601,'琼海市'),(460103,4601,'儋州市'),(460104,4601,'琼山市'),(460105,4601,'文昌市'),(460106,4601,'万宁市'),(460107,4601,'东方市'),(460125,4601,'定安县'),(460126,4601,'屯昌县'),(460127,4601,'澄迈县'),(460128,4601,'临高县'),(460130,4601,'白沙黎族自治县'),(460131,4601,'昌江黎族自治县'),(460133,4601,'乐东黎族自治县'),(460134,4601,'陵水黎族自治县'),(460135,4601,'保亭黎族苗族自治县'),(460136,4601,'琼中黎族苗族自治县'),(460137,4601,'西沙群岛'),(460138,4601,'南沙群岛'),(460139,4601,'中沙群岛的岛礁及其海'),(460201,4602,'市辖区'),(460202,4602,'振东区'),(460203,4602,'新华区'),(460204,4602,'秀英区'),(460301,4603,'市辖区'),(500101,5001,'万州区'),(500102,5001,'涪陵区'),(500103,5001,'渝中区'),(500104,5001,'大渡口区'),(500105,5001,'江北区'),(500106,5001,'沙坪坝区'),(500107,5001,'九龙坡区'),(500108,5001,'南岸区'),(500109,5001,'北碚区'),(500110,5001,'万盛区'),(500111,5001,'双桥区'),(500112,5001,'渝北区'),(500113,5001,'巴南区'),(500114,5001,'黔江区'),(500221,5002,'长寿县'),(500222,5002,'綦江县'),(500223,5002,'潼南县'),(500224,5002,'铜梁县'),(500225,5002,'大足县'),(500226,5002,'荣昌县'),(500227,5002,'璧山县'),(500228,5002,'梁平县'),(500229,5002,'城口县'),(500230,5002,'丰都县'),(500231,5002,'垫江县'),(500232,5002,'武隆县'),(500233,5002,'忠  县'),(500234,5002,'开  县'),(500235,5002,'云阳县'),(500236,5002,'奉节县'),(500237,5002,'巫山县'),(500238,5002,'巫溪县'),(500240,5002,'石柱土家族自治县'),(500241,5002,'秀山土家族苗族自治县'),(500242,5002,'酉阳土家族苗族自治县'),(500243,5002,'彭水苗族土家族自治县'),(500381,5003,'江津市'),(500382,5003,'合川市'),(500383,5003,'永川市'),(500384,5003,'南川市'),(510101,5101,'市辖区'),(510103,5101,'高新区'),(510104,5101,'锦江区'),(510105,5101,'青羊区'),(510106,5101,'金牛区'),(510107,5101,'武侯区'),(510108,5101,'成华区'),(510112,5101,'龙泉驿区'),(510113,5101,'青白江区'),(510121,5101,'金堂县'),(510122,5101,'双流县'),(510123,5101,'温江县'),(510124,5101,'郫  县'),(510125,5101,'新都县'),(510129,5101,'大邑县'),(510131,5101,'蒲江县'),(510132,5101,'新津县'),(510181,5101,'都江堰市'),(510182,5101,'彭州市'),(510183,5101,'邛崃市'),(510184,5101,'崇州市'),(510301,5103,'市辖区'),(510302,5103,'自流井区'),(510303,5103,'贡井区'),(510304,5103,'大安区'),(510311,5103,'沿滩区'),(510321,5103,'荣  县'),(510322,5103,'富顺县'),(510401,5104,'市辖区'),(510402,5104,'东  区'),(510403,5104,'西  区'),(510411,5104,'仁和区'),(510421,5104,'米易县'),(510422,5104,'盐边县'),(510501,5105,'市辖区'),(510502,5105,'江阳区'),(510503,5105,'纳溪区'),(510504,5105,'龙马潭区'),(510521,5105,'泸  县'),(510522,5105,'合江县'),(510524,5105,'叙永县'),(510525,5105,'古蔺县'),(510601,5106,'市辖区'),(510603,5106,'旌阳区'),(510623,5106,'中江县'),(510626,5106,'罗江县'),(510681,5106,'广汉市'),(510682,5106,'什邡市'),(510683,5106,'绵竹市'),(510701,5107,'市辖区'),(510703,5107,'涪城区'),(510704,5107,'游仙区'),(510710,5107,'科学城区'),(510722,5107,'三台县'),(510723,5107,'盐亭县'),(510724,5107,'安  县'),(510725,5107,'梓潼县'),(510726,5107,'北川县'),(510727,5107,'平武县'),(510781,5107,'江油市'),(510801,5108,'市辖区'),(510802,5108,'市中区'),(510811,5108,'元坝区'),(510812,5108,'朝天区'),(510821,5108,'旺苍县'),(510822,5108,'青川县'),(510823,5108,'剑阁县'),(510824,5108,'苍溪县'),(510901,5109,'市辖区'),(510902,5109,'市中区'),(510921,5109,'蓬溪县'),(510922,5109,'射洪县'),(510923,5109,'大英县'),(511001,5110,'市辖区'),(511002,5110,'市中区'),(511011,5110,'东兴区'),(511024,5110,'威远县'),(511025,5110,'资中县'),(511028,5110,'隆昌县'),(511101,5111,'市辖区'),(511102,5111,'市中区'),(511111,5111,'沙湾区'),(511112,5111,'五通桥区'),(511113,5111,'金口河区'),(511123,5111,'犍为县'),(511124,5111,'井研县'),(511126,5111,'夹江县'),(511129,5111,'沐川县'),(511132,5111,'峨边彝族自治县'),(511133,5111,'马边彝族自治县'),(511181,5111,'峨眉山市'),(511301,5113,'市辖区'),(511302,5113,'顺庆区'),(511303,5113,'高坪区'),(511304,5113,'嘉陵区'),(511321,5113,'南部县'),(511322,5113,'营山县'),(511323,5113,'蓬安县'),(511324,5113,'仪陇县'),(511325,5113,'西充县'),(511381,5113,'阆中市'),(511401,5114,'市辖区'),(511402,5114,'东坡区'),(511421,5114,'仁寿县'),(511422,5114,'彭山县'),(511423,5114,'洪雅县'),(511424,5114,'丹棱县'),(511425,5114,'青神县'),(511501,5115,'市辖区'),(511502,5115,'翠屏区'),(511521,5115,'宜宾县'),(511522,5115,'南溪县'),(511523,5115,'江安县'),(511524,5115,'长宁县'),(511525,5115,'高  县'),(511526,5115,'珙  县'),(511527,5115,'筠连县'),(511528,5115,'兴文县'),(511529,5115,'屏山县'),(511601,5116,'市辖区'),(511602,5116,'广安区'),(511621,5116,'岳池县'),(511622,5116,'武胜县'),(511623,5116,'邻水县'),(511681,5116,'华蓥市'),(511701,5117,'市辖区'),(511702,5117,'通川区'),(511721,5117,'达  县'),(511722,5117,'宣汉县'),(511723,5117,'开江县'),(511724,5117,'大竹县'),(511725,5117,'渠  县'),(511781,5117,'万源市'),(511801,5118,'市辖区'),(511802,5118,'雨城区'),(511821,5118,'名山县'),(511822,5118,'荥经县'),(511823,5118,'汉源县'),(511824,5118,'石棉县'),(511825,5118,'天全县'),(511826,5118,'芦山县'),(511827,5118,'宝兴县'),(511901,5119,'市辖区'),(511902,5119,'巴州区'),(511921,5119,'通江县'),(511922,5119,'南江县'),(511923,5119,'平昌县'),(512001,5120,'市辖区'),(512002,5120,'雁江区'),(512021,5120,'安岳县'),(512022,5120,'乐至县'),(512081,5120,'简阳市'),(513221,5132,'汶川县'),(513222,5132,'理  县'),(513223,5132,'茂  县'),(513224,5132,'松潘县'),(513225,5132,'九寨沟县'),(513226,5132,'金川县'),(513227,5132,'小金县'),(513228,5132,'黑水县'),(513229,5132,'马尔康县'),(513230,5132,'壤塘县'),(513231,5132,'阿坝县'),(513232,5132,'若尔盖县'),(513233,5132,'红原县'),(513321,5133,'康定县'),(513322,5133,'泸定县'),(513323,5133,'丹巴县'),(513324,5133,'九龙县'),(513325,5133,'雅江县'),(513326,5133,'道孚县'),(513327,5133,'炉霍县'),(513328,5133,'甘孜县'),(513329,5133,'新龙县'),(513330,5133,'德格县'),(513331,5133,'白玉县'),(513332,5133,'石渠县'),(513333,5133,'色达县'),(513334,5133,'理塘县'),(513335,5133,'巴塘县'),(513336,5133,'乡城县'),(513337,5133,'稻城县'),(513338,5133,'得荣县'),(513401,5134,'西昌市'),(513422,5134,'木里藏族自治县'),(513423,5134,'盐源县'),(513424,5134,'德昌县'),(513425,5134,'会理县'),(513426,5134,'会东县'),(513427,5134,'宁南县'),(513428,5134,'普格县'),(513429,5134,'布拖县'),(513430,5134,'金阳县'),(513431,5134,'昭觉县'),(513432,5134,'喜德县'),(513433,5134,'冕宁县'),(513434,5134,'越西县'),(513435,5134,'甘洛县'),(513436,5134,'美姑县'),(513437,5134,'雷波县'),(520101,5201,'市辖区'),(520102,5201,'南明区'),(520103,5201,'云岩区'),(520111,5201,'花溪区'),(520112,5201,'乌当区'),(520113,5201,'白云区'),(520114,5201,'小河区'),(520121,5201,'开阳县'),(520122,5201,'息烽县'),(520123,5201,'修文县'),(520181,5201,'清镇市'),(520201,5202,'钟山区'),(520203,5202,'六枝特区'),(520221,5202,'水城县'),(520222,5202,'盘  县'),(520301,5203,'市辖区'),(520302,5203,'红花岗区'),(520321,5203,'遵义县'),(520322,5203,'桐梓县'),(520323,5203,'绥阳县'),(520324,5203,'正安县'),(520325,5203,'道真仡佬族苗族自治县'),(520326,5203,'务川仡佬族苗族自治县'),(520327,5203,'凤冈县'),(520328,5203,'湄潭县'),(520329,5203,'余庆县'),(520330,5203,'习水县'),(520381,5203,'赤水市'),(520382,5203,'仁怀市'),(520401,5204,'市辖区'),(520402,5204,'西秀区'),(520421,5204,'平坝县'),(520422,5204,'普定县'),(520423,5204,'镇宁布依族苗族自治县'),(520424,5204,'关岭布依族苗族自治县'),(520425,5204,'紫云苗族布依族自治县'),(522201,5222,'铜仁市'),(522222,5222,'江口县'),(522223,5222,'玉屏侗族自治县'),(522224,5222,'石阡县'),(522225,5222,'思南县'),(522226,5222,'印江土家族苗族自治县'),(522227,5222,'德江县'),(522228,5222,'沿河土家族自治县'),(522229,5222,'松桃苗族自治县'),(522230,5222,'万山特区'),(522301,5223,'兴义市'),(522322,5223,'兴仁县'),(522323,5223,'普安县'),(522324,5223,'晴隆县'),(522325,5223,'贞丰县'),(522326,5223,'望谟县'),(522327,5223,'册亨县'),(522328,5223,'安龙县'),(522401,5224,'毕节市'),(522422,5224,'大方县'),(522423,5224,'黔西县'),(522424,5224,'金沙县'),(522425,5224,'织金县'),(522426,5224,'纳雍县'),(522427,5224,'威宁彝族回族苗族自治'),(522428,5224,'赫章县'),(522601,5226,'凯里市'),(522622,5226,'黄平县'),(522623,5226,'施秉县'),(522624,5226,'三穗县'),(522625,5226,'镇远县'),(522626,5226,'岑巩县'),(522627,5226,'天柱县'),(522628,5226,'锦屏县'),(522629,5226,'剑河县'),(522630,5226,'台江县'),(522631,5226,'黎平县'),(522632,5226,'榕江县'),(522633,5226,'从江县'),(522634,5226,'雷山县'),(522635,5226,'麻江县'),(522636,5226,'丹寨县'),(522701,5227,'都匀市'),(522702,5227,'福泉市'),(522722,5227,'荔波县'),(522723,5227,'贵定县'),(522725,5227,'瓮安县'),(522726,5227,'独山县'),(522727,5227,'平塘县'),(522728,5227,'罗甸县'),(522729,5227,'长顺县'),(522730,5227,'龙里县'),(522731,5227,'惠水县'),(522732,5227,'三都水族自治县'),(530101,5301,'市辖区'),(530102,5301,'五华区'),(530103,5301,'盘龙区'),(530111,5301,'官渡区'),(530112,5301,'西山区'),(530113,5301,'东川区'),(530121,5301,'呈贡县'),(530122,5301,'晋宁县'),(530124,5301,'富民县'),(530125,5301,'宜良县'),(530126,5301,'石林彝族自治县'),(530127,5301,'嵩明县'),(530128,5301,'禄劝彝族苗族自治县'),(530129,5301,'寻甸回族彝族自治县'),(530181,5301,'安宁市'),(530301,5303,'市辖区'),(530302,5303,'麒麟区'),(530321,5303,'马龙县'),(530322,5303,'陆良县'),(530323,5303,'师宗县'),(530324,5303,'罗平县'),(530325,5303,'富源县'),(530326,5303,'会泽县'),(530328,5303,'沾益县'),(530381,5303,'宣威市'),(530401,5304,'市辖区'),(530402,5304,'红塔区'),(530421,5304,'江川县'),(530422,5304,'澄江县'),(530423,5304,'通海县'),(530424,5304,'华宁县'),(530425,5304,'易门县'),(530426,5304,'峨山彝族自治县'),(530427,5304,'新平彝族傣族自治县'),(530428,5304,'元江哈尼族彝族傣族自'),(530501,5305,'市辖区'),(530502,5305,'隆阳区'),(530521,5305,'施甸县'),(530522,5305,'腾冲县'),(530523,5305,'龙陵县'),(530524,5305,'昌宁县'),(532101,5321,'昭通市'),(532122,5321,'鲁甸县'),(532123,5321,'巧家县'),(532124,5321,'盐津县'),(532125,5321,'大关县'),(532126,5321,'永善县'),(532127,5321,'绥江县'),(532128,5321,'镇雄县'),(532129,5321,'彝良县'),(532130,5321,'威信县'),(532131,5321,'水富县'),(532301,5323,'楚雄市'),(532322,5323,'双柏县'),(532323,5323,'牟定县'),(532324,5323,'南华县'),(532325,5323,'姚安县'),(532326,5323,'大姚县'),(532327,5323,'永仁县'),(532328,5323,'元谋县'),(532329,5323,'武定县'),(532331,5323,'禄丰县'),(532501,5325,'个旧市'),(532502,5325,'开远市'),(532522,5325,'蒙自县'),(532523,5325,'屏边苗族自治县'),(532524,5325,'建水县'),(532525,5325,'石屏县'),(532526,5325,'弥勒县'),(532527,5325,'泸西县'),(532528,5325,'元阳县'),(532529,5325,'红河县'),(532530,5325,'金平苗族瑶族傣族自治'),(532531,5325,'绿春县'),(532532,5325,'河口瑶族自治县'),(532621,5326,'文山县'),(532622,5326,'砚山县'),(532623,5326,'西畴县'),(532624,5326,'麻栗坡县'),(532625,5326,'马关县'),(532626,5326,'丘北县'),(532627,5326,'广南县'),(532628,5326,'富宁县'),(532701,5327,'思茅市'),(532722,5327,'普洱哈尼族彝族自治县'),(532723,5327,'墨江哈尼族自治县'),(532724,5327,'景东彝族自治县'),(532725,5327,'景谷傣族彝族自治县'),(532726,5327,'镇沅彝族哈尼族拉祜族'),(532727,5327,'江城哈尼族彝族自治县'),(532728,5327,'孟连傣族拉祜族佤族自'),(532729,5327,'澜沧拉祜族自治县'),(532730,5327,'西盟佤族自治县'),(532801,5328,'景洪市'),(532822,5328,'勐海县'),(532823,5328,'勐腊县'),(532901,5329,'大理市'),(532922,5329,'漾濞彝族自治县'),(532923,5329,'祥云县'),(532924,5329,'宾川县'),(532925,5329,'弥渡县'),(532926,5329,'南涧彝族自治县'),(532927,5329,'巍山彝族回族自治县'),(532928,5329,'永平县'),(532929,5329,'云龙县'),(532930,5329,'洱源县'),(532931,5329,'剑川县'),(532932,5329,'鹤庆县'),(533102,5331,'瑞丽市'),(533103,5331,'潞西市'),(533122,5331,'梁河县'),(533123,5331,'盈江县'),(533124,5331,'陇川县'),(533221,5332,'丽江纳西族自治县'),(533222,5332,'永胜县'),(533223,5332,'华坪县'),(533224,5332,'宁蒗彝族自治县'),(533321,5333,'泸水县'),(533323,5333,'福贡县'),(533324,5333,'贡山独龙族怒族自治县'),(533325,5333,'兰坪白族普米族自治县'),(533421,5334,'中甸县'),(533422,5334,'德钦县'),(533423,5334,'维西傈僳族自治县'),(533521,5335,'临沧县'),(533522,5335,'凤庆县'),(533523,5335,'云  县'),(533524,5335,'永德县'),(533525,5335,'镇康县'),(533526,5335,'双江拉祜族佤族布朗族'),(533527,5335,'耿马傣族佤族自治县'),(533528,5335,'沧源佤族自治县'),(540101,5401,'市辖区'),(540102,5401,'城关区'),(540121,5401,'林周县'),(540122,5401,'当雄县'),(540123,5401,'尼木县'),(540124,5401,'曲水县'),(540125,5401,'堆龙德庆县'),(540126,5401,'达孜县'),(540127,5401,'墨竹工卡县'),(542121,5421,'昌都县'),(542122,5421,'江达县'),(542123,5421,'贡觉县'),(542124,5421,'类乌齐县'),(542125,5421,'丁青县'),(542126,5421,'察雅县'),(542127,5421,'八宿县'),(542128,5421,'左贡县'),(542129,5421,'芒康县'),(542132,5421,'洛隆县'),(542133,5421,'边坝县'),(542221,5422,'乃东县'),(542222,5422,'扎囊县'),(542223,5422,'贡嘎县'),(542224,5422,'桑日县'),(542225,5422,'琼结县'),(542226,5422,'曲松县'),(542227,5422,'措美县'),(542228,5422,'洛扎县'),(542229,5422,'加查县'),(542231,5422,'隆子县'),(542232,5422,'错那县'),(542233,5422,'浪卡子县'),(542301,5423,'日喀则市'),(542322,5423,'南木林县'),(542323,5423,'江孜县'),(542324,5423,'定日县'),(542325,5423,'萨迦县'),(542326,5423,'拉孜县'),(542327,5423,'昂仁县'),(542328,5423,'谢通门县'),(542329,5423,'白朗县'),(542330,5423,'仁布县'),(542331,5423,'康马县'),(542332,5423,'定结县'),(542333,5423,'仲巴县'),(542334,5423,'亚东县'),(542335,5423,'吉隆县'),(542336,5423,'聂拉木县'),(542337,5423,'萨嘎县'),(542338,5423,'岗巴县'),(542421,5424,'那曲县'),(542422,5424,'嘉黎县'),(542423,5424,'比如县'),(542424,5424,'聂荣县'),(542425,5424,'安多县'),(542426,5424,'申扎县'),(542427,5424,'索  县'),(542428,5424,'班戈县'),(542429,5424,'巴青县'),(542430,5424,'尼玛县'),(542521,5425,'普兰县'),(542522,5425,'札达县'),(542523,5425,'噶尔县'),(542524,5425,'日土县'),(542525,5425,'革吉县'),(542526,5425,'改则县'),(542527,5425,'措勤县'),(542621,5426,'林芝县'),(542622,5426,'工布江达县'),(542623,5426,'米林县'),(542624,5426,'墨脱县'),(542625,5426,'波密县'),(542626,5426,'察隅县'),(542627,5426,'朗  县'),(610101,6101,'市辖区'),(610102,6101,'新城区'),(610103,6101,'碑林区'),(610104,6101,'莲湖区'),(610111,6101,'灞桥区'),(610112,6101,'未央区'),(610113,6101,'雁塔区'),(610114,6101,'阎良区'),(610115,6101,'临潼区'),(610121,6101,'长安县'),(610122,6101,'蓝田县'),(610124,6101,'周至县'),(610125,6101,'户  县'),(610126,6101,'高陵县'),(610201,6102,'市辖区'),(610202,6102,'王益区'),(610203,6102,'印台区'),(610221,6102,'耀  县'),(610222,6102,'宜君县'),(610301,6103,'市辖区'),(610302,6103,'渭滨区'),(610303,6103,'金台区'),(610321,6103,'宝鸡县'),(610322,6103,'凤翔县'),(610323,6103,'岐山县'),(610324,6103,'扶风县'),(610326,6103,'眉  县'),(610327,6103,'陇  县'),(610328,6103,'千阳县'),(610329,6103,'麟游县'),(610330,6103,'凤  县'),(610331,6103,'太白县'),(610401,6104,'市辖区'),(610402,6104,'秦都区'),(610403,6104,'杨陵区'),(610404,6104,'渭城区'),(610422,6104,'三原县'),(610423,6104,'泾阳县'),(610424,6104,'乾  县'),(610425,6104,'礼泉县'),(610426,6104,'永寿县'),(610427,6104,'彬  县'),(610428,6104,'长武县'),(610429,6104,'旬邑县'),(610430,6104,'淳化县'),(610431,6104,'武功县'),(610481,6104,'兴平市'),(610501,6105,'市辖区'),(610502,6105,'临渭区'),(610521,6105,'华  县'),(610522,6105,'潼关县'),(610523,6105,'大荔县'),(610524,6105,'合阳县'),(610525,6105,'澄城县'),(610526,6105,'蒲城县'),(610527,6105,'白水县'),(610528,6105,'富平县'),(610581,6105,'韩城市'),(610582,6105,'华阴市'),(610601,6106,'市辖区'),(610602,6106,'宝塔区'),(610621,6106,'延长县'),(610622,6106,'延川县'),(610623,6106,'子长县'),(610624,6106,'安塞县'),(610625,6106,'志丹县'),(610626,6106,'吴旗县'),(610627,6106,'甘泉县'),(610628,6106,'富  县'),(610629,6106,'洛川县'),(610630,6106,'宜川县'),(610631,6106,'黄龙县'),(610632,6106,'黄陵县'),(610701,6107,'市辖区'),(610702,6107,'汉台区'),(610721,6107,'南郑县'),(610722,6107,'城固县'),(610723,6107,'洋  县'),(610724,6107,'西乡县'),(610725,6107,'勉  县'),(610726,6107,'宁强县'),(610727,6107,'略阳县'),(610728,6107,'镇巴县'),(610729,6107,'留坝县'),(610730,6107,'佛坪县'),(610801,6108,'市辖区'),(610802,6108,'榆阳区'),(610821,6108,'神木县'),(610822,6108,'府谷县'),(610823,6108,'横山县'),(610824,6108,'靖边县'),(610825,6108,'定边县'),(610826,6108,'绥德县'),(610827,6108,'米脂县'),(610828,6108,'佳  县'),(610829,6108,'吴堡县'),(610830,6108,'清涧县'),(610831,6108,'子洲县'),(610901,6109,'市辖区'),(610902,6109,'汉滨区'),(610921,6109,'汉阴县'),(610922,6109,'石泉县'),(610923,6109,'宁陕县'),(610924,6109,'紫阳县'),(610925,6109,'岚皋县'),(610926,6109,'平利县'),(610927,6109,'镇坪县'),(610928,6109,'旬阳县'),(610929,6109,'白河县'),(612501,6125,'商州市'),(612522,6125,'洛南县'),(612523,6125,'丹凤县'),(612524,6125,'商南县'),(612525,6125,'山阳县'),(612526,6125,'镇安县'),(612527,6125,'柞水县'),(620101,6201,'市辖区'),(620102,6201,'城关区'),(620103,6201,'七里河区'),(620104,6201,'西固区'),(620105,6201,'安宁区'),(620111,6201,'红古区'),(620121,6201,'永登县'),(620122,6201,'皋兰县'),(620123,6201,'榆中县'),(620201,6202,'市辖区'),(620301,6203,'市辖区'),(620302,6203,'金川区'),(620321,6203,'永昌县'),(620401,6204,'市辖区'),(620402,6204,'白银区'),(620403,6204,'平川区'),(620421,6204,'靖远县'),(620422,6204,'会宁县'),(620423,6204,'景泰县'),(620501,6205,'市辖区'),(620502,6205,'秦城区'),(620503,6205,'北道区'),(620521,6205,'清水县'),(620522,6205,'秦安县'),(620523,6205,'甘谷县'),(620524,6205,'武山县'),(620525,6205,'张家川回族自治县'),(622101,6221,'玉门市'),(622102,6221,'酒泉市'),(622103,6221,'敦煌市'),(622123,6221,'金塔县'),(622124,6221,'肃北蒙古族自治县'),(622125,6221,'阿克塞哈萨克族自治县'),(622126,6221,'安西县'),(622201,6222,'张掖市'),(622222,6222,'肃南裕固族自治县'),(622223,6222,'民乐县'),(622224,6222,'临泽县'),(622225,6222,'高台县'),(622226,6222,'山丹县'),(622301,6223,'武威市'),(622322,6223,'民勤县'),(622323,6223,'古浪县'),(622326,6223,'天祝藏族自治县'),(622421,6224,'定西县'),(622424,6224,'通渭县'),(622425,6224,'陇西县'),(622426,6224,'渭源县'),(622427,6224,'临洮县'),(622428,6224,'漳  县'),(622429,6224,'岷  县'),(622621,6226,'武都县'),(622623,6226,'宕昌县'),(622624,6226,'成  县'),(622625,6226,'康  县'),(622626,6226,'文  县'),(622627,6226,'西和县'),(622628,6226,'礼  县'),(622629,6226,'两当县'),(622630,6226,'徽  县'),(622701,6227,'平凉市'),(622722,6227,'泾川县'),(622723,6227,'灵台县'),(622724,6227,'崇信县'),(622725,6227,'华亭县'),(622726,6227,'庄浪县'),(622727,6227,'静宁县'),(622801,6228,'西峰市'),(622821,6228,'庆阳县'),(622822,6228,'环  县'),(622823,6228,'华池县'),(622824,6228,'合水县'),(622825,6228,'正宁县'),(622826,6228,'宁  县'),(622827,6228,'镇原县'),(622901,6229,'临夏市'),(622921,6229,'临夏县'),(622922,6229,'康乐县'),(622923,6229,'永靖县'),(622924,6229,'广河县'),(622925,6229,'和政县'),(622926,6229,'东乡族自治县'),(622927,6229,'积石山保安族东乡族撒'),(623001,6230,'合作市'),(623021,6230,'临潭县'),(623022,6230,'卓尼县'),(623023,6230,'舟曲县'),(623024,6230,'迭部县'),(623025,6230,'玛曲县'),(623026,6230,'碌曲县'),(623027,6230,'夏河县'),(630101,6301,'市辖区'),(630102,6301,'城东区'),(630103,6301,'城中区'),(630104,6301,'城西区'),(630105,6301,'城北区'),(630121,6301,'大通回族土族自治县'),(630122,6301,'湟中县'),(630123,6301,'湟源县'),(632121,6321,'平安县'),(632122,6321,'民和回族土族自治县'),(632123,6321,'乐都县'),(632126,6321,'互助土族自治县'),(632127,6321,'化隆回族自治县'),(632128,6321,'循化撒拉族自治县'),(632221,6322,'门源回族自治县'),(632222,6322,'祁连县'),(632223,6322,'海晏县'),(632224,6322,'刚察县'),(632321,6323,'同仁县'),(632322,6323,'尖扎县'),(632323,6323,'泽库县'),(632324,6323,'河南蒙古族自治县'),(632521,6325,'共和县'),(632522,6325,'同德县'),(632523,6325,'贵德县'),(632524,6325,'兴海县'),(632525,6325,'贵南县'),(632621,6326,'玛沁县'),(632622,6326,'班玛县'),(632623,6326,'甘德县'),(632624,6326,'达日县'),(632625,6326,'久治县'),(632626,6326,'玛多县'),(632721,6327,'玉树县'),(632722,6327,'杂多县'),(632723,6327,'称多县'),(632724,6327,'治多县'),(632725,6327,'囊谦县'),(632726,6327,'曲麻莱县'),(632801,6328,'格尔木市'),(632802,6328,'德令哈市'),(632821,6328,'乌兰县'),(632822,6328,'都兰县'),(632823,6328,'天峻县'),(640101,6401,'市辖区'),(640102,6401,'城  区'),(640103,6401,'新城区'),(640111,6401,'郊  区'),(640121,6401,'永宁县'),(640122,6401,'贺兰县'),(640201,6402,'市辖区'),(640202,6402,'大武口区'),(640203,6402,'石嘴山区'),(640204,6402,'石炭井区'),(640221,6402,'平罗县'),(640222,6402,'陶乐县'),(640223,6402,'惠农县'),(640301,6403,'市辖区'),(640302,6403,'利通区'),(640321,6403,'中卫县'),(640322,6403,'中宁县'),(640323,6403,'盐池县'),(640324,6403,'同心县'),(640381,6403,'青铜峡市'),(640382,6403,'灵武市'),(642221,6422,'固原县'),(642222,6422,'海原县'),(642223,6422,'西吉县'),(642224,6422,'隆德县'),(642225,6422,'泾源县'),(642226,6422,'彭阳县'),(650101,6501,'市辖区'),(650102,6501,'天山区'),(650103,6501,'沙依巴克区'),(650104,6501,'新市区'),(650105,6501,'水磨沟区'),(650106,6501,'头屯河区'),(650107,6501,'南泉区'),(650108,6501,'东山区'),(650121,6501,'乌鲁木齐县'),(650201,6502,'市辖区'),(650202,6502,'独山子区'),(650203,6502,'克拉玛依区'),(650204,6502,'白碱滩区'),(650205,6502,'乌尔禾区'),(652101,6521,'吐鲁番市'),(652122,6521,'鄯善县'),(652123,6521,'托克逊县'),(652201,6522,'哈密市'),(652222,6522,'巴里坤哈萨克自治县'),(652223,6522,'伊吾县'),(652301,6523,'昌吉市'),(652302,6523,'阜康市'),(652303,6523,'米泉市'),(652323,6523,'呼图壁县'),(652324,6523,'玛纳斯县'),(652325,6523,'奇台县'),(652327,6523,'吉木萨尔县'),(652328,6523,'木垒哈萨克自治县'),(652701,6527,'博乐市'),(652722,6527,'精河县'),(652723,6527,'温泉县'),(652801,6528,'库尔勒市'),(652822,6528,'轮台县'),(652823,6528,'尉犁县'),(652824,6528,'若羌县'),(652825,6528,'且末县'),(652826,6528,'焉耆回族自治县'),(652827,6528,'和静县'),(652828,6528,'和硕县'),(652829,6528,'博湖县'),(652901,6529,'阿克苏市'),(652922,6529,'温宿县'),(652923,6529,'库车县'),(652924,6529,'沙雅县'),(652925,6529,'新和县'),(652926,6529,'拜城县'),(652927,6529,'乌什县'),(652928,6529,'阿瓦提县'),(652929,6529,'柯坪县'),(653001,6530,'阿图什市'),(653022,6530,'阿克陶县'),(653023,6530,'阿合奇县'),(653024,6530,'乌恰县'),(653101,6531,'喀什市'),(653121,6531,'疏附县'),(653122,6531,'疏勒县'),(653123,6531,'英吉沙县'),(653124,6531,'泽普县'),(653125,6531,'莎车县'),(653126,6531,'叶城县'),(653127,6531,'麦盖提县'),(653128,6531,'岳普湖县'),(653129,6531,'伽师县'),(653130,6531,'巴楚县'),(653131,6531,'塔什库尔干塔吉克自治'),(653201,6532,'和田市'),(653221,6532,'和田县'),(653222,6532,'墨玉县'),(653223,6532,'皮山县'),(653224,6532,'洛浦县'),(653225,6532,'策勒县'),(653226,6532,'于田县'),(653227,6532,'民丰县'),(654001,6540,'奎屯市'),(654101,6541,'伊宁市'),(654121,6541,'伊宁县'),(654122,6541,'察布查尔锡伯自治县'),(654123,6541,'霍城县'),(654124,6541,'巩留县'),(654125,6541,'新源县'),(654126,6541,'昭苏县'),(654127,6541,'特克斯县'),(654128,6541,'尼勒克县'),(654201,6542,'塔城市'),(654202,6542,'乌苏市'),(654221,6542,'额敏县'),(654223,6542,'沙湾县'),(654224,6542,'托里县'),(654225,6542,'裕民县'),(654226,6542,'和布克赛尔蒙古自治县'),(654301,6543,'阿勒泰市'),(654321,6543,'布尔津县'),(654322,6543,'富蕴县'),(654323,6543,'福海县'),(654324,6543,'哈巴河县'),(654325,6543,'青河县'),(654326,6543,'吉木乃县'),(659001,6590,'石河子市'),(710101,7101,'请选择'),(710102,7101,'市辖区'),(710103,7101,'台湾省'),(810101,8101,'请选择'),(810102,8101,'市辖区'),(810103,8101,'香港特区'),(910101,9101,'请选择'),(910102,9101,'市辖区'),(910103,9101,'澳门特区');
/*!40000 ALTER TABLE `province_city_district` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `table_file_generation`
--

DROP TABLE IF EXISTS `table_file_generation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `table_file_generation` (
  `pid` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `table_id` bigint(20) DEFAULT NULL COMMENT '表ID',
  `template_id` bigint(20) DEFAULT NULL COMMENT '模板ID',
  `file_name` varchar(100) DEFAULT NULL COMMENT '文件名称',
  `save_path` varchar(100) DEFAULT NULL COMMENT '保存路径',
  PRIMARY KEY (`pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='表文件生成记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `table_file_generation`
--

LOCK TABLES `table_file_generation` WRITE;
/*!40000 ALTER TABLE `table_file_generation` DISABLE KEYS */;
/*!40000 ALTER TABLE `table_file_generation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `table_info`
--

DROP TABLE IF EXISTS `table_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `table_info` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `table_cat` varchar(255) DEFAULT NULL COMMENT 'table catalog (may be null)',
  `table_schem` varchar(255) DEFAULT NULL COMMENT 'table schema (maybe null)',
  `table_name` varchar(255) DEFAULT NULL COMMENT '表名称',
  `table_type` varchar(20) DEFAULT NULL COMMENT '表类型. 常见类型包括"TABLE", "VIEW", "SYSTEM TABLE", "GLOBAL TEMPORARY", "LOCAL TEMPORARY", "ALIAS", "SYNONYM".',
  `remarks` varchar(255) DEFAULT NULL COMMENT '该表的描述文本',
  `type_cat` varchar(255) DEFAULT NULL COMMENT 'the types catalog (maybe null)',
  `type_schem` varchar(255) DEFAULT NULL COMMENT 'the types schema (maybe null)',
  `type_name` varchar(255) DEFAULT NULL COMMENT '类型名称',
  `self_referencing_col_name` varchar(255) DEFAULT NULL COMMENT 'name of the designated "identifier" column of a typed table (may be null)',
  `ref_generation` varchar(255) DEFAULT NULL COMMENT 'specifies how values in SELF_REFERENCING_COL_NAME are created. Values are "SYSTEM", "USER", "DERIVED". (may be null)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='数据库表信息记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `table_info`
--

LOCK TABLES `table_info` WRITE;
/*!40000 ALTER TABLE `table_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `table_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `target_gen_file`
--

DROP TABLE IF EXISTS `target_gen_file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `target_gen_file` (
  `pid` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `task_id` varchar(100) DEFAULT NULL COMMENT '代码生成任务ID',
  `file_name` varchar(100) DEFAULT NULL COMMENT '文件名称',
  `template_id` bigint(20) DEFAULT NULL COMMENT '模板ID',
  `save_path` varchar(100) DEFAULT NULL COMMENT '保存路径',
  `remark` varchar(100) DEFAULT NULL COMMENT '备注信息',
  `builtin` tinyint(1) DEFAULT NULL COMMENT '是否内置',
  PRIMARY KEY (`pid`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COMMENT='模板文件生成关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `target_gen_file`
--

LOCK TABLES `target_gen_file` WRITE;
/*!40000 ALTER TABLE `target_gen_file` DISABLE KEYS */;
INSERT INTO `target_gen_file` VALUES (8,NULL,'Mapper.java',1,NULL,'Mapper文件',1),(9,NULL,'Entity.java',2,NULL,'实体类文件',1),(10,NULL,'Service.java',3,NULL,'Service文件',1),(11,NULL,'ServiceImpl.java',4,NULL,'34343',1),(12,NULL,'VO.java',5,NULL,'12121212',1),(16,NULL,'Controller.java',6,NULL,'wrewerwer',1);
/*!40000 ALTER TABLE `target_gen_file` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `template_info`
--

DROP TABLE IF EXISTS `template_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `template_info` (
  `template_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '模板ID主键',
  `template_name` varchar(100) DEFAULT NULL COMMENT '模板名称',
  `type` tinyint(4) DEFAULT NULL COMMENT '模板类型',
  `provider` varchar(36) DEFAULT NULL COMMENT '技术提供方',
  `content` text COMMENT '字符串模板内容',
  `path` varchar(500) DEFAULT NULL COMMENT '文件模板路径',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注信息',
  `is_deleted` tinyint(4) DEFAULT NULL COMMENT '逻辑删除状态',
  PRIMARY KEY (`template_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COMMENT='模板记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `template_info`
--

LOCK TABLES `template_info` WRITE;
/*!40000 ALTER TABLE `template_info` DISABLE KEYS */;
INSERT INTO `template_info` VALUES (1,'Entity.sql',2,'FreeMarker','<#assign dbTime = \"now()\">\n<#if dbType==\"SQLServer\">\n    <#assign dbTime = \"getDate()\">\n</#if>\n\n-- 初始化菜单\nINSERT INTO sys_menu (pid, name, url, authority, type, open_style, icon, sort, version, deleted, creator, create_time, updater, update_time) VALUES (1, \'${tableComment!}\', \'${moduleName}/${functionName}/index\', NULL, 0, 0, \'icon-menu\', 0, 0, 0, 10000, ${dbTime}, 10000, ${dbTime});\n\nINSERT INTO sys_menu (pid, name, url, authority, type, open_style, icon, sort, version, deleted, creator, create_time, updater, update_time) VALUES ((SELECT max(id) from sys_menu where name = \'${tableComment!}\'), \'查看\', \'\', \'${moduleName}:${functionName}:page\', 1, 0, \'\', 0, 0, 0, 10000, ${dbTime}, 10000, ${dbTime});\nINSERT INTO sys_menu (pid, name, url, authority, type, open_style, icon, sort, version, deleted, creator, create_time, updater, update_time) VALUES ((SELECT max(id) from sys_menu where name = \'${tableComment!}\'), \'新增\', \'\', \'${moduleName}:${functionName}:save\', 1, 0, \'\', 1, 0, 0, 10000, ${dbTime}, 10000, ${dbTime});\nINSERT INTO sys_menu (pid, name, url, authority, type, open_style, icon, sort, version, deleted, creator, create_time, updater, update_time) VALUES ((SELECT max(id) from sys_menu where name = \'${tableComment!}\'), \'修改\', \'\', \'${moduleName}:${functionName}:update,${moduleName}:${functionName}:info\', 1, 0, \'\', 2, 0, 0, 10000, ${dbTime}, 10000, ${dbTime});\nINSERT INTO sys_menu (pid, name, url, authority, type, open_style, icon, sort, version, deleted, creator, create_time, updater, update_time) VALUES ((SELECT max(id) from sys_menu where name = \'${tableComment!}\'), \'删除\', \'\', \'${moduleName}:${functionName}:delete\', 1, 0, \'\', 3, 0, 0, 10000, ${dbTime}, 10000, ${dbTime});\n','','2023-07-11 15:56:30','2023-07-11 15:56:30',NULL,0),(2,'Entity.java.ftl',2,'FreeMarker','package ${package}.${moduleName}.entity;\n\nimport lombok.Data;\nimport lombok.EqualsAndHashCode;\nimport com.baomidou.mybatisplus.annotation.*;\n<#list importList as i>\n    import ${i!};\n</#list>\n<#if baseClass??>\n    import ${baseClass.packageName}.${baseClass.code};\n</#if>\n\n/**\n* ${tableComment}\n*\n* @author ${author} ${email}\n* @since ${version} ${date}\n*/\n<#if baseClass??>@EqualsAndHashCode(callSuper=false)</#if>\n@Data\n@TableName(\"${tableName}\")\npublic class ${ClassName}Entity<#if baseClass??> extends ${baseClass.code}</#if> {\n<#list fieldList as field>\n    <#if !field.baseField>\n        <#if field.fieldComment!?length gt 0>\n            /**\n            * ${field.fieldComment}\n            */\n        </#if>\n        <#if field.autoFill == \"INSERT\">\n            @TableField(fill = FieldFill.INSERT)\n        </#if>\n        <#if field.autoFill == \"INSERT_UPDATE\">\n            @TableField(fill = FieldFill.INSERT_UPDATE)\n        </#if>\n        <#if field.autoFill == \"UPDATE\">\n            @TableField(fill = FieldFill.UPDATE)\n        </#if>\n        <#if field.primaryKey>\n            @TableId\n        </#if>\n        private ${field.attrType} ${field.attrName};\n    </#if>\n\n</#list>\n}\n','','2023-07-20 17:48:43','2023-07-20 17:48:43',NULL,0),(3,'Service.java.ftl',2,'FreeMarker','package ${package}.${moduleName}.service;\n\nimport ${package}.framework.common.utils.PageResult;\nimport ${package}.framework.mybatis.service.BaseService;\nimport ${package}.${moduleName}.vo.${ClassName}VO;\nimport ${package}.${moduleName}.query.${ClassName}Query;\nimport ${package}.${moduleName}.entity.${ClassName}Entity;\n\nimport java.util.List;\n\n/**\n* ${tableComment}\n*\n* @author ${author} ${email}\n* @since ${version} ${date}\n*/\npublic interface ${ClassName}Service extends BaseService\n<${ClassName}Entity> {\n\n    PageResult\n    <${ClassName}VO> page(${ClassName}Query query);\n\n        void save(${ClassName}VO vo);\n\n        void update(${ClassName}VO vo);\n\n        void delete(List\n        <Long> idList);\n            }\n','','2023-07-20 17:52:30','2023-07-20 17:52:30',NULL,0),(4,'ServiceImpl.java.ftl',2,'Velocity','package ${package}.${moduleName}.service;\n\nimport ${package}.framework.common.utils.PageResult;\nimport ${package}.framework.mybatis.service.BaseService;\nimport ${package}.${moduleName}.vo.${ClassName}VO;\nimport ${package}.${moduleName}.query.${ClassName}Query;\nimport ${package}.${moduleName}.entity.${ClassName}Entity;\n\nimport java.util.List;\n\n/**\n* ${tableComment}\n*\n* @author ${author} ${email}\n* @since ${version} ${date}\n*/\npublic interface ${ClassName}Service extends BaseService\n<${ClassName}Entity> {\n\n    PageResult\n    <${ClassName}VO> page(${ClassName}Query query);\n\n        void save(${ClassName}VO vo);\n\n        void update(${ClassName}VO vo);\n\n        void delete(List\n        <Long> idList);\n            }\n','','2023-07-20 17:52:51','2023-07-20 17:52:51',NULL,0),(5,'VO.java.ftl',2,'Velocity','package ${package}.${moduleName}.vo;\n\nimport io.swagger.v3.oas.annotations.media.Schema;\nimport com.fasterxml.jackson.annotation.JsonFormat;\nimport lombok.Data;\nimport java.io.Serializable;\nimport ${package}.framework.common.utils.DateUtils;\n<#list importList as i>\n    import ${i!};\n</#list>\n\n/**\n* ${tableComment}\n*\n* @author ${author} ${email}\n* @since ${version} ${date}\n*/\n@Data\n@Schema(description = \"${tableComment}\")\npublic class ${ClassName}VO implements Serializable {\nprivate static final long serialVersionUID = 1L;\n\n<#list fieldList as field>\n    <#if field.fieldComment!?length gt 0>\n        @Schema(description = \"${field.fieldComment}\")\n    </#if>\n    <#if field.attrType == \'Date\'>\n        @JsonFormat(pattern = DateUtils.DATE_TIME_PATTERN)\n    </#if>\n    private ${field.attrType} ${field.attrName};\n\n</#list>\n\n}\n','','2023-07-20 17:53:55','2023-07-20 17:53:55',NULL,0),(6,'Controller.java.ftl',2,'FreeMarker','package ${package}.${moduleName}.controller;\n\nimport io.swagger.v3.oas.annotations.Operation;\nimport io.swagger.v3.oas.annotations.tags.Tag;\nimport lombok.AllArgsConstructor;\nimport ${package}.framework.common.utils.PageResult;\nimport ${package}.framework.common.utils.Result;\nimport ${package}.${moduleName}.convert.${ClassName}Convert;\nimport ${package}.${moduleName}.entity.${ClassName}Entity;\nimport ${package}.${moduleName}.service.${ClassName}Service;\nimport ${package}.${moduleName}.query.${ClassName}Query;\nimport ${package}.${moduleName}.vo.${ClassName}VO;\nimport org.springdoc.core.annotations.ParameterObject;\nimport org.springframework.security.access.prepost.PreAuthorize;\nimport org.springframework.web.bind.annotation.*;\n\nimport jakarta.validation.Valid;\nimport java.util.List;\n\n/**\n* ${tableComment}\n*\n* @author ${author} ${email}\n* @since ${version} ${date}\n*/\n@RestController\n@RequestMapping(\"${moduleName}/${functionName}\")\n@Tag(name=\"${tableComment}\")\n@AllArgsConstructor\npublic class ${ClassName}Controller {\nprivate final ${ClassName}Service ${className}Service;\n\n@GetMapping(\"page\")\n@Operation(summary = \"分页\")\n@PreAuthorize(\"hasAuthority(\'${moduleName}:${functionName}:page\')\")\npublic Result\n<PageResult\n<${ClassName}VO>> page(@ParameterObject @Valid ${ClassName}Query query){\n    PageResult\n    <${ClassName}VO> page = ${className}Service.page(query);\n\n        return Result.ok(page);\n        }\n\n        @GetMapping(\"{id}\")\n        @Operation(summary = \"信息\")\n        @PreAuthorize(\"hasAuthority(\'${moduleName}:${functionName}:info\')\")\n        public Result\n        <${ClassName}VO> get(@PathVariable(\"id\") Long id){\n            ${ClassName}Entity entity = ${className}Service.getById(id);\n\n            return Result.ok(${ClassName}Convert.INSTANCE.convert(entity));\n            }\n\n            @PostMapping\n            @Operation(summary = \"保存\")\n            @PreAuthorize(\"hasAuthority(\'${moduleName}:${functionName}:save\')\")\n            public Result\n            <String> save(@RequestBody ${ClassName}VO vo){\n                ${className}Service.save(vo);\n\n                return Result.ok();\n                }\n\n                @PutMapping\n                @Operation(summary = \"修改\")\n                @PreAuthorize(\"hasAuthority(\'${moduleName}:${functionName}:update\')\")\n                public Result\n                <String> update(@RequestBody @Valid ${ClassName}VO vo){\n                    ${className}Service.update(vo);\n\n                    return Result.ok();\n                    }\n\n                    @DeleteMapping\n                    @Operation(summary = \"删除\")\n                    @PreAuthorize(\"hasAuthority(\'${moduleName}:${functionName}:delete\')\")\n                    public Result\n                    <String> delete(@RequestBody List\n                        <Long> idList){\n                            ${className}Service.delete(idList);\n\n                            return Result.ok();\n                            }\n                            }\n','','2023-07-20 17:54:53','2023-07-20 17:54:53',NULL,0),(8,'VO.java.ftl',1,'Velocity','','template\\VO.java.ftl','2023-08-05 19:52:29','2023-08-05 19:52:29',NULL,0),(9,'menu.sql.ftl',1,'FreeMarker','','template\\menu.sql.ftl','2023-08-05 20:03:44','2023-08-05 20:03:44',NULL,0),(10,'add-or-update.vue.ftl',1,'FreeMarker','','template\\add-or-update.vue.ftl','2023-08-05 20:04:34','2023-08-05 20:04:34',NULL,0),(11,'api.ts.ftl',1,'FreeMarker','2323','template\\api.ts.ftl','2023-08-05 20:04:43','2023-08-05 20:04:43',NULL,0),(12,'api.ts.ftl',1,'Velocity','','template\\api.ts.ftl','2023-08-05 20:05:04','2023-08-05 20:05:04',NULL,0),(13,'index.vue.ftl',1,'FreeMarker','','template\\index.vue.ftl','2023-08-05 20:05:22','2023-08-05 20:05:22',NULL,0),(14,'1.txt',1,'Velocity','姜慧忻				1001001\r\n司马茂宇				1001002\r\n慕容薇薇				1001003\r\n彭彤					1001004\r\n高芳					1001005\r\n彭乐玮				1001006\r\n林欣茹				1001007\r\n余景轩				1001008\r\n高梅薇				1001009\r\n潘言					1001010\r\n林雅					1002001\r\n孙成					1002002\r\n马梦雪				1002003\r\n慕容麦景				1002004\r\n程欣					1002005\r\n吴磊					1002006\r\n唐羽薇				1002007\r\n宋程					1002008\r\n邓颖欣				1002009\r\n梁翰					1002010\r\n赵安羽				1003001\r\n王宇					1003002\r\n於雅灵				1003003\r\n於程					1003004\r\n百里佳				1003005\r\n范景					1003006\r\n唐艺纾				1003007\r\n田峰飞				1003008\r\n韩桑晴				1003009\r\n姜柏					1003010\r\n曹妍娅				1004001\r\n钟家达				1004002\r\n蒋羽宸				1004003\r\n宋达思				1004004\r\n吕佳					1004005\r\n袁远					1004006\r\n宋彤					1004007\r\n梁恒天				1004008\r\n卢茹					1004009\r\n韩宇					2001002\r\n','','2023-08-24 17:08:56','2023-08-24 17:08:56',NULL,0),(15,'1.txt',1,'Velocity','姜慧忻				1001001\r\n司马茂宇				1001002\r\n慕容薇薇				1001003\r\n彭彤					1001004\r\n高芳					1001005\r\n彭乐玮				1001006\r\n林欣茹				1001007\r\n余景轩				1001008\r\n高梅薇				1001009\r\n潘言					1001010\r\n林雅					1002001\r\n孙成					1002002\r\n马梦雪				1002003\r\n慕容麦景				1002004\r\n程欣					1002005\r\n吴磊					1002006\r\n唐羽薇				1002007\r\n宋程					1002008\r\n邓颖欣				1002009\r\n梁翰					1002010\r\n赵安羽				1003001\r\n王宇					1003002\r\n於雅灵				1003003\r\n於程					1003004\r\n百里佳				1003005\r\n范景					1003006\r\n唐艺纾				1003007\r\n田峰飞				1003008\r\n韩桑晴				1003009\r\n姜柏					1003010\r\n曹妍娅				1004001\r\n钟家达				1004002\r\n蒋羽宸				1004003\r\n宋达思				1004004\r\n吕佳					1004005\r\n袁远					1004006\r\n宋彤					1004007\r\n梁恒天				1004008\r\n卢茹					1004009\r\n韩宇					2001002\r\n','','2023-08-24 19:12:33','2023-08-24 19:12:33',NULL,0);
/*!40000 ALTER TABLE `template_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `template_param`
--

DROP TABLE IF EXISTS `template_param`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `template_param` (
  `id` int(11) NOT NULL COMMENT '主键ID',
  `template_id` int(11) DEFAULT NULL COMMENT '模板ID',
  `param_key` varchar(100) DEFAULT NULL COMMENT '参数key, 一般为出现在模板中的变量名,单个模板内唯一',
  `param_name` varchar(100) DEFAULT NULL COMMENT '参数名',
  `param_value` varchar(100) DEFAULT NULL COMMENT '参数值,默认参数值, 未提供该参数时使用此值',
  `data_type` varchar(100) DEFAULT NULL COMMENT '数据类型, 统一所有的数据类型',
  `remark` varchar(100) DEFAULT NULL COMMENT '备注信息',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='模板参数元数据表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `template_param`
--

LOCK TABLES `template_param` WRITE;
/*!40000 ALTER TABLE `template_param` DISABLE KEYS */;
/*!40000 ALTER TABLE `template_param` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `test`
--

DROP TABLE IF EXISTS `test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `test` (
  `col_bigint` bigint(255) DEFAULT NULL,
  `col_decimal` decimal(5,2) DEFAULT NULL,
  `col_timestamp` datetime(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `test`
--

LOCK TABLES `test` WRITE;
/*!40000 ALTER TABLE `test` DISABLE KEYS */;
/*!40000 ALTER TABLE `test` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `type_mapping`
--

DROP TABLE IF EXISTS `type_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `type_mapping` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `java_type` varchar(255) DEFAULT NULL,
  `json_type` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `type_mapping`
--

LOCK TABLES `type_mapping` WRITE;
/*!40000 ALTER TABLE `type_mapping` DISABLE KEYS */;
/*!40000 ALTER TABLE `type_mapping` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-10-22 17:19:31
