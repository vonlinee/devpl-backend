package io.devpl.backend.utils.expression;

import org.apache.ibatis.ognl.Ognl;
import org.apache.ibatis.ognl.OgnlException;

import java.util.Map;

@SuppressWarnings("unchecked")
public class OgnlEngine implements ExpressionEngine {

    @Override
    public <T> T eval(String expression, Map<String, Object> context, Class<T> resultType) {
        try {
            Object result = Ognl.getValue(expression, context);
            return (T) result;
        } catch (OgnlException e) {
            throw new RuntimeException(e);
        }
    }
}
