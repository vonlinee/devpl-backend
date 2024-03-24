package io.devpl.codegen.db.query;

import io.devpl.codegen.config.DataSourceConfig;
import io.devpl.codegen.config.StrategyConfig;
import io.devpl.codegen.config.TypeConverter;
import io.devpl.codegen.core.ColumnGeneration;
import io.devpl.codegen.core.ContextImpl;
import io.devpl.codegen.core.TableGeneration;
import io.devpl.codegen.db.ColumnJavaType;
import io.devpl.codegen.db.DBType;
import io.devpl.codegen.db.converts.MySqlTypeConverter;
import io.devpl.codegen.db.converts.TypeConverts;
import io.devpl.codegen.db.querys.DbQueryDecorator;
import io.devpl.codegen.db.querys.H2Query;
import io.devpl.codegen.jdbc.JdbcUtils;
import io.devpl.codegen.jdbc.meta.ColumnMetadata;
import io.devpl.codegen.jdbc.meta.TableMetadata;
import io.devpl.codegen.template.model.EntityTemplateArguments;
import io.devpl.sdk.util.StringUtils;
import org.jetbrains.annotations.NotNull;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.sql.SQLException;
import java.util.*;
import java.util.stream.Collectors;

/**
 * 使用SQL查询的尝试来获取元数据信息
 */
public class SQLBasedMetadataLoader extends AbstractDatabaseIntrospector {

    static final Logger log = LoggerFactory.getLogger(SQLBasedMetadataLoader.class);

    protected final DbQueryDecorator dbQuery;

    public SQLBasedMetadataLoader(@NotNull ContextImpl context) {
        setContext(context);
        this.dbQuery = new DbQueryDecorator(context.getDataSourceConfig(), context.getStrategyConfig());
    }

    @NotNull
    public List<TableGeneration> queryTables() {
        StrategyConfig strategyConfig = context.getStrategyConfig();
        final Set<String> excludeTables = strategyConfig.getExclude();
        final Set<String> includeTables = strategyConfig.getInclude();
        boolean isInclude = !excludeTables.isEmpty();
        boolean isExclude = !includeTables.isEmpty();
        // 所有的表信息
        List<TableGeneration> tableList = new ArrayList<>();

        // 需要反向生成或排除的表信息
        List<TableGeneration> includeTableList = new ArrayList<>();
        List<TableGeneration> excludeTableList = new ArrayList<>();
        try {
            dbQuery.execute(dbQuery.tablesSql(), result -> {
                String tableName = result.getStringResult(dbQuery.tableName());
                if (StringUtils.hasText(tableName)) {
                    TableGeneration tableInfo = new TableGeneration(new TableMetadata());
                    String tableComment = result.getTableComment();
                    // 跳过视图
                    if (!(strategyConfig.isSkipView() && tableComment.toUpperCase().contains("VIEW"))) {
                        tableInfo.setComment(tableComment);
                        if (isInclude && strategyConfig.matchTable(tableName, includeTables)) {
                            includeTableList.add(tableInfo);
                        } else if (isExclude && strategyConfig.matchTable(tableName, excludeTables)) {
                            excludeTableList.add(tableInfo);
                        }
                        tableList.add(tableInfo);
                    }
                }
            });
            final Set<String> exclude = strategyConfig.getExclude();
            final Set<String> include = strategyConfig.getInclude();
            filter(tableList, includeTableList, excludeTableList);
            // 性能优化，只处理需执行表字段 https://github.com/baomidou/mybatis-plus/issues/219
            tableList.forEach(this::convertTableFields);
            return tableList;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            // 数据库操作完成,释放连接对象
            dbQuery.closeConnection();
        }
    }

    protected void filter(List<TableGeneration> tableList, List<TableGeneration> includeTableList, List<TableGeneration> excludeTableList) {
        StrategyConfig strategyConfig = context.getStrategyConfig();
        boolean isInclude = !strategyConfig.getInclude().isEmpty();
        boolean isExclude = !strategyConfig.getExclude().isEmpty();
        if (isExclude || isInclude) {
            Map<String, String> notExistTables = new HashSet<>(isExclude ? strategyConfig.getExclude() : strategyConfig.getInclude())
                .stream()
                .filter(s -> !JdbcUtils.matcherRegTable(s))
                .collect(Collectors.toMap(String::toLowerCase, s -> s, (o, n) -> n));
            // 将已经存在的表移除，获取配置中数据库不存在的表
            for (TableGeneration tabInfo : tableList) {
                if (notExistTables.isEmpty()) {
                    break;
                }
                // 解决可能大小写不敏感的情况导致无法移除掉
                notExistTables.remove(tabInfo.getName().toLowerCase());
            }
            if (!notExistTables.isEmpty()) {
                log.warn("表[{}]在数据库中不存在！！！", String.join(",", notExistTables.values()));
            }
            // 需要反向生成的表信息
            if (isExclude) {
                tableList.removeAll(excludeTableList);
            } else {
                tableList.clear();
                tableList.addAll(includeTableList);
            }
        }
    }

    protected void convertTableFields(@NotNull TableGeneration tableInfo) {

        StrategyConfig strategyConfig = context.getStrategyConfig();
        DataSourceConfig dataSourceConfig = context.getDataSourceConfig();

        DBType dbType = dataSourceConfig.getDbType();
        String tableName = tableInfo.getName();
        try {
            // TODO 重构
            // Map<String, Column> columnsInfoMap = getColumnsInfo(tableName, false);
            Map<String, ColumnMetadata> columnsInfoMap = new HashMap<>();
            String tableFieldsSql = dbQuery.tableFieldsSql(tableName);
            Set<String> h2PkColumns = new HashSet<>();
            if (DBType.H2 == dbType) {
                dbQuery.execute(String.format(H2Query.PK_QUERY_SQL, tableName), result -> {
                    String primaryKey = result.getStringResult(dbQuery.fieldKey());
                    if (Boolean.parseBoolean(primaryKey)) {
                        h2PkColumns.add(result.getStringResult(dbQuery.fieldName()));
                    }
                });
            }
            EntityTemplateArguments entity = strategyConfig.entity();
            dbQuery.execute(tableFieldsSql, result -> {
                String columnName = result.getStringResult(dbQuery.fieldName());
                // TODO 修改
                ColumnGeneration field = new ColumnGeneration(null, null);
                ColumnMetadata columnInfo = columnsInfoMap.get(columnName.toLowerCase());
                // 设置字段的元数据信息
                // TODO 测试
                // 避免多重主键设置，目前只取第一个找到ID，并放到list中的索引为0的位置
                boolean isId = DBType.H2 == dbType ? h2PkColumns.contains(columnName) : result.isPrimaryKey();
                // 处理ID
                if (isId) {
                    field.setPrimaryKeyFlag(dbQuery.isKeyIdentity(result.getResultSet()));
                    if (field.isKeyIdentityFlag() && entity.getIdType() != null) {
                        log.warn("当前表[{}]的主键为自增主键，会导致全局主键的ID类型设置失效!", tableName);
                    }
                }
                // 处理ID
                field.setColumnName(columnName)
                    .setType(result.getStringResult(dbQuery.fieldType()))
                    .setComment(result.getFiledComment())
                    .setCustomMap(dbQuery.getCustomFields(result.getResultSet()));
                String propertyName = entity.getNameConvert().propertyNameConvert(field.getName());

                TypeConverter typeConvert = dataSourceConfig.getTypeConvert();
                if (typeConvert == null) {
                    DBType dbType1 = JdbcUtils.getDbType(dataSourceConfig.getUrl());
                    // 默认 MYSQL
                    typeConvert = TypeConverts.getTypeConvert(dbType1);
                    if (null == typeConvert) {
                        typeConvert = MySqlTypeConverter.INSTANCE;
                    }
                }

                ColumnJavaType columnType = typeConvert.processTypeConvert(context.getGlobalConfig(), field.getColumnName());
                field.setPropertyName(propertyName);
                field.setColumnType(columnType);
                tableInfo.addColumn(field);
            });
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public List<TableGeneration> getTables(String catalog, String schemaPattern, String tableNamePattern, String[] tableTypes) {
        return null;
    }

    @Override
    public List<ColumnGeneration> getColumns(String catalog, String schemaPattern, String tableNamePattern, String columnNamePattern) {
        return null;
    }
}
