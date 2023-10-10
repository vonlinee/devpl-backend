package com.baomidou.mybatisplus.generator.util;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.text.MessageFormat;

/**
 * 运行工具类
 * @author nieqiurong 2020/11/13.
 * @since 3.5.0
 */
public class RuntimeUtils {

    private static final Logger LOGGER = LoggerFactory.getLogger(RuntimeUtils.class);

    /**
     * 打开指定输出文件目录
     * @param outDir 输出文件目录
     * @throws IOException 执行命令出错
     */
    public static void openDir(String outDir) throws IOException {
        String osName = System.getProperty("os.name");
        if (osName != null) {
            if (osName.contains("Mac")) {
                Runtime.getRuntime().exec("open " + outDir);
            } else if (osName.contains("Windows")) {
                Runtime.getRuntime().exec(MessageFormat.format("cmd /c start \"\" \"{0}\"", outDir));
            } else {
                LOGGER.debug("文件输出目录:{}", outDir);
            }
        } else {
            LOGGER.warn("读取操作系统失败");
        }
    }
}