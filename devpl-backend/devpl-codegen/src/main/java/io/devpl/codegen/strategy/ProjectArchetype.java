package io.devpl.codegen.strategy;

/**
 * 项目骨架
 */
public interface ProjectArchetype {

    /**
     * 根目录
     *
     * @param rootDir 根目录
     */
    default void setRootDirectory(String rootDir) {
    }

    /**
     * 设置模块名称
     *
     * @param module 模块名称
     */
    default void setModuleName(String module) {
    }

    /**
     * 返回相对于项目根路径的相对路径
     *
     * @param filename 文件名
     * @param ext      文件扩展名
     * @return 文件存放位置，相对路径
     */
    String locate(String filename, String ext);
}
