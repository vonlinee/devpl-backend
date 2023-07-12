package io.devpl.generator.controller;

import io.devpl.generator.common.page.PageResult;
import io.devpl.generator.common.query.Query;
import io.devpl.generator.common.utils.Result;
import io.devpl.generator.entity.GenBaseClass;
import io.devpl.generator.service.BaseClassService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.List;

/**
 * 基类管理
 */
@RestController
@RequestMapping("/gen/baseclass")
@AllArgsConstructor
public class BaseClassController {
    private final BaseClassService baseClassService;

    @GetMapping("/page")
    public Result<PageResult<GenBaseClass>> page(Query query) {
        PageResult<GenBaseClass> page = baseClassService.page(query);
        return Result.ok(page);
    }

    @GetMapping("/list")
    public Result<List<GenBaseClass>> list() {
        List<GenBaseClass> list = baseClassService.getList();
        return Result.ok(list);
    }

    @GetMapping("/{id}")
    public Result<GenBaseClass> get(@PathVariable("id") Long id) {
        GenBaseClass data = baseClassService.getById(id);
        return Result.ok(data);
    }

    @PostMapping
    public Result<String> save(@RequestBody GenBaseClass entity) {
        baseClassService.save(entity);
        return Result.ok();
    }

    @PutMapping
    public Result<String> update(@RequestBody GenBaseClass entity) {
        baseClassService.updateById(entity);
        return Result.ok();
    }

    @DeleteMapping
    public Result<String> delete(@RequestBody Long[] ids) {
        baseClassService.removeBatchByIds(Arrays.asList(ids));
        return Result.ok();
    }
}
