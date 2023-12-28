package io.devpl.codegen.template.freemarker;

import freemarker.template.Configuration;
import freemarker.template.Template;
import io.devpl.codegen.template.AbstractTemplateEngine;
import io.devpl.codegen.template.TemplateSource;
import org.jetbrains.annotations.NotNull;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.nio.charset.StandardCharsets;
import java.util.Map;

/**
 * Freemarker 模板引擎实现文件输出
 */
public class FreemarkerTemplateEngine extends AbstractTemplateEngine {

    final Logger log = LoggerFactory.getLogger(FreemarkerTemplateEngine.class);

    private final Configuration configuration;

    public FreemarkerTemplateEngine() {
        configuration = new Configuration(Configuration.DEFAULT_INCOMPATIBLE_IMPROVEMENTS);
        configuration.setDefaultEncoding(StandardCharsets.UTF_8.name());
        configuration.setClassForTemplateLoading(FreemarkerTemplateEngine.class, "/");
    }

    @Override
    public void render(@NotNull String name, @NotNull Map<String, Object> arguments, @NotNull OutputStream outputStream) throws Exception {
        Template template = configuration.getTemplate(name);
        template.process(arguments, new OutputStreamWriter(outputStream, StandardCharsets.UTF_8));
    }

    @Override
    public @NotNull TemplateSource getTemplate(String name) {
        try {
            Template template = configuration.getTemplate(name);
            return new FreeMarkerTemplateSource(template);
        } catch (IOException e) {
            log.error("cannot find template by template name {}", name);
        }
        return TemplateSource.UNKNOWN;
    }

    @Override
    public String getTemplateFileExtension() {
        return ".ftl";
    }
}
