package io.devpl.backend.tools.mybatis;

import org.apache.ibatis.ognl.Ognl;
import org.apache.ibatis.ognl.OgnlException;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;

@SuppressWarnings("unchecked")
public class LiteralValue {

    /**
     * 字符串列表: {'tom','jerry','jack','rose'}
     *
     * @param literal 字面量
     * @param <T>
     * @return
     */
    public static <T> List<T> get(String literal) {
        try {
            return (List<T>) Ognl.getValue(literal, new HashMap<>(), List.class);
        } catch (OgnlException e) {
            e.printStackTrace();
        }
        return new ArrayList<>();
    }

    public static Object getValue(String expression) {
        try {
            return Ognl.getValue(expression, Collections.emptyMap());
        } catch (OgnlException exception) {
            throw new RuntimeException(exception);
        }
    }

    public static void main(String[] args) throws OgnlException {
        List<Object> list = get("{'tom','jerry','jack','rose'}");
        Object value = Ognl.getValue("{'tom','jerry','jack','rose'}", new HashMap<>());
        Object value1 = Ognl.getValue("{1,2,3}", new HashMap<>());
        Object value2 = Ognl.getValue("{1.0, 2.0, 3.0}", new HashMap<>());
        System.out.println(value);
    }
}
