package io.devpl.codegen.config;

import io.devpl.codegen.util.StringUtils;
import io.devpl.codegen.util.Utils;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

import java.util.*;

/**
 * 策略配置项
 */
public class StrategyConfig extends ConfigurationHolder {

    /**
     * 过滤表前缀
     * example: addTablePrefix("t_")
     * result: t_simple -> Simple
     */
    private final Set<String> tablePrefix = new HashSet<>();
    /**
     * 过滤表后缀
     * example: addTableSuffix("_0")
     * result: t_simple_0 -> Simple
     */
    private final Set<String> tableSuffix = new HashSet<>();
    /**
     * 过滤字段前缀
     * example: addFieldPrefix("is_")
     * result: is_deleted -> deleted
     */
    private final Set<String> fieldPrefix = new HashSet<>();
    /**
     * 过滤字段后缀
     * example: addFieldSuffix("_flag")
     * result: deleted_flag -> deleted
     */
    private final Set<String> fieldSuffix = new HashSet<>();
    /**
     * 需要包含的表名，允许正则表达式（与exclude二选一配置）<br/>
     * 当{@link #enableSqlFilter}为true时，正则表达式无效.
     */
    private final Set<String> include = new HashSet<>();
    /**
     * 需要排除的表名，允许正则表达式<br/>
     * 当{@link #enableSqlFilter}为true时，正则表达式无效.
     */
    private final Set<String> exclude = new HashSet<>();
    private final EntityTemplateArugments.Builder entityBuilder = new EntityTemplateArugments.Builder(this);
    private final ControllerTempateArguments.Builder controllerBuilder = new ControllerTempateArguments.Builder(this);
    private final Mapper.Builder mapperBuilder = new Mapper.Builder(this);
    private final Service.Builder serviceBuilder = new Service.Builder(this);
    /**
     * 是否大写命名（默认 false）
     */
    private boolean isCapitalMode;
    /**
     * 是否跳过视图（默认 false）
     */
    private boolean skipView;
    /**
     * 启用sql过滤，语法不能支持使用sql过滤表的话，可以考虑关闭此开关.
     *
     * @since 3.3.1
     */
    private boolean enableSqlFilter = true;
    /**
     * 启用 schema 默认 false
     */
    private boolean enableSchema;
    /**
     * 包含表名
     *
     * @since 3.3.0
     */
    private LikeTable likeTable;
    /**
     * 不包含表名
     *
     * @since 3.3.0
     */
    private LikeTable notLikeTable;
    private EntityTemplateArugments entity;
    private ControllerTempateArguments controller;
    private Mapper mapper;
    private Service service;

    private StrategyConfig() {
    }

    public static StrategyConfig.Builder builder() {
        return new Builder();
    }

    /**
     * 实体配置构建者
     *
     * @return 实体配置构建者
     * @since 3.5.0
     */
    @NotNull
    public EntityTemplateArugments.Builder entityBuilder() {
        return entityBuilder;
    }

    /**
     * 实体配置
     *
     * @return 实体配置
     * @since 3.5.0
     */
    @NotNull
    public EntityTemplateArugments entity() {
        if (entity == null) {
            this.entity = entityBuilder.get();
        }
        return entity;
    }

    /**
     * 控制器配置构建者
     *
     * @return 控制器配置构建者
     * @since 3.5.0
     */
    @NotNull
    public ControllerTempateArguments.Builder controllerBuilder() {
        return controllerBuilder;
    }

    /**
     * 控制器配置
     *
     * @return 控制器配置
     * @since 3.5.0
     */
    @NotNull
    public ControllerTempateArguments controller() {
        if (controller == null) {
            this.controller = controllerBuilder.get();
        }
        return controller;
    }

    /**
     * Mapper配置构建者
     *
     * @return Mapper配置构建者
     * @since 3.5.0
     */
    @NotNull
    public Mapper.Builder mapperBuilder() {
        return mapperBuilder;
    }

    /**
     * Mapper配置
     *
     * @return Mapper配置
     * @since 3.5.0
     */
    @NotNull
    public Mapper mapper() {
        if (mapper == null) {
            this.mapper = mapperBuilder.get();
        }
        return mapper;
    }

    /**
     * Service配置构建者
     *
     * @return Service配置构建者
     * @since 3.5.0
     */
    @NotNull
    public Service.Builder serviceBuilder() {
        return serviceBuilder;
    }

    /**
     * Service配置
     *
     * @return Service配置
     * @since 3.5.0
     */
    @NotNull
    public Service service() {
        if (service == null) {
            this.service = serviceBuilder.get();
        }
        return service;
    }

    /**
     * 表名称匹配过滤表前缀
     *
     * @param tableName 表名称
     * @since 3.3.2
     */
    public boolean startsWithTablePrefix(@NotNull String tableName) {
        return this.tablePrefix.stream().anyMatch(tableName::startsWith);
    }

    /**
     * 验证配置项
     *
     * @since 3.5.0
     */
    public void validate() {
        boolean isInclude = !this.getInclude().isEmpty();
        boolean isExclude = !this.getExclude().isEmpty();
        if (isInclude && isExclude) {
            throw new IllegalArgumentException("<strategy> 标签中 <include> 与 <exclude> 只能配置一项！");
        }
        if (this.getNotLikeTable() != null && this.getLikeTable() != null) {
            throw new IllegalArgumentException("<strategy> 标签中 <likeTable> 与 <notLikeTable> 只能配置一项！");
        }
    }

    /**
     * 表名匹配
     *
     * @param tableName   表名
     * @param matchTables 匹配集合
     * @return 是否匹配
     * @since 3.5.0
     */
    public boolean matchTable(String tableName, Set<String> matchTables) {
        return matchTables.stream().anyMatch(t -> tableNameMatches(t, tableName));
    }

    /**
     * 表名匹配
     *
     * @param matchTableName 匹配表名
     * @param dbTableName    数据库表名
     * @return 是否匹配
     */
    private boolean tableNameMatches(@NotNull String matchTableName, @NotNull String dbTableName) {
        return matchTableName.equalsIgnoreCase(dbTableName) || StringUtils.matches(matchTableName, dbTableName);
    }

    public boolean isCapitalMode() {
        return isCapitalMode;
    }

    public boolean isSkipView() {
        return skipView;
    }

    @NotNull
    public Set<String> getTablePrefix() {
        return tablePrefix;
    }

    @NotNull
    public Set<String> getTableSuffix() {
        return tableSuffix;
    }

    @NotNull
    public Set<String> getFieldPrefix() {
        return fieldPrefix;
    }

    @NotNull
    public Set<String> getFieldSuffix() {
        return fieldSuffix;
    }

    @NotNull
    public Set<String> getInclude() {
        return include;
    }

    @NotNull
    public Set<String> getExclude() {
        return exclude;
    }

    public boolean isEnableSqlFilter() {
        return enableSqlFilter;
    }

    public boolean isEnableSchema() {
        return enableSchema;
    }

    @Nullable
    public LikeTable getLikeTable() {
        return likeTable;
    }

    @Nullable
    public LikeTable getNotLikeTable() {
        return notLikeTable;
    }

    public void addIncludedTables(String... tableNames) {
        this.include.addAll(Arrays.asList(tableNames));
    }

    public void addIncludedTables(Collection<String> tableNames) {
        this.include.addAll(tableNames);
    }

    /**
     * 策略配置构建者
     *
     * @author nieqiurong 2020/10/11.
     * @since 3.5.0
     */
    public static class Builder extends BaseBuilder {

        private final StrategyConfig strategyConfig;

        public Builder() {
            super(new StrategyConfig());
            strategyConfig = super.build();
        }

        /**
         * 开启大写命名
         *
         * @return this
         * @since 3.5.0
         */
        public Builder enableCapitalMode() {
            this.strategyConfig.isCapitalMode = true;
            return this;
        }

        /**
         * 开启跳过视图
         *
         * @return this
         * @since 3.5.0
         */
        public Builder enableSkipView() {
            this.strategyConfig.skipView = true;
            return this;
        }

        /**
         * 禁用sql过滤
         *
         * @return this
         * @since 3.5.0
         */
        public Builder disableSqlFilter() {
            this.strategyConfig.enableSqlFilter = false;
            return this;
        }

        /**
         * 启用 schema
         *
         * @return this
         * @since 3.5.1
         */
        public Builder enableSchema() {
            this.strategyConfig.enableSchema = true;
            return this;
        }

        /**
         * 增加过滤表前缀
         *
         * @param tablePrefix 过滤表前缀
         * @return this
         * @since 3.5.0
         */
        public Builder addTablePrefix(@NotNull String... tablePrefix) {
            return addTablePrefix(Arrays.asList(tablePrefix));
        }

        public Builder addTablePrefix(@NotNull List<String> tablePrefixList) {
            this.strategyConfig.tablePrefix.addAll(tablePrefixList);
            return this;
        }

        /**
         * 增加过滤表后缀
         *
         * @param tableSuffix 过滤表后缀
         * @return this
         * @since 3.5.1
         */
        public Builder addTableSuffix(String... tableSuffix) {
            return addTableSuffix(Arrays.asList(tableSuffix));
        }

        public Builder addTableSuffix(@NotNull List<String> tableSuffixList) {
            this.strategyConfig.tableSuffix.addAll(tableSuffixList);
            return this;
        }

        /**
         * 增加过滤字段前缀
         *
         * @param fieldPrefix 过滤字段前缀
         * @return this
         * @since 3.5.0
         */
        public Builder addFieldPrefix(@NotNull String... fieldPrefix) {
            return addFieldPrefix(Arrays.asList(fieldPrefix));
        }

        public Builder addFieldPrefix(@NotNull List<String> fieldPrefix) {
            this.strategyConfig.fieldPrefix.addAll(fieldPrefix);
            return this;
        }

        /**
         * 增加过滤字段后缀
         *
         * @param fieldSuffix 过滤字段后缀
         * @return this
         * @since 3.5.1
         */
        public Builder addFieldSuffix(@NotNull String... fieldSuffix) {
            return addFieldSuffix(Arrays.asList(fieldSuffix));
        }

        public Builder addFieldSuffix(@NotNull List<String> fieldSuffixList) {
            this.strategyConfig.fieldSuffix.addAll(fieldSuffixList);
            return this;
        }

        /**
         * 增加包含的表名
         *
         * @param include 包含表
         * @return this
         */
        public Builder addInclude(@NotNull String... include) {
            addInclude(Arrays.asList(include));
            return this;
        }

        /**
         * 增加包含的表名
         *
         * @param includes 包含表
         * @return this
         */
        public Builder addInclude(List<String> includes) {
            Utils.notEmpty(includes, "表名为空");
            this.strategyConfig.addIncludedTables(includes);
            return this;
        }

        /**
         * 增加包含的表名
         *
         * @param includes 包含表
         * @return this
         */
        public Builder addInclude(String includes) {
            Utils.notBlank(includes, "表名[%s]为空", includes);
            if (includes.contains(",")) {
                this.strategyConfig.addIncludedTables(includes.split(","));
            } else {
                this.strategyConfig.addIncludedTables(includes);
            }
            return this;
        }

        /**
         * 增加排除表
         *
         * @param exclude 排除表
         * @return this
         * @since 3.5.0
         */
        public Builder addExclude(@NotNull String... exclude) {
            return addExclude(Arrays.asList(exclude));
        }

        public Builder addExclude(@NotNull List<String> excludeList) {
            this.strategyConfig.exclude.addAll(excludeList);
            return this;
        }

        /**
         * 包含表名
         *
         * @return this
         */
        public Builder likeTable(@NotNull LikeTable likeTable) {
            this.strategyConfig.likeTable = likeTable;
            return this;
        }

        /**
         * 不包含表名
         *
         * @return this
         */
        public Builder notLikeTable(@NotNull LikeTable notLikeTable) {
            this.strategyConfig.notLikeTable = notLikeTable;
            return this;
        }

        @Override
        @NotNull
        public StrategyConfig build() {
            this.strategyConfig.validate();
            return strategyConfig;
        }
    }
}
