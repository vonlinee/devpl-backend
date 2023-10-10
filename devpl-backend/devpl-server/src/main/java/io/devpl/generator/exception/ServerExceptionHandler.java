package io.devpl.generator.exception;

import io.devpl.generator.common.exception.ServerException;
import io.devpl.generator.common.exception.StatusCode;
import io.devpl.generator.common.utils.Result;
import lombok.extern.slf4j.Slf4j;
import org.springframework.validation.BindException;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestControllerAdvice;

/**
 * 异常处理器
 */
@Slf4j
@RestControllerAdvice
public class ServerExceptionHandler {

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
    @ExceptionHandler(ServerException.class)
    public Result<String> handleRenException(ServerException ex) {
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
}
