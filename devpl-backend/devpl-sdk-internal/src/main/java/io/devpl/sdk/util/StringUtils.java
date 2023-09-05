package io.devpl.sdk.util;

import com.google.common.base.Preconditions;
import io.devpl.sdk.collection.CollectionUtils;
import io.devpl.sdk.lang.Interpolations;
import io.devpl.sdk.validation.Assert;
import io.devpl.sdk.validation.Validator;

import java.io.ByteArrayOutputStream;
import java.nio.charset.Charset;
import java.util.*;
import java.util.function.Function;
import java.util.function.Supplier;
import java.util.regex.Pattern;

/**
 * String工具类
 * @since 15
 */
public final class StringUtils {

    /**
     * 字符串常量：{@code "null"} <br>
     * 注意：{@code "null" != null}
     */
    public static final String NULL = "null";
    public static final String SINGLE_QUTATION = "'";
    public static final String NULL_STRING = "NULL";
    /**
     * A String for a space character.
     * @since 3.2
     */
    public static final String SPACE = " ";
    /**
     * The empty String {@code ""}.
     * @since 2.0
     */
    public static final String EMPTY = "";
    /**
     * A String for linefeed LF ("\n").
     * @see <a href=
     * "http://docs.oracle.com/javase/specs/jls/se7/html/jls-3.html#jls-3.10.6">
     * JLF: Escape Sequences for Character and String Literals</a>
     * @since 3.2
     */
    public static final String LF = "\n";
    /**
     * A String for carriage return CR ("\r").
     * @see <a href=
     * "http://docs.oracle.com/javase/specs/jls/se7/html/jls-3.html#jls-3.10.6">JLF:
     * Escape Sequences for Character and String Literals</a>
     * @since 3.2
     */
    public static final String CR = "\r";
    /**
     * Represents a failed index search.
     * @since 2.1
     */
    public static final int INDEX_NOT_FOUND = -1;
    public static final String DEFAULT_SEPARATOR = ",";
    private static final String[] EMPTY_STRING_ARRAY = {};
    private static final String FOLDER_SEPARATOR = "/";
    private static final char FOLDER_SEPARATOR_CHAR = '/';
    private static final String WINDOWS_FOLDER_SEPARATOR = "\\";
    private static final String TOP_PATH = "..";
    private static final String CURRENT_PATH = ".";
    private static final char EXTENSION_SEPARATOR = '.';
    private static final Pattern ALL_EN_WORDS = Pattern.compile("[a-zA-Z]+");
    private static final Pattern CONTAIN_EN_WORDS = Pattern.compile(".*[a-zA-z].*");
    private static final int STRING_BUILDER_SIZE = 256;
    /**
     * <p>
     * The maximum size to which the padding(填充) constant(s) can expand.
     * </p>
     */
    private static final int PAD_LIMIT = 8192;

    private StringUtils() {
    }

    public static String substring(String s, String b, char c) {
        int i = b.lastIndexOf(c);
        return s.substring(i);
    }

    public static String substring(String src, Supplier<Integer> startIndexSupplier) {
        return src.substring(startIndexSupplier.get());
    }

    public static <T> String substring(String src, Function<T, Integer> startIndexSupplier, T startIndex) {
        return src.substring(startIndexSupplier.apply(startIndex));
    }

    /**
     * 字符串是否有长度
     * @param str 字符串
     * @return 字符串是否有长度
     */
    public static boolean hasLength(String str) {
        return hasLength((CharSequence) str);
    }

    /**
     * 将字符串转换为同意最长的长度
     * @param strings 数组
     * @return List<String>
     */
    public static List<String> uniformLength(List<String> strings) {
        int maxLen = strings.get(0).length();
        int size = strings.size();
        for (int i = 0; i < size; i++) {
            for (int j = 1; j < size; j++) {
                int nextLen = strings.get(j).length();
                if (nextLen > maxLen) {
                    maxLen = nextLen;
                }
            }
        }
        for (int i = 0; i < size; i++) {
            strings.add(i, appendBlank(strings.remove(i), maxLen));
        }
        return strings;
    }

    /**
     * <p>Checks if any of the CharSequences are empty ("") or null.</p>
     *
     * <pre>
     * Utils.isAnyEmpty((String) null)    = true
     * Utils.isAnyEmpty((String[]) null)  = false
     * Utils.isAnyEmpty(null, "foo")      = true
     * Utils.isAnyEmpty("", "bar")        = true
     * Utils.isAnyEmpty("bob", "")        = true
     * Utils.isAnyEmpty("  bob  ", null)  = true
     * Utils.isAnyEmpty(" ", "bar")       = false
     * Utils.isAnyEmpty("foo", "bar")     = false
     * Utils.isAnyEmpty(new String[]{})   = false
     * Utils.isAnyEmpty(new String[]{""}) = true
     * </pre>
     * @param css the CharSequences to check, maybe null or empty
     * @return {@code true} if any of the CharSequences are empty or null
     * @since 3.2
     */
    public static boolean hasText(final CharSequence... css) {
        if (css == null) {
            return false;
        }
        for (final CharSequence cs : css) {
            if (isEmpty(cs)) {
                return true;
            }
        }
        return false;
    }

    /**
     * @param sequence
     * @param c
     * @param len      长度
     * @return String
     * @since 11
     */
    public static String append(String sequence, char c, int len) {
        int i = len - sequence.length();
        if (i > 0) {
            sequence = sequence + String.valueOf(c).repeat(i);
        }
        return sequence;
    }

    /**
     * @param sequence 字符串
     * @param len      空格数量
     * @return String
     */
    public static String appendBlank(String sequence, int len) {
        int i = len - sequence.length();
        if (i > 0) {
            sequence = sequence + " ".repeat(i);
        }
        return sequence;
    }

    /**
     * 分割字符串
     * @param str       字符串
     * @param delimeter 分隔符
     * @return 分割后的字符串数组
     */
    public static String[] split1(String str, String delimeter) {
        StringTokenizer st = new StringTokenizer(str, delimeter);
        int i = st.countTokens();
        String[] strings = new String[i];
        while (st.hasMoreTokens()) {
            strings[i - (++i)] = st.nextToken();
        }
        return strings;
    }

    /**
     * Check whether the given object (possibly a {@code String}) is empty.
     * This is effectively a shortcut for {@code !hasLength(String)}.
     * <p>This method accepts any Object as an argument, comparing it to
     * {@code null} and the empty String. As a consequence, this method
     * will never return {@code true} for a non-null non-String object.
     * <p>The Object signature is useful for general attribute handling code
     * that commonly deals with Strings but generally has to iterate over
     * Objects since attributes may e.g. be primitive value objects as well.
     * <p><b>Note: If the object is typed to {@code String} upfront, prefer
     * {@link #hasLength(String)} or {@link #hasText(String)} instead.</b>
     * @param str the candidate object (possibly a {@code String})
     * @since 3.2.1
     * @deprecated as of 5.3, in favor of {@link #hasLength(String)} and
     * {@link #hasText(String)} (or {@link ObjectUtils#isEmpty(Object)})
     */
    @Deprecated
    public static boolean isEmpty(Object str) {
        return (str == null || "".equals(str));
    }

    public static boolean isAllEnWords(String str) {
        return ALL_EN_WORDS.matcher(str).matches();
    }

    public static boolean containEnWords(String str) {
        return CONTAIN_EN_WORDS.matcher(str).matches();
    }

    public static boolean isUpperCase(String str) {
        for (char c : str.toCharArray()) {
            if (!Character.isUpperCase(c)) return false;
        }
        return true;
    }

    /**
     * 大写首字母
     * @param str 原字符串
     * @return 大写首字母后的字符串
     */
    public static String upperFirst(String str) {
        if (str == null || str.isEmpty()) {
            return "";
        }
        return Character.toUpperCase(str.toCharArray()[0]) + str.substring(1);
    }

    /**
     * 小写首字母<br>
     * 例如：str = Name, return name
     * @param str 字符串
     * @return 字符串
     */
    public static String lowerFirst(CharSequence str) {
        if (null == str) {
            return null;
        }
        if (!str.isEmpty()) {
            char firstChar = str.charAt(0);
            if (Character.isUpperCase(firstChar)) {
                return Character.toLowerCase(firstChar) + sub(str, 1);
            }
        }
        return str.toString();
    }

    /**
     * 切割指定位置之后部分的字符串
     * @param string    字符串
     * @param fromIndex 切割开始的位置（包括）
     * @return 切割后后剩余的后半部分字符串
     */
    public static String sub(CharSequence string, int fromIndex) {
        if (isEmpty(string)) {
            return null;
        }
        return sub(string, fromIndex, string.length());
    }

    /**
     * 改进JDK subString<br>
     * index从0开始计算，最后一个字符为-1<br>
     * 如果from和to位置一样，返回 "" <br>
     * 如果from或to为负数，则按照length从后向前数位置，如果绝对值大于字符串长度，则from归到0，to归到length<br>
     * 如果经过修正的index中from大于to，则互换from和to example: <br>
     * abcdefgh 2 3 =》 c <br>
     * abcdefgh 2 -3 =》 cde <br>
     * @param str              String
     * @param fromIndexInclude 开始的index（包括）
     * @param toIndexExclude   结束的index（不包括）
     * @return 字串
     */
    public static String sub(CharSequence str, int fromIndexInclude, int toIndexExclude) {
        if (isEmpty(str)) {
            return str(str);
        }
        int len = str.length();

        if (fromIndexInclude < 0) {
            fromIndexInclude = len + fromIndexInclude;
            if (fromIndexInclude < 0) {
                fromIndexInclude = 0;
            }
        } else if (fromIndexInclude > len) {
            fromIndexInclude = len;
        }

        if (toIndexExclude < 0) {
            toIndexExclude = len + toIndexExclude;
            if (toIndexExclude < 0) {
                toIndexExclude = len;
            }
        } else if (toIndexExclude > len) {
            toIndexExclude = len;
        }

        if (toIndexExclude < fromIndexInclude) {
            int tmp = fromIndexInclude;
            fromIndexInclude = toIndexExclude;
            toIndexExclude = tmp;
        }

        if (fromIndexInclude == toIndexExclude) {
            return EMPTY;
        }

        return str.toString().substring(fromIndexInclude, toIndexExclude);
    }

    public static String wrapQuotation(String str, boolean doubleQutaion) {
        if (doubleQutaion) {
            if (!str.contains("\"")) {
                return "\"" + str + "\"";
            } else {
                if (str.startsWith("\"") && !str.endsWith("\"")) return str + "\"";
                if (!str.startsWith("\"") && str.endsWith("\"")) return "\"" + str;
                String substring = str.substring(1, str.length() - 1);
                if (substring.contains("\"")) {
                    return "\"" + substring.replace("\"", "") + "\"";
                }
                return str;
            }
        } else {
            String c = SINGLE_QUTATION;
            if (!str.contains("\"")) {
                return c + str + c;
            } else {
                if (str.startsWith(c) && !str.endsWith(c)) return str + c;
                if (!str.startsWith(c) && str.endsWith(c)) return str + c;
                String substring = str.substring(1, str.length() - 1);
                if (substring.contains(c)) {
                    return c + substring.replace(c, "") + c;
                }
                return str;
            }
        }
    }

    public static boolean containsAlmostOne(String parent, CharSequence... sequences) {
        for (CharSequence s : sequences) {
            if (parent.contains(s)) {
                return true;
            }
        }
        return false;
    }

    public static boolean in(String target, String... group) {
        for (String s : group) {
            if (target.equals(s)) return true;
        }
        return false;
    }

    /**
     * Check whether the given {@code String} contains actual <em>text</em>.
     * <p>More specifically, this method returns {@code true} if the
     * {@code String} is not {@code null}, its length is greater than 0,
     * and it contains at least one non-whitespace character.
     * @param str the {@code String} to check (maybe {@code null})
     * @return {@code true} if the {@code String} is not {@code null}, its
     * length is greater than 0, and it does not contain whitespace only
     * @see #hasText(CharSequence)
     * @see #hasLength(String)
     * @see Character#isWhitespace
     */
    public static boolean hasText(String str) {
        return (str != null && !str.isEmpty() && containsText(str));
    }

    /**
     * Check whether the given {@code CharSequence} contains actual <em>text</em>.
     * <p>More specifically, this method returns {@code true} if the
     * {@code CharSequence} is not {@code null}, its length is greater than
     * 0, and it contains at least one non-whitespace character.
     * <p><pre class="code">
     * StringUtils.hasText(null) = false
     * StringUtils.hasText("") = false
     * StringUtils.hasText(" ") = false
     * StringUtils.hasText("12345") = true
     * StringUtils.hasText(" 12345 ") = true
     * </pre>
     * @param str the {@code CharSequence} to check (maybe {@code null})
     * @return {@code true} if the {@code CharSequence} is not {@code null},
     * its length is greater than 0, and it does not contain whitespace only
     * @see #hasText(String)
     * @see #hasLength(CharSequence)
     * @see Character#isWhitespace
     */
    public static boolean hasText(CharSequence str) {
        return (str != null && !str.isEmpty() && containsText(str));
    }

    /**
     * Check that the given {@code CharSequence} is neither {@code null} nor
     * of length 0.
     * <p>Note: this method returns {@code true} for a {@code CharSequence}
     * that purely consists of whitespace.
     * <p><pre class="code">
     * StringUtils.hasLength(null) = false
     * StringUtils.hasLength("") = false
     * StringUtils.hasLength(" ") = true
     * StringUtils.hasLength("Hello") = true
     * </pre>
     * @param str the {@code CharSequence} to check (maybe {@code null})
     * @return {@code true} if the {@code CharSequence} is not {@code null} and has length
     * @see #hasLength(String)
     * @see #hasText(CharSequence)
     */
    public static boolean hasLength(CharSequence str) {
        return (str != null && !str.isEmpty());
    }

    /**
     * 字符串是否包含文本，循环所有字符，不为空格
     * @param str 字符串
     * @return 字符串是否包含文本
     */
    private static boolean containsText(CharSequence str) {
        int strLen = str.length();
        for (int i = 0; i < strLen; i++) {
            if (!Character.isWhitespace(str.charAt(i))) {
                return true;
            }
        }
        return false;
    }

    /**
     * <p>
     * Joins the elements of the provided {@code Iterable} into a single String
     * containing the provided elements.
     * </p>
     *
     * <p>
     * No delimiter is added before or after the list. A {@code null} separator is
     * the same as an empty String ("").
     * </p>
     *
     * <p>
     * See the examples here: {@link # join(Object[], String)}.
     * </p>
     * @param iterable  the {@code Iterable} providing the values to join together,
     *                  maybe null
     * @param separator the separator character to use, null treated as ""
     * @return the joined String, {@code null} if null iterator input
     * @since 2.3
     */
    public static String join(final Iterable<?> iterable, final String separator) {
        if (iterable == null) {
            return null;
        }
        return join(iterable.iterator(), separator);
    }

    /**
     * 使用指定分隔符拼接字符串
     * @param separator
     * @param items
     * @return
     */
    public static String join(final String separator, String... items) {
        return join(java.util.Arrays.asList(items).iterator(), separator);
    }

    /**
     * 使用指定分隔符拼接字符串
     * @param items 字符串列表
     * @return 拼接后的字符串
     */
    public static String join(String... items) {
        return join(Arrays.asList(items).iterator(), DEFAULT_SEPARATOR);
    }

    /**
     * <p>
     * Joins the elements of the provided {@code Iterator} into a single String
     * containing the provided elements.
     * </p>
     *
     * <p>
     * No delimiter is added before or after the list. A {@code null} separator is
     * the same as an empty String ("").
     * </p>
     *
     * <p>
     * See the examples here: {@link # join(Object[], String)}.
     * </p>
     * @param iterator  the {@code Iterator} of values to join together, maybe null
     * @param separator the separator character to use, null treated as ""
     * @return the joined String, {@code null} if null iterator input
     */
    public static String join(final Iterator<?> iterator, final String separator) {
        // handle null, zero and one elements before building a buffer
        if (iterator == null) {
            return null;
        }
        if (!iterator.hasNext()) {
            return EMPTY;
        }
        final Object first = iterator.next();
        if (!iterator.hasNext()) {
            return Objects.toString(first, "");
        }
        // two or more elements
        final StringBuilder buf = new StringBuilder(STRING_BUILDER_SIZE); // Java default is 16, probably too small
        if (first != null) {
            buf.append(first);
        }
        while (iterator.hasNext()) {
            if (separator != null) {
                buf.append(separator);
            }
            final Object obj = iterator.next();
            if (obj != null) {
                buf.append(obj);
            }
        }
        return buf.toString();
    }

    /**
     * 指定编码的字符串长度
     */
    public static int length(String str, String charset) {
        int len = 0;
        int j = 0;
        byte[] bytes = str.getBytes(Charset.forName(charset));
        while (bytes.length > 0) {
            short tmpst = (short) (bytes[j] & 0xF0);
            if (tmpst >= 0xB0) {
                if (tmpst < 0xC0 || ((tmpst == 0xC0) || (tmpst == 0xD0))) {
                    j += 2;
                    len += 2;
                } else if (tmpst == 0xE0) {
                    j += 3;
                    len += 2;
                } else { // tmpst == 0xF0
                    short tmpst0 = (short) (((short) bytes[j]) & 0x0F);
                    if (tmpst0 == 0) {
                        j += 4;
                        len += 2;
                    } else if (tmpst0 < 12) { // tmpst0 > 0
                        j += 5;
                        len += 2;
                    } else { // tmpst0 > 11
                        j += 6;
                        len += 2;
                    }
                }
            } else {
                j += 1;
                len += 1;
            }
            if (j > bytes.length - 1) {
                break;
            }
        }
        return len;
    }

    /**
     * 是否包含空格
     * @param sequence CharSequence
     * @return
     */
    public static boolean containWhiteSpace(CharSequence sequence) {
        return sequence == null || sequence.toString().contains(" ");
    }

    /**
     * 重复字符串指定次数，然后new一个新字符串
     * @param string 字符串
     * @param count  重复次数
     * @return 字符串
     */
    public static String repeat(String string, int count) {
        Validator.whenNull(string);
        if (count <= 1) {
            Validator.whenTrue(count >= 0, "invalid count: %s", count);
            return (count == 0) ? "" : string;
        }
        final int len = string.length();
        final long longSize = (long) len * (long) count;
        final int size = (int) longSize;
        if (size != longSize) {
            throw new ArrayIndexOutOfBoundsException("Required array size too large: " + longSize);
        }
        final char[] array = new char[size];
        string.getChars(0, len, array, 0);
        int n;
        for (n = len; n < size - n; n <<= 1) {
            System.arraycopy(array, 0, array, n, n);
        }
        System.arraycopy(array, 0, array, n, size - n);
        return new String(array);
    }

    /**
     * Returns the given {@code template} string with each occurrence of {@code "%s"} replaced with
     * the corresponding argument value from {@code args}; or, if the placeholder and argument counts
     * do not match, returns a best-effort form of that string. Will not throw an exception under
     * normal conditions.
     *
     * <p><b>Note:</b> For most string-formatting needs, use {@link String#format String.format},
     * {@link java.io.PrintWriter#format PrintWriter.format}, and related methods. These support the
     * full range of <a
     * href="https://docs.oracle.com/javase/9/docs/api/java/util/Formatter.html#syntax">format
     * specifiers</a>, and alert you to usage errors by throwing {@link
     * IllegalFormatException}.
     *
     * <p>In certain cases, such as outputting debugging information or constructing a message to be
     * used for another unchecked exception, an exception during string formatting would serve little
     * purpose except to supplant the real information you were trying to provide. These are the cases
     * this method is made for; it instead generates a best-effort string with all supplied argument
     * values present. This method is also useful in environments such as GWT where {@code
     * String.format} is not available. As an example, method implementations of the {@link
     * Preconditions} class use this formatter, for both of the reasons just discussed.
     *
     * <p><b>Warning:</b> Only the exact two-character placeholder sequence {@code "%s"} is
     * recognized.
     * @param template a string containing zero or more {@code "%s"} placeholder sequences. {@code
     *                 null} is treated as the four-character string {@code "null"}.
     * @param args     the arguments to be substituted into the message template. The first argument
     *                 specified is substituted for the first occurrence of {@code "%s"} in the template, and so
     *                 forth. A {@code null} argument is converted to the four-character string {@code "null"};
     *                 non-null values are converted to strings using {@link Object#toString()}.
     * @since 25.1
     */
    public static String format(String template, Object... args) {
        template = String.valueOf(template); // null -> "null"
        if (args == null) {
            args = new Object[]{"(Object[])null"};
        } else {
            for (int i = 0; i < args.length; i++) {
                args[i] = valueOf(args[i]);
            }
        }
        // start substituting the arguments into the '%s' placeholders
        StringBuilder builder = new StringBuilder(template.length() + 16 * args.length);
        int templateStart = 0;
        int i = 0;
        while (i < args.length) {
            int placeholderStart = template.indexOf("%s", templateStart);
            if (placeholderStart == -1) {
                break;
            }
            builder.append(template, templateStart, placeholderStart);
            builder.append(args[i++]);
            templateStart = placeholderStart + 2;
        }
        builder.append(template, templateStart, template.length());

        // if we run out of placeholders, append the extra args in square braces
        if (i < args.length) {
            builder.append(" [");
            builder.append(args[i++]);
            while (i < args.length) {
                builder.append(", ");
                builder.append(args[i++]);
            }
            builder.append(']');
        }

        return builder.toString();
    }

    /**
     * 会对输入参数的可能情况进行检测
     * @param o object
     * @return 字符串
     * @see String#valueOf(Object)
     */
    public static String valueOf(Object o) {
        if (o == null) {
            return NULL_STRING;
        }
        try {
            return o.toString();
        } catch (Exception e) {
            // Default toString() behavior - see Object.toString()
            String objectToString = o.getClass().getName() + '@' + Integer.toHexString(System.identityHashCode(o));
            // Log is created inline with fixed name to avoid forcing Proguard to create another class.
            return "<" + objectToString + " threw " + e.getClass().getName() + ">";
        }
    }

    /**
     * 判断字符串是否为空字符串
     * @param str 待校验的字符串
     * @return 字符串是否不为空
     * @see StringUtils#hasText(String)
     */
    public static boolean isBlank(String str) {
        return !hasText(str);
    }

    /**
     * 判断字符串是否为空字符串
     * @param sequence 待校验的字符序列
     * @return 字符串是否不为空
     * @see StringUtils#hasText(CharSequence)
     */
    public static boolean isBlank(CharSequence sequence) {
        return !hasText(sequence);
    }

    /**
     * 通过kv形式进行字符串插值
     * @param template 模式串
     * @param mappings 参数
     * @return 插值结果
     */
    public static String interpolate(String template, Map<String, String> mappings) {
        return Interpolations.named(template, mappings);
    }

    /**
     * Check whether the given {@code CharSequence} contains any whitespace characters.
     * @param str the {@code CharSequence} to check (maybe {@code null})
     * @return {@code true} if the {@code CharSequence} is not empty and
     * contains at least 1 whitespace character
     * @see Character#isWhitespace
     */
    private static boolean containsWhitespace(CharSequence str) {
        if (!hasLength(str)) {
            return false;
        }
        int strLen = str.length();
        for (int i = 0; i < strLen; i++) {
            if (Character.isWhitespace((int) str.charAt(i))) {
                return true;
            }
        }
        return false;
    }

    /**
     * Check whether the given {@code String} contains any whitespace characters.
     * @param str the {@code String} to check (maybe {@code null})
     * @return {@code true} if the {@code String} is not empty and
     * contains at least 1 whitespace character
     * @see #containsWhitespace(CharSequence)
     */
    public static boolean containsWhitespace(String str) {
        return containsWhitespace((CharSequence) str);
    }

    /**
     * 去掉头部和尾部的空格
     * @param str the {@code String} to check
     * @return the trimmed {@code String}
     * @see java.lang.Character#isWhitespace
     */
    public static String trimWhitespace(String str) {
        if (!hasLength(str)) {
            return str;
        }
        int beginIndex = 0;
        int endIndex = str.length() - 1;
        while (beginIndex <= endIndex && Character.isWhitespace(str.charAt(beginIndex))) {
            beginIndex++;
        }
        while (endIndex > beginIndex && Character.isWhitespace(str.charAt(endIndex))) {
            endIndex--;
        }
        return str.substring(beginIndex, endIndex + 1);
    }

    /**
     * 遍历字符数组，去掉字符串中所有的空格，包括头部，尾部以及中间的所有空格
     * @param str the {@code String} to check
     * @return the trimmed {@code String}
     * @see java.lang.Character#isWhitespace
     */
    public static String trimAllWhitespace(String str) {
        if (!hasLength(str)) {
            return str;
        }
        int len = str.length();
        StringBuilder sb = new StringBuilder(str.length());
        for (int i = 0; i < len; i++) {
            char c = str.charAt(i);
            if (!Character.isWhitespace(c)) {
                sb.append(c);
            }
        }
        return sb.toString();
    }

    /**
     * 去掉开头的空格
     * @param str the {@code String} to check
     * @return the trimmed {@code String}
     * @see java.lang.Character#isWhitespace
     */
    public static String trimLeadingWhitespace(String str) {
        if (!hasLength(str)) {
            return str;
        }
        int beginIdx = 0;
        while (beginIdx < str.length() && Character.isWhitespace(str.charAt(beginIdx))) {
            beginIdx++;
        }
        return str.substring(beginIdx);
    }

    /**
     * Trim trailing whitespace from the given {@code String}.
     * @param str the {@code String} to check
     * @return the trimmed {@code String}
     * @see java.lang.Character#isWhitespace
     */
    public static String trimTrailingWhitespace(String str) {
        if (!hasLength(str)) {
            return str;
        }
        int endIdx = str.length() - 1;
        while (endIdx >= 0 && Character.isWhitespace(str.charAt(endIdx))) {
            endIdx--;
        }
        return str.substring(0, endIdx + 1);
    }

    /**
     * Trim all occurrences of the supplied leading character from the given {@code String}.
     * @param str              the {@code String} to check
     * @param leadingCharacter the leading character to be trimmed
     * @return the trimmed {@code String}
     */
    public static String trimLeadingCharacter(String str, char leadingCharacter) {
        if (!hasLength(str)) {
            return str;
        }
        int beginIdx = 0;
        while (beginIdx < str.length() && leadingCharacter == str.charAt(beginIdx)) {
            beginIdx++;
        }
        return str.substring(beginIdx);
    }

    /**
     * Trim all occurrences of the supplied trailing character from the given {@code String}.
     * @param str               the {@code String} to check
     * @param trailingCharacter the trailing character to be trimmed
     * @return the trimmed {@code String}
     */
    public static String trimTrailingCharacter(String str, char trailingCharacter) {
        if (!hasLength(str)) {
            return str;
        }
        int endIdx = str.length() - 1;
        while (endIdx >= 0 && trailingCharacter == str.charAt(endIdx)) {
            endIdx--;
        }
        return str.substring(0, endIdx + 1);
    }

    /**
     * Test if the given {@code String} matches the given single character.
     * @param str             the {@code String} to check
     * @param singleCharacter the character to compare to
     * @since 5.2.9
     */
    public static boolean matchesCharacter(String str, char singleCharacter) {
        return (str != null && str.length() == 1 && str.charAt(0) == singleCharacter);
    }

    /**
     * Test if the given {@code String} starts with the specified prefix,
     * ignoring upper/lower case.
     * @param str    the {@code String} to check
     * @param prefix the prefix to look for
     * @see java.lang.String#startsWith
     */
    public static boolean startsWithIgnoreCase(String str, String prefix) {
        return (str != null && prefix != null && str.length() >= prefix.length() && str.regionMatches(true, 0, prefix, 0, prefix.length()));
    }

    /**
     * Test if the given {@code String} ends with the specified suffix,
     * ignoring upper/lower case.
     * @param str    the {@code String} to check
     * @param suffix the suffix to look for
     * @see java.lang.String#endsWith
     */
    public static boolean endsWithIgnoreCase(String str, String suffix) {
        return (str != null && suffix != null && str.length() >= suffix.length() && str.regionMatches(true, str.length() - suffix.length(), suffix, 0, suffix.length()));
    }

    /**
     * Test whether the given string matches the given substring
     * at the given index.
     * @param str       the original string (or StringBuilder)
     * @param index     the index in the original string to start matching against
     * @param substring the substring to match at the given index
     */
    public static boolean substringMatch(CharSequence str, int index, CharSequence substring) {
        if (index + substring.length() > str.length()) {
            return false;
        }
        for (int i = 0; i < substring.length(); i++) {
            if (str.charAt(index + i) != substring.charAt(i)) {
                return false;
            }
        }
        return true;
    }

    /**
     * Count the occurrences of the substring {@code sub} in string {@code str}.
     * @param str string to search in
     * @param sub string to search for
     */
    public static int countOccurrencesOf(String str, String sub) {
        if (!hasLength(str) || !hasLength(sub)) {
            return 0;
        }

        int count = 0;
        int pos = 0;
        int idx;
        while ((idx = str.indexOf(sub, pos)) != -1) {
            ++count;
            pos = idx + sub.length();
        }
        return count;
    }

    /**
     * Replace all occurrences of a substring within a string with another string.
     * @param inString   {@code String} to examine
     * @param oldPattern {@code String} to replace
     * @param newPattern {@code String} to insert
     * @return a {@code String} with the replacements
     */
    public static String replace(String inString, String oldPattern, String newPattern) {
        if (!hasLength(inString) || !hasLength(oldPattern) || newPattern == null) {
            return inString;
        }
        int index = inString.indexOf(oldPattern);
        if (index == -1) {
            // no occurrence -> can return input as-is
            return inString;
        }

        int capacity = inString.length();
        if (newPattern.length() > oldPattern.length()) {
            capacity += 16;
        }
        StringBuilder sb = new StringBuilder(capacity);

        int pos = 0;  // our position in the old string
        int patLen = oldPattern.length();
        while (index >= 0) {
            sb.append(inString, pos, index);
            sb.append(newPattern);
            pos = index + patLen;
            index = inString.indexOf(oldPattern, pos);
        }

        // append any characters to the right of a match
        sb.append(inString, pos, inString.length());
        return sb.toString();
    }

    /**
     * Delete all occurrences of the given substring.
     * @param inString the original {@code String}
     * @param pattern  the pattern to delete all occurrences of
     * @return the resulting {@code String}
     */
    public static String delete(String inString, String pattern) {
        return replace(inString, pattern, "");
    }

    /**
     * Delete any character in a given {@code String}.
     * @param inString      the original {@code String}
     * @param charsToDelete a set of characters to delete.
     *                      E.g. "az\n" will delete 'a's, 'z's and new lines.
     * @return the resulting {@code String}
     */
    public static String deleteAny(String inString, String charsToDelete) {
        if (!hasLength(inString) || !hasLength(charsToDelete)) {
            return inString;
        }

        int lastCharIndex = 0;
        char[] result = new char[inString.length()];
        for (int i = 0; i < inString.length(); i++) {
            char c = inString.charAt(i);
            if (charsToDelete.indexOf(c) == -1) {
                result[lastCharIndex++] = c;
            }
        }
        if (lastCharIndex == inString.length()) {
            return inString;
        }
        return new String(result, 0, lastCharIndex);
    }

    //---------------------------------------------------------------------
    // Convenience methods for working with formatted Strings
    //---------------------------------------------------------------------

    /**
     * Quote the given {@code String} with single quotes.
     * @param str the input {@code String} (e.g. "myString")
     * @return the quoted {@code String} (e.g. "'myString'"),
     * or {@code null} if the input was {@code null}
     */

    public static String quote(String str) {
        return (str != null ? "'" + str + "'" : null);
    }

    /**
     * Turn the given Object into a {@code String} with single quotes
     * if it is a {@code String}; keeping the Object as-is else.
     * @param obj the input Object (e.g. "myString")
     * @return the quoted {@code String} (e.g. "'myString'"),
     * or the input object as-is if not a {@code String}
     */

    public static Object quoteIfString(Object obj) {
        return (obj instanceof String ? quote((String) obj) : obj);
    }

    /**
     * Unqualify a string qualified by a '.' dot character. For example,
     * "this.name.is.qualified", returns "qualified".
     * @param qualifiedName the qualified name
     */
    public static String unqualify(String qualifiedName) {
        return unqualify(qualifiedName, '.');
    }

    /**
     * Unqualify a string qualified by a separator character. For example,
     * "this:name:is:qualified" returns "qualified" if using a ':' separator.
     * @param qualifiedName the qualified name
     * @param separator     the separator
     */
    public static String unqualify(String qualifiedName, char separator) {
        return qualifiedName.substring(qualifiedName.lastIndexOf(separator) + 1);
    }

    /**
     * Capitalize a {@code String}, changing the first letter to
     * upper case as per {@link Character#toUpperCase(char)}.
     * No other letters are changed.
     * @param str the {@code String} to capitalize
     * @return the capitalized {@code String}
     */
    public static String capitalize(String str) {
        return changeFirstCharacterCase(str, true);
    }

    /**
     * Uncapitalize a {@code String}, changing the first letter to
     * lower case as per {@link Character#toLowerCase(char)}.
     * No other letters are changed.
     * @param str the {@code String} to uncapitalize
     * @return the uncapitalized {@code String}
     */
    public static String uncapitalize(String str) {
        return changeFirstCharacterCase(str, false);
    }

    private static String changeFirstCharacterCase(String str, boolean capitalize) {
        if (!hasLength(str)) {
            return str;
        }

        char baseChar = str.charAt(0);
        char updatedChar;
        if (capitalize) {
            updatedChar = Character.toUpperCase(baseChar);
        } else {
            updatedChar = Character.toLowerCase(baseChar);
        }
        if (baseChar == updatedChar) {
            return str;
        }

        char[] chars = str.toCharArray();
        chars[0] = updatedChar;
        return new String(chars);
    }

    /**
     * Extract the filename from the given Java resource path,
     * e.g. {@code "mypath/myfile.txt" &rarr; "myfile.txt"}.
     * @param path the file path (maybe {@code null})
     * @return the extracted filename, or {@code null} if none
     */

    public static String getFilename(String path) {
        if (path == null) {
            return null;
        }

        int separatorIndex = path.lastIndexOf(FOLDER_SEPARATOR_CHAR);
        return (separatorIndex != -1 ? path.substring(separatorIndex + 1) : path);
    }

    /**
     * Extract the filename extension from the given Java resource path,
     * e.g. "mypath/myfile.txt" &rarr; "txt".
     * @param path the file path (maybe {@code null})
     * @return the extracted filename extension, or {@code null} if none
     */

    public static String getFilenameExtension(String path) {
        if (path == null) {
            return null;
        }

        int extIndex = path.lastIndexOf(EXTENSION_SEPARATOR);
        if (extIndex == -1) {
            return null;
        }

        int folderIndex = path.lastIndexOf(FOLDER_SEPARATOR_CHAR);
        if (folderIndex > extIndex) {
            return null;
        }

        return path.substring(extIndex + 1);
    }

    /**
     * Strip the filename extension from the given Java resource path,
     * e.g. "mypath/myfile.txt" &rarr; "mypath/myfile".
     * @param path the file path
     * @return the path with stripped filename extension
     */
    public static String stripFilenameExtension(String path) {
        int extIndex = path.lastIndexOf(EXTENSION_SEPARATOR);
        if (extIndex == -1) {
            return path;
        }

        int folderIndex = path.lastIndexOf(FOLDER_SEPARATOR_CHAR);
        if (folderIndex > extIndex) {
            return path;
        }

        return path.substring(0, extIndex);
    }

    /**
     * Apply the given relative path to the given Java resource path,
     * assuming standard Java folder separation (i.e. "/" separators).
     * @param path         the path to start from (usually a full file path)
     * @param relativePath the relative path to apply
     *                     (relative to the full file path above)
     * @return the full file path that results from applying the relative path
     */
    public static String applyRelativePath(String path, String relativePath) {
        int separatorIndex = path.lastIndexOf(FOLDER_SEPARATOR_CHAR);
        if (separatorIndex != -1) {
            String newPath = path.substring(0, separatorIndex);
            if (!relativePath.startsWith(FOLDER_SEPARATOR)) {
                newPath += FOLDER_SEPARATOR_CHAR;
            }
            return newPath + relativePath;
        } else {
            return relativePath;
        }
    }

    /**
     * Normalize the path by suppressing sequences like "path/.." and
     * inner simple dots.
     * <p>The result is convenient for path comparison. For other uses,
     * notice that Windows separators ("\") are replaced by simple slashes.
     * <p><strong>NOTE</strong> that {@code cleanPath} should not be depended
     * upon in a security context. Other mechanisms should be used to prevent
     * path-traversal issues.
     * @param path the original path
     * @return the normalized path
     */
    public static String cleanPath(String path) {
        if (!hasLength(path)) {
            return path;
        }

        String normalizedPath = replace(path, WINDOWS_FOLDER_SEPARATOR, FOLDER_SEPARATOR);
        String pathToUse = normalizedPath;

        // Shortcut if there is no work to do
        if (pathToUse.indexOf('.') == -1) {
            return pathToUse;
        }

        // Strip prefix from path to analyze, to not treat it as part of the
        // first path element. This is necessary to correctly parse paths like
        // "file:core/../core/io/Resource.class", where the "." should just
        // strip the first "core" directory while keeping the "file:" prefix.
        int prefixIndex = pathToUse.indexOf(':');
        String prefix = "";
        if (prefixIndex != -1) {
            prefix = pathToUse.substring(0, prefixIndex + 1);
            if (prefix.contains(FOLDER_SEPARATOR)) {
                prefix = "";
            } else {
                pathToUse = pathToUse.substring(prefixIndex + 1);
            }
        }
        if (pathToUse.startsWith(FOLDER_SEPARATOR)) {
            prefix = prefix + FOLDER_SEPARATOR;
            pathToUse = pathToUse.substring(1);
        }

        String[] pathArray = delimitedListToStringArray(pathToUse, FOLDER_SEPARATOR);
        // we never require more elements than pathArray and in the common case the same number
        Deque<String> pathElements = new ArrayDeque<>(pathArray.length);
        int tops = 0;

        for (int i = pathArray.length - 1; i >= 0; i--) {
            String element = pathArray[i];
            if (CURRENT_PATH.equals(element)) {
                // Points to current directory - drop it.
            } else if (TOP_PATH.equals(element)) {
                // Registering top path found.
                tops++;
            } else {
                if (tops > 0) {
                    // Merging path element with element corresponding to top path.
                    tops--;
                } else {
                    // Normal path element found.
                    pathElements.addFirst(element);
                }
            }
        }

        // All path elements stayed the same - shortcut
        if (pathArray.length == pathElements.size()) {
            return normalizedPath;
        }
        // Remaining top paths need to be retained.
        for (int i = 0; i < tops; i++) {
            pathElements.addFirst(TOP_PATH);
        }
        // If nothing else left, at least explicitly point to current path.
        if (pathElements.size() == 1 && pathElements.getLast().isEmpty() && !prefix.endsWith(FOLDER_SEPARATOR)) {
            pathElements.addFirst(CURRENT_PATH);
        }

        final String joined = collectionToDelimitedString(pathElements, FOLDER_SEPARATOR);
        // avoid string concatenation with empty prefix
        return prefix.isEmpty() ? joined : prefix + joined;
    }

    /**
     * Compare two paths after normalization of them.
     * @param path1 first path for comparison
     * @param path2 second path for comparison
     * @return whether the two paths are equivalent after normalization
     */
    public static boolean pathEquals(String path1, String path2) {
        return cleanPath(path1).equals(cleanPath(path2));
    }

    /**
     * Decode the given encoded URI component value. Based on the following rules:
     * <ul>
     * <li>Alphanumeric characters {@code "a"} through {@code "z"}, {@code "A"} through {@code "Z"},
     * and {@code "0"} through {@code "9"} stay the same.</li>
     * <li>Special characters {@code "-"}, {@code "_"}, {@code "."}, and {@code "*"} stay the same.</li>
     * <li>A sequence "{@code %<i>xy</i>}" is interpreted as a hexadecimal representation of the character.</li>
     * </ul>
     * @param source  the encoded String
     * @param charset the character set
     * @return the decoded value
     * @throws IllegalArgumentException when the given source contains invalid encoded sequences
     * @see java.net.URLDecoder#decode(String, String)
     * @since 5.0
     */
    public static String uriDecode(String source, Charset charset) {
        int length = source.length();
        if (length == 0) {
            return source;
        }
        Assert.notNull(charset, "Charset must not be null");

        ByteArrayOutputStream baos = new ByteArrayOutputStream(length);
        boolean changed = false;
        for (int i = 0; i < length; i++) {
            int ch = source.charAt(i);
            if (ch == '%') {
                if (i + 2 < length) {
                    char hex1 = source.charAt(i + 1);
                    char hex2 = source.charAt(i + 2);
                    int u = Character.digit(hex1, 16);
                    int l = Character.digit(hex2, 16);
                    if (u == -1 || l == -1) {
                        throw new IllegalArgumentException("Invalid encoded sequence \"" + source.substring(i) + "\"");
                    }
                    baos.write((char) ((u << 4) + l));
                    i += 2;
                    changed = true;
                } else {
                    throw new IllegalArgumentException("Invalid encoded sequence \"" + source.substring(i) + "\"");
                }
            } else {
                baos.write(ch);
            }
        }
        return (changed ? baos.toString(charset) : source);
    }

    /**
     * Parse the given {@code String} value into a {@link Locale}, accepting
     * the {@link Locale#toString} format as well as BCP 47 language tags as
     * specified by {@link Locale#forLanguageTag}.
     * @param localeValue the locale value: following either {@code Locale's}
     *                    {@code toString()} format ("en", "en_UK", etc.), also accepting spaces as
     *                    separators (as an alternative to underscores), or BCP 47 (e.g. "en-UK")
     * @return a corresponding {@code Locale} instance, or {@code null} if none
     * @throws IllegalArgumentException in case of an invalid locale specification
     * @see #parseLocaleString
     * @see Locale#forLanguageTag
     * @since 5.0.4
     */

    public static Locale parseLocale(String localeValue) {
        String[] tokens = tokenizeLocaleSource(localeValue);
        if (tokens.length == 1) {
            validateLocalePart(localeValue);
            Locale resolved = Locale.forLanguageTag(localeValue);
            if (!resolved.getLanguage().isEmpty()) {
                return resolved;
            }
        }
        return parseLocaleTokens(localeValue, tokens);
    }

    /**
     * Parse the given {@code String} representation into a {@link Locale}.
     * <p>For many parsing scenarios, this is an inverse operation of
     * {@link Locale#toString Locale's toString}, in a lenient sense.
     * This method does not aim for strict {@code Locale} design compliance;
     * it is rather specifically tailored for typical Spring parsing needs.
     * <p><b>Note: This delegate does not accept the BCP 47 language tag format.
     * Please use {@link #parseLocale} for lenient parsing of both formats.</b>
     * @param localeString the locale {@code String}: following {@code Locale's}
     *                     {@code toString()} format ("en", "en_UK", etc.), also accepting spaces as
     *                     separators (as an alternative to underscores)
     * @return a corresponding {@code Locale} instance, or {@code null} if none
     * @throws IllegalArgumentException in case of an invalid locale specification
     */

    public static Locale parseLocaleString(String localeString) {
        return parseLocaleTokens(localeString, tokenizeLocaleSource(localeString));
    }

    private static String[] tokenizeLocaleSource(String localeSource) {
        return tokenizeToStringArray(localeSource, "_ ", false, false);
    }


    private static Locale parseLocaleTokens(String localeString, String[] tokens) {
        String language = (tokens.length > 0 ? tokens[0] : "");
        String country = (tokens.length > 1 ? tokens[1] : "");
        validateLocalePart(language);
        validateLocalePart(country);

        String variant = "";
        if (tokens.length > 2) {
            // There is definitely a variant, and it is everything after the country
            // code sans the separator between the country code and the variant.
            int endIndexOfCountryCode = localeString.indexOf(country, language.length()) + country.length();
            // Strip off any leading '_' and whitespace, what's left is the variant.
            variant = trimLeadingWhitespace(localeString.substring(endIndexOfCountryCode));
            if (variant.startsWith("_")) {
                variant = trimLeadingCharacter(variant, '_');
            }
        }

        if (variant.isEmpty() && country.startsWith("#")) {
            variant = country;
            country = "";
        }

        return (!language.isEmpty() ? new Locale(language, country, variant) : null);
    }

    private static void validateLocalePart(String localePart) {
        for (int i = 0; i < localePart.length(); i++) {
            char ch = localePart.charAt(i);
            if (ch != ' ' && ch != '_' && ch != '-' && ch != '#' && !Character.isLetterOrDigit(ch)) {
                throw new IllegalArgumentException("Locale part \"" + localePart + "\" contains invalid characters");
            }
        }
    }

    /**
     * Determine the RFC 3066 compliant language tag,
     * as used for the HTTP "Accept-Language" header.
     * @param locale the Locale to transform to a language tag
     * @return the RFC 3066 compliant language tag as {@code String}
     * @deprecated as of 5.0.4, in favor of {@link Locale#toLanguageTag()}
     */
    @Deprecated
    public static String toLanguageTag(Locale locale) {
        return locale.getLanguage() + (hasText(locale.getCountry()) ? "-" + locale.getCountry() : "");
    }

    /**
     * Parse the given {@code timeZoneString} value into a {@link TimeZone}.
     * @param timeZoneString the time zone {@code String}, following {@link TimeZone#getTimeZone(String)}
     *                       but throwing {@link IllegalArgumentException} in case of an invalid time zone specification
     * @return a corresponding {@link TimeZone} instance
     * @throws IllegalArgumentException in case of an invalid time zone specification
     */
    public static TimeZone parseTimeZoneString(String timeZoneString) {
        TimeZone timeZone = TimeZone.getTimeZone(timeZoneString);
        if ("GMT".equals(timeZone.getID()) && !timeZoneString.startsWith("GMT")) {
            // We don't want that GMT fallback...
            throw new IllegalArgumentException("Invalid time zone specification '" + timeZoneString + "'");
        }
        return timeZone;
    }

    //---------------------------------------------------------------------
    // Convenience methods for working with String arrays
    //---------------------------------------------------------------------

    /**
     * Copy the given {@link Collection} into a {@code String} array.
     * <p>The {@code Collection} must contain {@code String} elements only.
     * @param collection the {@code Collection} to copy
     *                   (potentially {@code null} or empty)
     * @return the resulting {@code String} array
     */
    public static String[] toStringArray(Collection<String> collection) {
        return (!CollectionUtils.isEmpty(collection) ? collection.toArray(EMPTY_STRING_ARRAY) : EMPTY_STRING_ARRAY);
    }

    /**
     * Copy the given {@link Enumeration} into a {@code String} array.
     * <p>The {@code Enumeration} must contain {@code String} elements only.
     * @param enumeration the {@code Enumeration} to copy
     *                    (potentially {@code null} or empty)
     * @return the resulting {@code String} array
     */
    public static String[] toStringArray(Enumeration<String> enumeration) {
        return (enumeration != null ? toStringArray(Collections.list(enumeration)) : EMPTY_STRING_ARRAY);
    }

    /**
     * Append the given {@code String} to the given {@code String} array,
     * returning a new array consisting of the input array contents plus
     * the given {@code String}.
     * @param array the array to append to (can be {@code null})
     * @param str   the {@code String} to append
     * @return the new array (never {@code null})
     */
    public static String[] addStringToArray(String[] array, String str) {
        if (ObjectUtils.isEmpty(array)) {
            return new String[]{str};
        }
        String[] newArr = new String[array.length + 1];
        System.arraycopy(array, 0, newArr, 0, array.length);
        newArr[array.length] = str;
        return newArr;
    }

    /**
     * Concatenate the given {@code String} arrays into one,
     * with overlapping array elements included twice.
     * <p>The order of elements in the original arrays is preserved.
     * @param array1 the first array (can be {@code null})
     * @param array2 the second array (can be {@code null})
     * @return the new array ({@code null} if both given arrays were {@code null})
     */

    public static String[] concatenateStringArrays(String[] array1, String[] array2) {
        if (ObjectUtils.isEmpty(array1)) {
            return array2;
        }
        if (ObjectUtils.isEmpty(array2)) {
            return array1;
        }

        String[] newArr = new String[array1.length + array2.length];
        System.arraycopy(array1, 0, newArr, 0, array1.length);
        System.arraycopy(array2, 0, newArr, array1.length, array2.length);
        return newArr;
    }

    /**
     * Merge the given {@code String} arrays into one, with overlapping
     * array elements only included once.
     * <p>The order of elements in the original arrays is preserved
     * (except overlapping elements, which are only
     * included on their first occurrence).
     * @param array1 the first array (can be {@code null})
     * @param array2 the second array (can be {@code null})
     * @return the new array ({@code null} if both given arrays were {@code null})
     * @deprecated as of 4.3.15, in favor of manual merging via {@link LinkedHashSet}
     * (with every entry included at most once, even entries within the first array)
     */
    @Deprecated

    public static String[] mergeStringArrays(String[] array1, String[] array2) {
        if (ObjectUtils.isEmpty(array1)) {
            return array2;
        }
        if (ObjectUtils.isEmpty(array2)) {
            return array1;
        }

        List<String> result = new ArrayList<>(Arrays.asList(array1));
        for (String str : array2) {
            if (!result.contains(str)) {
                result.add(str);
            }
        }
        return toStringArray(result);
    }

    /**
     * Sort the given {@code String} array if necessary.
     * @param array the original array (potentially empty)
     * @return the array in sorted form (never {@code null})
     */
    public static String[] sortStringArray(String[] array) {
        if (ObjectUtils.isEmpty(array)) {
            return array;
        }
        Arrays.sort(array);
        return array;
    }

    /**
     * Trim the elements of the given {@code String} array, calling
     * {@code String.trim()} on each non-null element.
     * @param array the original {@code String} array (potentially empty)
     * @return the resulting array (of the same size) with trimmed elements
     */
    public static String[] trimArrayElements(String[] array) {
        if (ObjectUtils.isEmpty(array)) {
            return array;
        }

        String[] result = new String[array.length];
        for (int i = 0; i < array.length; i++) {
            String element = array[i];
            result[i] = (element != null ? element.trim() : null);
        }
        return result;
    }

    /**
     * Remove duplicate strings from the given array.
     * <p>As of 4.2, it preserves the original order, as it uses a {@link LinkedHashSet}.
     * @param array the {@code String} array (potentially empty)
     * @return an array without duplicates, in natural sort order
     */
    public static String[] removeDuplicateStrings(String[] array) {
        if (ObjectUtils.isEmpty(array)) {
            return array;
        }

        Set<String> set = new LinkedHashSet<>(Arrays.asList(array));
        return toStringArray(set);
    }

    /**
     * Split a {@code String} at the first occurrence of the delimiter.
     * Does not include the delimiter in the result.
     * @param toSplit   the string to split (potentially {@code null} or empty)
     * @param delimiter to split the string up with (potentially {@code null} or empty)
     * @return a two element array with index 0 being before the delimiter, and
     * index 1 being after the delimiter (neither element includes the delimiter);
     * or {@code null} if the delimiter wasn't found in the given input {@code String}
     */
    public static String[] split(String toSplit, String delimiter) {
        if (!hasLength(toSplit) || !hasLength(delimiter)) {
            return null;
        }
        int offset = toSplit.indexOf(delimiter);
        if (offset < 0) {
            return null;
        }
        String beforeDelimiter = toSplit.substring(0, offset);
        String afterDelimiter = toSplit.substring(offset + delimiter.length());
        return new String[]{beforeDelimiter, afterDelimiter};
    }


    public static boolean containsAny(final CharSequence cs, final CharSequence... searchCharSequences) {
        for (CharSequence searchCharSequence : searchCharSequences) {
            if (cs.toString().contains(searchCharSequence)) {
                return true;
            }
        }
        return false;
    }

    /**
     * Take an array of strings and split each element based on the given delimiter.
     * A {@code Properties} instance is then generated, with the left of the delimiter
     * providing the key, and the right of the delimiter providing the value.
     * <p>Will trim both the key and value before adding them to the {@code Properties}.
     * @param array     the array to process
     * @param delimiter to split each element using (typically the equals symbol)
     * @return a {@code Properties} instance representing the array contents,
     * or {@code null} if the array to process was {@code null} or empty
     */

    public static Properties splitArrayElementsIntoProperties(String[] array, String delimiter) {
        return splitArrayElementsIntoProperties(array, delimiter, null);
    }

    /**
     * Take an array of strings and split each element based on the given delimiter.
     * A {@code Properties} instance is then generated, with the left of the
     * delimiter providing the key, and the right of the delimiter providing the value.
     * <p>Will trim both the key and value before adding them to the
     * {@code Properties} instance.
     * @param array         the array to process
     * @param delimiter     to split each element using (typically the equals symbol)
     * @param charsToDelete one or more characters to remove from each element
     *                      prior to attempting the split operation (typically the quotation mark
     *                      symbol), or {@code null} if no removal should occur
     * @return a {@code Properties} instance representing the array contents,
     * or {@code null} if the array to process was {@code null} or empty
     */

    public static Properties splitArrayElementsIntoProperties(String[] array, String delimiter, String charsToDelete) {

        if (ObjectUtils.isEmpty(array)) {
            return null;
        }

        Properties result = new Properties();
        for (String element : array) {
            if (charsToDelete != null) {
                element = deleteAny(element, charsToDelete);
            }
            String[] splittedElement = split(element, delimiter);
            if (splittedElement == null) {
                continue;
            }
            result.setProperty(splittedElement[0].trim(), splittedElement[1].trim());
        }
        return result;
    }

    /**
     * Tokenize the given {@code String} into a {@code String} array via a
     * {@link StringTokenizer}.
     * <p>Trims tokens and omits empty tokens.
     * <p>The given {@code delimiters} string can consist of any number of
     * delimiter characters. Each of those characters can be used to separate
     * tokens. A delimiter is always a single character; for multi-character
     * delimiters, consider using {@link #delimitedListToStringArray}.
     * @param str        the {@code String} to tokenize (potentially {@code null} or empty)
     * @param delimiters the delimiter characters, assembled as a {@code String}
     *                   (each of the characters is individually considered as a delimiter)
     * @return an array of the tokens
     * @see java.util.StringTokenizer
     * @see String#trim()
     * @see #delimitedListToStringArray
     */
    public static String[] tokenizeToStringArray(String str, String delimiters) {
        return tokenizeToStringArray(str, delimiters, true, true);
    }

    /**
     * Tokenize the given {@code String} into a {@code String} array via a
     * {@link StringTokenizer}.
     * <p>The given {@code delimiters} string can consist of any number of
     * delimiter characters. Each of those characters can be used to separate
     * tokens. A delimiter is always a single character; for multi-character
     * delimiters, consider using {@link #delimitedListToStringArray}.
     * @param str               the {@code String} to tokenize (potentially {@code null} or empty)
     * @param delimiters        the delimiter characters, assembled as a {@code String}
     *                          (each of the characters is individually considered as a delimiter)
     * @param trimTokens        trim the tokens via {@link String#trim()}
     * @param ignoreEmptyTokens omit empty tokens from the result array
     *                          (only applies to tokens that are empty after trimming; StringTokenizer
     *                          will not consider subsequent delimiters as token in the first place).
     * @return an array of the tokens
     * @see java.util.StringTokenizer
     * @see String#trim()
     * @see #delimitedListToStringArray
     */
    public static String[] tokenizeToStringArray(String str, String delimiters, boolean trimTokens, boolean ignoreEmptyTokens) {

        if (str == null) {
            return EMPTY_STRING_ARRAY;
        }

        StringTokenizer st = new StringTokenizer(str, delimiters);
        List<String> tokens = new ArrayList<>();
        while (st.hasMoreTokens()) {
            String token = st.nextToken();
            if (trimTokens) {
                token = token.trim();
            }
            if (!ignoreEmptyTokens || !token.isEmpty()) {
                tokens.add(token);
            }
        }
        return toStringArray(tokens);
    }

    /**
     * Take a {@code String} that is a delimited list and convert it into a
     * {@code String} array.
     * <p>A single {@code delimiter} may consist of more than one character,
     * but it will still be considered as a single delimiter string, rather
     * than as a bunch of potential delimiter characters, in contrast to
     * {@link #tokenizeToStringArray}.
     * @param str       the input {@code String} (potentially {@code null} or empty)
     * @param delimiter the delimiter between elements (this is a single delimiter,
     *                  rather than a bunch individual delimiter characters)
     * @return an array of the tokens in the list
     * @see #tokenizeToStringArray
     */
    public static String[] delimitedListToStringArray(String str, String delimiter) {
        return delimitedListToStringArray(str, delimiter, null);
    }

    /**
     * Take a {@code String} that is a delimited list and convert it into
     * a {@code String} array.
     * <p>A single {@code delimiter} may consist of more than one character,
     * but it will still be considered as a single delimiter string, rather
     * than as a bunch of potential delimiter characters, in contrast to
     * {@link #tokenizeToStringArray}.
     * @param str           the input {@code String} (potentially {@code null} or empty)
     * @param delimiter     the delimiter between elements (this is a single delimiter,
     *                      rather than a bunch individual delimiter characters)
     * @param charsToDelete a set of characters to delete; useful for deleting unwanted
     *                      line breaks: e.g. "\r\n\f" will delete all new lines and line feeds in a {@code String}
     * @return an array of the tokens in the list
     * @see #tokenizeToStringArray
     */
    public static String[] delimitedListToStringArray(String str, String delimiter, String charsToDelete) {

        if (str == null) {
            return EMPTY_STRING_ARRAY;
        }
        if (delimiter == null) {
            return new String[]{str};
        }

        List<String> result = new ArrayList<>();
        if (delimiter.isEmpty()) {
            for (int i = 0; i < str.length(); i++) {
                result.add(deleteAny(str.substring(i, i + 1), charsToDelete));
            }
        } else {
            int pos = 0;
            int delPos;
            while ((delPos = str.indexOf(delimiter, pos)) != -1) {
                result.add(deleteAny(str.substring(pos, delPos), charsToDelete));
                pos = delPos + delimiter.length();
            }
            if (!str.isEmpty() && pos <= str.length()) {
                // Add rest of String, but not in case of empty input.
                result.add(deleteAny(str.substring(pos), charsToDelete));
            }
        }
        return toStringArray(result);
    }

    /**
     * Convert a comma delimited list (e.g., a row from a CSV file) into an
     * array of strings.
     * @param str the input {@code String} (potentially {@code null} or empty)
     * @return an array of strings, or the empty array in case of empty input
     */
    public static String[] commaDelimitedListToStringArray(String str) {
        return delimitedListToStringArray(str, ",");
    }

    /**
     * Convert a comma delimited list (e.g., a row from a CSV file) into a set.
     * <p>Note that this will suppress duplicates, and as of 4.2, the elements in
     * the returned set will preserve the original order in a {@link LinkedHashSet}.
     * @param str the input {@code String} (potentially {@code null} or empty)
     * @return a set of {@code String} entries in the list
     * @see #removeDuplicateStrings(String[])
     */
    public static Set<String> commaDelimitedListToSet(String str) {
        String[] tokens = commaDelimitedListToStringArray(str);
        return new LinkedHashSet<>(Arrays.asList(tokens));
    }

    /**
     * Convert a {@link Collection} to a delimited {@code String} (e.g. CSV).
     * <p>Useful for {@code toString()} implementations.
     * @param coll   the {@code Collection} to convert (potentially {@code null} or empty)
     * @param delim  the delimiter to use (typically a ",")
     * @param prefix the {@code String} to start each element with
     * @param suffix the {@code String} to end each element with
     * @return the delimited {@code String}
     */
    public static String collectionToDelimitedString(Collection<?> coll, String delim, String prefix, String suffix) {

        if (CollectionUtils.isEmpty(coll)) {
            return "";
        }

        int totalLength = coll.size() * (prefix.length() + suffix.length()) + (coll.size() - 1) * delim.length();
        for (Object element : coll) {
            totalLength += String.valueOf(element).length();
        }

        StringBuilder sb = new StringBuilder(totalLength);
        Iterator<?> it = coll.iterator();
        while (it.hasNext()) {
            sb.append(prefix).append(it.next()).append(suffix);
            if (it.hasNext()) {
                sb.append(delim);
            }
        }
        return sb.toString();
    }

    /**
     * Convert a {@code Collection} into a delimited {@code String} (e.g. CSV).
     * <p>Useful for {@code toString()} implementations.
     * @param coll  the {@code Collection} to convert (potentially {@code null} or empty)
     * @param delim the delimiter to use (typically a ",")
     * @return the delimited {@code String}
     */
    public static String collectionToDelimitedString(Collection<?> coll, String delim) {
        return collectionToDelimitedString(coll, delim, "", "");
    }

    /**
     * Convert a {@code Collection} into a delimited {@code String} (e.g., CSV).
     * <p>Useful for {@code toString()} implementations.
     * @param coll the {@code Collection} to convert (potentially {@code null} or empty)
     * @return the delimited {@code String}
     */
    public static String collectionToCommaDelimitedString(Collection<?> coll) {
        return collectionToDelimitedString(coll, ",");
    }

    /**
     * Convert a {@code String} array into a delimited {@code String} (e.g. CSV).
     * <p>Useful for {@code toString()} implementations.
     * @param arr   the array to display (potentially {@code null} or empty)
     * @param delim the delimiter to use (typically a ",")
     * @return the delimited {@code String}
     */
    public static String arrayToDelimitedString(Object[] arr, String delim) {
        if (ObjectUtils.isEmpty(arr)) {
            return "";
        }
        if (arr.length == 1) {
            return ObjectUtils.nullSafeToString(arr[0]);
        }

        StringJoiner sj = new StringJoiner(delim);
        for (Object elem : arr) {
            sj.add(String.valueOf(elem));
        }
        return sj.toString();
    }

    /**
     * Convert a {@code String} array into a comma delimited {@code String}
     * (i.e., CSV).
     * <p>Useful for {@code toString()} implementations.
     * @param arr the array to display (potentially {@code null} or empty)
     * @return the delimited {@code String}
     */
    public static String arrayToCommaDelimitedString(Object[] arr) {
        return arrayToDelimitedString(arr, ",");
    }

    /**
     * 是否不为空
     * @param str 字符串
     * @return 是否不为空
     */
    public static boolean isNotBlank(String str) {
        return hasText(str);
    }

    /**
     * 比较两个字符串是否相等，规则如下
     * <ul>
     *     <li>str1和str2都为{@code null}</li>
     *     <li>忽略大小写使用{@link String#equalsIgnoreCase(String)}判断相等</li>
     *     <li>不忽略大小写使用{@link String#contentEquals(CharSequence)}判断相等</li>
     * </ul>
     * @param str1       要比较的字符串1
     * @param str2       要比较的字符串2
     * @param ignoreCase 是否忽略大小写
     * @return 如果两个字符串相同，或者都是{@code null}，则返回{@code true}
     * @since 3.2.0
     */
    public static boolean equals(CharSequence str1, CharSequence str2, boolean ignoreCase) {
        if (null == str1) {
            // 只有两个都为null才判断相等
            return str2 == null;
        }
        if (null == str2) {
            // 字符串2空，字符串1非空，直接false
            return false;
        }
        if (ignoreCase) {
            return str1.toString().equalsIgnoreCase(str2.toString());
        } else {
            return str1.toString().contentEquals(str2);
        }
    }

    public static boolean equalsAny(CharSequence str1, CharSequence... strs) {
        return equalsAny(str1, false, strs);
    }

    /**
     * 给定字符串是否与提供的中任一字符串相同，相同则返回{@code true}，没有相同的返回{@code false}<br>
     * 如果参与比对的字符串列表为空，返回{@code false}
     * @param str1       给定需要检查的字符串
     * @param ignoreCase 是否忽略大小写
     * @param strs       需要参与比对的字符串列表
     * @return 是否相同
     * @since 4.3.2
     */
    public static boolean equalsAny(CharSequence str1, boolean ignoreCase, CharSequence... strs) {
        if (strs == null) {
            return false;
        }
        for (CharSequence str : strs) {
            if (equals(str1, str, ignoreCase)) {
                return true;
            }
        }
        return false;
    }


    /**
     * 大写首字母<br>
     * 例如：str = name, return Name
     * @param str 字符串
     * @return 字符串
     */
    public static String upperFirst(CharSequence str) {
        if (null == str) {
            return null;
        }
        if (!str.isEmpty()) {
            char firstChar = str.charAt(0);
            if (Character.isLowerCase(firstChar)) {
                return Character.toUpperCase(firstChar) + substring(str, 1, str.length());
            }
        }
        return str.toString();
    }

    public static String substring(CharSequence str, int from) {
        return substring(str, from, str.length());
    }

    /**
     * 改进JDK subString<br>
     * index从0开始计算，最后一个字符为-1<br>
     * 如果from和to位置一样，返回 "" <br>
     * 如果from或to为负数，则按照length从后向前数位置，如果绝对值大于字符串长度，则from归到0，to归到length<br>
     * 如果经过修正的index中from大于to，则互换from和to example: <br>
     * abcdefgh 2 3 =》 c <br>
     * abcdefgh 2 -3 =》 cde <br>
     * @param str              String
     * @param fromIndexInclude 开始的index（包括）
     * @param toIndexExclude   结束的index（不包括）
     * @return 字串
     */
    public static String substring(CharSequence str, int fromIndexInclude, int toIndexExclude) {
        if (isEmpty(str)) {
            return str(str);
        }
        int len = str.length();

        if (fromIndexInclude < 0) {
            fromIndexInclude = len + fromIndexInclude;
            if (fromIndexInclude < 0) {
                fromIndexInclude = 0;
            }
        } else if (fromIndexInclude > len) {
            fromIndexInclude = len;
        }

        if (toIndexExclude < 0) {
            toIndexExclude = len + toIndexExclude;
            if (toIndexExclude < 0) {
                toIndexExclude = len;
            }
        } else if (toIndexExclude > len) {
            toIndexExclude = len;
        }

        if (toIndexExclude < fromIndexInclude) {
            int tmp = fromIndexInclude;
            fromIndexInclude = toIndexExclude;
            toIndexExclude = tmp;
        }

        if (fromIndexInclude == toIndexExclude) {
            return EMPTY;
        }
        return str.toString().substring(fromIndexInclude, toIndexExclude);
    }

    /**
     * {@link CharSequence} 转为字符串，null安全
     * @param cs {@link CharSequence}
     * @return 字符串
     */
    public static String str(CharSequence cs) {
        return null == cs ? null : cs.toString();
    }

    /**
     * 字符串是否以给定字符结尾
     * @param str 字符串
     * @param c   字符
     * @return 是否结尾
     */
    public static boolean endWith(CharSequence str, char c) {
        if (isEmpty(str)) {
            return false;
        }
        return c == str.charAt(str.length() - 1);
    }

    /**
     * 截取分隔字符串之后的字符串，不包括分隔字符串<br>
     * 如果给定的字符串为空串（null或""），返回原字符串<br>
     * 如果分隔字符串为空串（null或""），则返回空串，如果分隔字符串未找到，返回空串，举例如下：
     *
     * <pre>
     * StrUtil.subAfter(null, *, false)      = null
     * StrUtil.subAfter("", *, false)        = ""
     * StrUtil.subAfter(*, null, false)      = ""
     * StrUtil.subAfter("abc", "a", false)   = "bc"
     * StrUtil.subAfter("abcba", "b", false) = "cba"
     * StrUtil.subAfter("abc", "c", false)   = ""
     * StrUtil.subAfter("abc", "d", false)   = ""
     * StrUtil.subAfter("abc", "", false)    = "abc"
     * </pre>
     * @param string          被查找的字符串
     * @param separator       分隔字符串（不包括）
     * @param isLastSeparator 是否查找最后一个分隔字符串（多次出现分隔字符串时选取最后一个），true为选取最后一个
     * @return 切割后的字符串
     * @since 3.1.1
     */
    public static String subAfter(CharSequence string, CharSequence separator, boolean isLastSeparator) {
        if (isEmpty(string)) {
            return null == string ? null : EMPTY;
        }
        if (separator == null) {
            return EMPTY;
        }
        final String str = string.toString();
        final String sep = separator.toString();
        final int pos = isLastSeparator ? str.lastIndexOf(sep) : str.indexOf(sep);
        if (INDEX_NOT_FOUND == pos || (string.length() - 1) == pos) {
            return EMPTY;
        }
        return str.substring(pos + separator.length());
    }

    /**
     * 去掉指定前缀
     * @param str    字符串
     * @param prefix 前缀
     * @return 切掉后的字符串，若前缀不是 preffix， 返回原字符串
     */
    public static String removePrefix(CharSequence str, CharSequence prefix) {
        if (isEmpty(str) || isEmpty(prefix)) {
            return str(str);
        }

        final String str2 = str.toString();
        if (str2.startsWith(prefix.toString())) {
            return subSuf(str2, prefix.length());// 截取后半段
        }
        return str2;
    }

    /**
     * 切割指定位置之后部分的字符串
     * @param string    字符串
     * @param fromIndex 切割开始的位置（包括）
     * @return 切割后后剩余的后半部分字符串
     */
    public static String subSuf(CharSequence string, int fromIndex) {
        if (isEmpty(string)) {
            return null;
        }
        return sub(string, fromIndex, string.length());
    }


    /**
     * 去掉指定后缀
     * @param str    字符串
     * @param suffix 后缀
     * @return 切掉后的字符串，若后缀不是 suffix， 返回原字符串
     */
    public static String removeSuffix(CharSequence str, CharSequence suffix) {
        if (isEmpty(str) || isEmpty(suffix)) {
            return str(str);
        }

        final String str2 = str.toString();
        if (str2.endsWith(suffix.toString())) {
            return subPre(str2, str2.length() - suffix.length());// 截取前半段
        }
        return str2;
    }

    /**
     * 切割指定位置之前部分的字符串
     * @param string         字符串
     * @param toIndexExclude 切割到的位置（不包括）
     * @return 切割后的剩余的前半部分字符串
     */
    public static String subPre(CharSequence string, int toIndexExclude) {
        return sub(string, 0, toIndexExclude);
    }
}