package io.devpl.codegen.config;

import io.devpl.codegen.core.TableGeneration;
import org.jetbrains.annotations.NotNull;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.function.BiConsumer;
import java.util.function.Consumer;
import java.util.stream.Collectors;

/**
 * 注入配置
 */
public class InjectionConfig {

    private final static Logger LOGGER = LoggerFactory.getLogger(InjectionConfig.class);

    /**
     * 输出文件之前消费者
     */
    private BiConsumer<TableGeneration, Map<String, Object>> beforeOutputFileBiConsumer;

    /**
     * 自定义配置 Map 对象
     */
    private Map<String, Object> customMap = new HashMap<>();

    /**
     * 自定义模板文件，key为文件名称，value为模板路径（已弃用，换成了customFiles，3.5.4版本会删除此方法）
     */
    @Deprecated
    private final Map<String, String> customFile = new HashMap<>();

    /**
     * 自定义模板文件列表
     *
     * @since 3.5.3
     */
    private final List<CustomFile> customFiles = new ArrayList<>();

    /**
     * 是否覆盖已有文件（默认 false）（已弃用，已放到自定义文件类CustomFile中，3.5.4版本会删除此方法）
     *
     * @since 3.5.2
     */
    @Deprecated
    private boolean fileOverride;

    /**
     * 输出文件前
     */
    public void beforeOutputFile(TableGeneration tableInfo, Map<String, Object> objectMap) {
        if (!customMap.isEmpty()) {
            objectMap.putAll(customMap);
        }
        if (null != beforeOutputFileBiConsumer) {
            beforeOutputFileBiConsumer.accept(tableInfo, objectMap);
        }
    }

    /**
     * 获取自定义配置 Map 对象
     */
    @NotNull
    public Map<String, Object> getCustomMap() {
        return customMap;
    }

    /**
     * 获取自定义模板文件列表
     */
    @NotNull
    public List<CustomFile> getCustomFiles() {
        return customFiles;
    }

    /**
     * 已弃用，已放到自定义文件类CustomFile中，3.5.4版本会删除此方法
     */
    @Deprecated
    public boolean isFileOverride() {
        return fileOverride;
    }

    public static InjectionConfig.Builder builder() {
        return new InjectionConfig.Builder();
    }

    /**
     * 构建者
     */
    public static class Builder {

        private final InjectionConfig injectionConfig;

        public Builder() {
            this.injectionConfig = new InjectionConfig();
        }

        /**
         * 输出文件之前消费者
         *
         * @param biConsumer 消费者
         * @return this
         */
        public Builder beforeOutputFile(@NotNull BiConsumer<TableGeneration, Map<String, Object>> biConsumer) {
            this.injectionConfig.beforeOutputFileBiConsumer = biConsumer;
            return this;
        }

        /**
         * 自定义配置 Map 对象
         *
         * @param customMap Map 对象
         * @return this
         */
        public Builder customMap(@NotNull Map<String, Object> customMap) {
            this.injectionConfig.customMap = customMap;
            return this;
        }

        /**
         * 自定义配置模板文件
         *
         * @param customFile key为文件名称，value为文件路径
         * @return this
         */
        public Builder customFile(@NotNull Map<String, String> customFile) {
            return customFile(customFile.entrySet().stream()
                .map(e -> new CustomFile.Builder().fileName(e.getKey()).templatePath(e.getValue()).build())
                .collect(Collectors.toList()));
        }

        public Builder customFile(@NotNull CustomFile customFile) {
            this.injectionConfig.customFiles.add(customFile);
            return this;
        }

        public Builder customFile(@NotNull List<CustomFile> customFiles) {
            this.injectionConfig.customFiles.addAll(customFiles);
            return this;
        }

        public Builder customFile(Consumer<CustomFile.Builder> consumer) {
            CustomFile.Builder builder = new CustomFile.Builder();
            consumer.accept(builder);
            this.injectionConfig.customFiles.add(builder.build());
            return this;
        }

        /**
         * 覆盖已有文件（已弃用，已放到自定义文件类CustomFile中，3.5.4版本会删除此方法）
         */
        @Deprecated
        public Builder fileOverride() {
            LOGGER.warn("fileOverride方法后续会删除，替代方法为enableFileOverride方法");
            this.injectionConfig.fileOverride = true;
            return this;
        }

        public InjectionConfig build() {
            return this.injectionConfig;
        }
    }
}
