package com.baomidou.mybatisplus.generator.utils;

import java.lang.reflect.Constructor;

/**
 * @author nieqiurong 2020/11/9.
 * @since 3.5.0
 */
public final class ClassUtils {

    private ClassUtils() {
    }

    public static <T> Constructor<T> getDeclaredConstructor(Class<T> clazz, Class<?>... parameterTypes) {
        try {
            return clazz.getDeclaredConstructor(parameterTypes);
        } catch (NoSuchMethodException e) {
            return null;
        }
    }

    /**
     * 获取类名
     * @param className className 全类名
     * @return ignore
     */
    public static String getSimpleName(String className) {
        return StringUtils.isBlank(className) ? null : className.substring(className.lastIndexOf(".") + 1);
    }

    /**
     * <p>
     * 请仅在确定类存在的情况下调用该方法
     * </p>
     * @param name 类名称
     * @return 返回转换后的 Class
     */
    public static Class<?> toClassConfident(String name) {
        try {
            return Class.forName(name, false, getDefaultClassLoader());
        } catch (ClassNotFoundException e) {
            try {
                return Class.forName(name);
            } catch (ClassNotFoundException ex) {
                throw new RuntimeException("找不到指定的class！请仅在明确确定会有 class 的时候，调用该方法", e);
            }
        }
    }

    /**
     * Return the default ClassLoader to use: typically the thread context
     * ClassLoader, if available; the ClassLoader that loaded the ClassUtils
     * class will be used as fallback.
     * <p>Call this method if you intend to use the thread context ClassLoader
     * in a scenario where you clearly prefer a non-null ClassLoader reference:
     * for example, for class path resource loading (but not necessarily for
     * {@code Class.forName}, which accepts a {@code null} ClassLoader
     * reference as well).
     * @return the default ClassLoader (only {@code null} if even the system
     * ClassLoader isn't accessible)
     * @see Thread#getContextClassLoader()
     * @see ClassLoader#getSystemClassLoader()
     * @since 3.3.2
     */
    public static ClassLoader getDefaultClassLoader() {
        ClassLoader cl = null;
        try {
            cl = Thread.currentThread().getContextClassLoader();
        } catch (Throwable ex) {
            // Cannot access thread context ClassLoader - falling back...
        }
        if (cl == null) {
            // No thread context class loader -> use class loader of this class.
            cl = ClassUtils.class.getClassLoader();
            if (cl == null) {
                // getClassLoader() returning null indicates the bootstrap ClassLoader
                try {
                    cl = ClassLoader.getSystemClassLoader();
                } catch (Throwable ex) {
                    // Cannot access system ClassLoader - oh well, maybe the caller can live with null...
                }
            }
        }
        return cl;
    }

}