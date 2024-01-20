package io.devpl.sdk.util;

import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

import java.lang.reflect.Array;
import java.util.*;
import java.util.function.Function;

/**
 * 数组工具类，用于替换java.util.Arrays
 *
 * @see java.util.Arrays
 */
public final class ArrayUtils {

    private ArrayUtils() {
    }

    /**
     * 数组是否为空
     *
     * @param array 数组
     */
    public static <E> boolean isEmpty(E[] array) {
        return array == null || array.length == 0;
    }

    /**
     * 构造一个ArrayList
     *
     * @param elements 元素列表
     * @param <T>      元素类型
     * @return ArrayList
     * @see java.util.Arrays#asList(Object[])
     */
    @SafeVarargs
    public static <T> List<T> asArrayList(T... elements) {
        if (elements == null) {
            return new ArrayList<>(0);
        }
        ArrayList<T> list = new ArrayList<>(elements.length);
        list.addAll(Arrays.asList(elements));
        return list;
    }

    /**
     * 返回一个不可变的集合，用于替代 {@link java.util.Arrays#asList(Object[])}
     *
     * @param elements 元素列表
     * @param <T>      元素类型
     * @return ArrayList
     * @see java.util.Arrays#asList(Object[])
     */
    @SafeVarargs
    public static <T> List<T> asList(T... elements) {
        if (elements == null) {
            return Collections.emptyList();
        }
        if (elements.length == 1) {
            return Collections.singletonList(elements[0]);
        }
        return java.util.Arrays.asList(elements);
    }

    // ================================ 基本类型数组和包装类型数组之间的转换 start ===============================================

    /**
     * 构造一个基本类型的int数组
     *
     * @param nums 元素列表
     */
    public static int @NotNull [] toIntArray(int @Nullable ... nums) {
        if (nums == null) return new int[0];
        return nums;
    }

    public static Integer[] toIntegerArray(int... intArr) {
        Integer[] res = new Integer[intArr.length];
        for (int i = 0; i < intArr.length; i++) {
            res[i] = intArr[i];
        }
        return res;
    }

    // ================================ 基本类型数组和包装类型数组之间的转换 end ===============================================

    /**
     * 将数组映射为List
     *
     * @param array  数组元素
     * @param mapper 映射
     * @param <E>    数组元素
     * @param <T>    映射后的元素
     * @return 不可变的list
     */
    @SuppressWarnings("unchecked")
    public static <E, T> List<T> toList(E[] array, Function<E, T> mapper) {
        if (isEmpty(array)) {
            return Collections.emptyList();
        }
        Object[] toArray = new Object[array.length];
        for (int i = 0; i < array.length; i++) {
            toArray[i] = mapper.apply(array[i]);
        }
        return (List<T>) java.util.Arrays.asList(toArray);
    }

    /**
     * 将数组映射为可变的List
     *
     * @param array  数组元素
     * @param mapper 映射
     * @param <E>    数组元素
     * @param <T>    映射后的元素
     * @return 可变的list，ArrayList
     * @see ArrayUtils#toList(Object[], Function)
     */
    public static <E, T> List<T> toArrayList(E[] array, Function<E, T> mapper) {
        if (isEmpty(array)) {
            return Collections.emptyList();
        }
        List<T> result = new ArrayList<>();
        for (E e : array) {
            result.add(mapper.apply(e));
        }
        return result;
    }

    /**
     * 数组中是否包含元素
     *
     * @param <T>   数组元素类型
     * @param array 数组
     * @param value 被检查的元素
     * @return 是否包含
     */
    public static <T> boolean contains(T[] array, T value) {
        if (array == null) {
            return false;
        }
        for (T element : array) {
            if (Objects.equals(element, value)) {
                return true;
            }
        }
        return false;
    }

    /**
     * 从元素到该元素在数组中的索引，要求数组中的元素不相同，可以作为Map的key
     * 相同key将被覆盖
     *
     * @param array 数组
     * @param <T>   数组元素
     * @return Map
     */
    public static <T extends Comparable<T>> Map<T, Integer> mapOfElementToIndex(T[] array) {
        Map<T, Integer> indexMap = new HashMap<>();
        for (int i = 0; i < array.length; i++) {
            indexMap.put(array[i], i);
        }
        return indexMap;
    }

    /**
     * Reworked the java.util.Arrays's binarySearch
     *
     * @param a         数组
     * @param fromIndex 开始索引
     * @param toIndex   结束索引
     * @param key       查找的值
     * @return 找到的元素
     * @see Arrays#binarySearch(byte[], byte)
     */
    public static int binarySearch(final int[] a, final int fromIndex, final int toIndex, final int key) {
        int low = fromIndex;
        int high = toIndex - 1;

        while (low <= high) {
            int mid = low + high >>> 1;
            int midVal = a[mid];

            if (midVal < key) {
                low = mid + 1;
            } else if (midVal > key) {
                high = mid - 1;
            } else {
                return mid; // key found
            }
        }
        return low; // key not found.
    }

    /**
     * Add unique element to the array.
     *
     * @param <T>     type of the array element
     * @param array   array
     * @param element element to add
     * @return array, which will contain the new element. Either new array instance, if passed array didn't contain the
     * element, or the same array instance, if the element is already present in the array.
     */
    public static <T> T[] addUnique(T[] array, T element) {
        return addUnique(array, element, true);
    }

    /**
     * Add unique element to the array.
     *
     * @param <T>                    type of the array element
     * @param array                  array
     * @param element                element to add
     * @param replaceElementIfEquals if passed element is equal to some element in the array then depending on this
     *                               parameter it will be replaced or not with the passed element.
     * @return array, which will contain the new element. Either new array instance, if passed array didn't contain the
     * element, or the same array instance, if the element is already present in the array.
     */
    public static <T> T[] addUnique(final T[] array, final T element, final boolean replaceElementIfEquals) {
        final int idx = indexOf(array, element);
        if (idx == -1) {
            final int length = array.length;
            final T[] newArray = Arrays.copyOf(array, length + 1);
            newArray[length] = element;
            return newArray;
        }

        if (replaceElementIfEquals) {
            array[idx] = element;
        }

        return array;
    }

    /**
     * Removes the element from the array.
     *
     * @param <T>     type of the array element
     * @param array   array
     * @param element the element to remove
     * @return array, which won't contain the element. Either new array instance, if passed array contains the element, or
     * the same array instance, if the element wasn't present in the array. <tt>null</tt> will be returned if the last
     * element was removed from the passed array.
     */
    @SuppressWarnings("unchecked")
    public static <T> T[] remove(T[] array, Object element) {
        final int idx = indexOf(array, element);
        if (idx != -1) {
            final int length = array.length;

            if (length == 1) {
                return null;
            }
            final T[] newArray = (T[]) Array.newInstance(array.getClass().getComponentType(), length - 1);
            if (idx > 0) {
                System.arraycopy(array, 0, newArray, 0, idx);
            }
            if (idx < length - 1) {
                System.arraycopy(array, idx + 1, newArray, idx, length - idx - 1);
            }
            return newArray;
        }
        return array;
    }

    /**
     * Return the element index in the array.
     *
     * @param <T>     type of the array element
     * @param array   array
     * @param element the element to look for.
     * @return element's index, or <tt>-1</tt> if element wasn't found.
     */
    public static <T> int indexOf(T[] array, Object element) {
        for (int i = 0; i < array.length; i++) {
            if (element.equals(array[i])) {
                return i;
            }
        }
        return -1;
    }
}