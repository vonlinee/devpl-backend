package io.devpl.codegen.generator.file;

import io.devpl.codegen.template.Template;
import io.devpl.codegen.template.TemplateArguments;
import io.devpl.codegen.template.TemplateEngine;
import io.devpl.sdk.io.FileUtils;
import lombok.Getter;
import lombok.Setter;

import java.io.FileWriter;
import java.io.IOException;
import java.io.StringWriter;
import java.io.Writer;
import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Objects;

/**
 * 基于模板的生成文件信息
 */
@Getter
@Setter
public class TemplateGeneratedFile extends GeneratedFile {

    /**
     * 模板名称
     */
    private String template;

    /**
     * 使用的模板引擎
     */
    private TemplateEngine templateEngine;

    /**
     * 模板用到的参数
     */
    private TemplateArguments templateArguments;

    private TemplateBasedTargetFile targetFile;

    public TemplateGeneratedFile() {
    }

    public TemplateGeneratedFile(TemplateBasedTargetFile targetFile) {
        Objects.requireNonNull(targetFile, "target file type cannot be null");
        this.targetFile = targetFile;
    }

    @Override
    public TargetFile getFileType() {
        return targetFile;
    }

    @Override
    public void write(Writer writer, Charset charset) throws IOException {
        if (writer == null) {
            String absolutePath = getAbsolutePath();
            if (absolutePath == null) {
                throw new IOException("the path to save is null");
            }
            Path path = FileUtils.createFileQuietly(Paths.get(absolutePath), true);
            String savePath = path.toAbsolutePath().toString();
            try (FileWriter fw = new FileWriter(savePath, charset)) {
                Template ts = templateEngine.getTemplate(template, false);
                templateEngine.render(ts, templateArguments, fw);
            }
        } else {
            Template ts = templateEngine.getTemplate(template, false);
            templateEngine.render(ts, templateArguments, writer);
        }
    }

    @Override
    public String getAbsolutePath() {
        String targetPackageName = getTargetPackageName();
        if (targetPackageName == null) {
            return null;
        }
        String packageDirName = targetPackageName.replace(".", "/");
        Path path = Paths.get(getTargetProject(), packageDirName, getFilename() + getExtension());
        return path.toAbsolutePath().toString();
    }

    @Override
    public String getFormattedContent() {
        StringWriter writer = new StringWriter();
        try {
            write(writer, StandardCharsets.UTF_8);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        return writer.toString();
    }

    public void setTemplateEngine(TemplateEngine templateEngine) {
        Objects.requireNonNull(templateEngine, "template engine must not be null");
        this.templateEngine = templateEngine;
        if (this.template != null) {
            this.template = String.format(this.template, templateEngine.getTemplateFileExtension().substring(1));
            this.template += templateEngine.getTemplateFileExtension();
        }
    }

    public final void setTemplateArguments(TemplateArguments templateArguments) {
        this.templateArguments = templateArguments;
    }

    public final void setTargetFile(TemplateBasedTargetFile targetFile) {
        this.targetFile = targetFile;
    }
}
