package io.devpl.backend.common.exception;

import io.devpl.backend.common.query.Result;
import io.devpl.backend.common.query.StatusCode;
import io.devpl.codegen.jdbc.RuntimeSQLException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.validation.BindException;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.sql.SQLException;

/**
 * 全局异常处理器
 * 拦截其他可能出现的异常信息，避免将异常调用栈显示给前端
 *
 * @see BusinessException
 */
@Slf4j
@RestControllerAdvice
public class GlobalExceptionHandler {

    /**
     * 参数异常
     *
     * @param ex IllegalArgumentException
     * @return Result
     */
    @ExceptionHandler(value = IllegalArgumentException.class)
    @ResponseBody
    public Result<?> exceptionHandler(IllegalArgumentException ex) {
        log.error("", ex);
        return Result.exception(ex);
    }

    /**
     * 处理自定义异常
     */
    @ExceptionHandler(BusinessException.class)
    public Result<String> handleRenException(BusinessException ex) {
        log.error("", ex);
        return Result.error(ex.getCode(), ex.getMsg());
    }

    /**
     * SpringMVC参数绑定，Validator校验不正确
     */
    @ExceptionHandler(BindException.class)
    public Result<String> bindException(BindException ex) {
        FieldError fieldError = ex.getFieldError();
        assert fieldError != null;
        log.error("", ex);
        return Result.error(fieldError.getDefaultMessage());
    }

    /**
     * 其他异常
     *
     * @param ex 异常类
     * @return Result
     */
    @ExceptionHandler(Exception.class)
    public Result<String> handleException(Exception ex) {
        log.error("", ex);
        Result<String> result = Result.error(StatusCode.INTERNAL_SERVER_ERROR);
        result.setMsg(ex.getMessage());
        return result;
    }

    public static Throwable wrap(Throwable throwable) {
        if (throwable instanceof SQLException ex) {
            return RuntimeSQLException.wrap(ex);
        }
        return throwable;
    }
}
