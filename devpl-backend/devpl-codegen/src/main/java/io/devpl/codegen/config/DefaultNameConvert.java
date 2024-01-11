package io.devpl.codegen.config;

import io.devpl.codegen.core.TableGeneration;
import io.devpl.sdk.util.StringUtils;

import java.util.Set;

/**
 * 默认名称转换接口类
 *
 * @author nieqiurong 2020/9/20.
 * @since 3.5.0
 */
public class DefaultNameConvert implements NameConverter {

    private final StrategyConfig strategyConfig;

    public DefaultNameConvert(StrategyConfig strategyConfig) {
        this.strategyConfig = strategyConfig;
    }

    @Override
    public String entityNameConvert(TableGeneration tableInfo) {
        return NamingStrategy.capitalFirst(processName(tableInfo.getName(), strategyConfig.entity()
            .getNamingStrategy(), strategyConfig.getTablePrefix(), strategyConfig.getTableSuffix()));
    }

    @Override
    public String propertyNameConvert(String propertyName) {
        return processName(propertyName, strategyConfig.entity()
            .getColumnNamingStrategy(), strategyConfig.getFieldPrefix(), strategyConfig.getFieldSuffix());
    }

    private String processName(String name, NamingStrategy strategy, Set<String> prefix, Set<String> suffix) {
        String propertyName = name;
        // 删除前缀
        if (!prefix.isEmpty()) {
            propertyName = NamingStrategy.removePrefix(propertyName, prefix);
        }
        // 删除后缀
        if (!suffix.isEmpty()) {
            propertyName = NamingStrategy.removeSuffix(propertyName, suffix);
        }
        if (!StringUtils.hasText(propertyName)) {
            throw new RuntimeException(String.format("%s 的名称转换结果为空，请检查是否配置问题", name));
        }
        // 下划线转驼峰
        if (NamingStrategy.UNDERLINE_TO_CAMEL.equals(strategy)) {
            return NamingStrategy.underlineToCamel(propertyName);
        }
        return propertyName;
    }
}
