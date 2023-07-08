package io.devpl.generator.controller;

import io.devpl.generator.common.PageQuery;
import io.devpl.generator.common.page.PageResult;
import io.devpl.generator.common.utils.Result;
import io.devpl.generator.entity.TemplateInfo;
import io.devpl.generator.service.TemplateService;
import io.devpl.generator.utils.BusinessUtils;
import io.devpl.sdk.collection.CollectionUtils;
import io.devpl.sdk.validation.Assert;
import jakarta.annotation.Resource;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

/**
 * 模板管理控制器
 */
@RestController
@RequestMapping(value = "/api/template")
public class TemplateController {

    @Resource
    TemplateService templateService;

    /**
     * 新增模板
     * @param templateInfo 模板信息
     * @return 是否成功
     */
    @PostMapping(value = "/save")
    public Result<Boolean> addOne(@RequestBody TemplateInfo templateInfo) {
        Assert.notNull(templateInfo.getType(), "模板类型为空");
        Assert.isTrue(templateInfo.getType() == 1 || templateInfo.getType() == 2, "模板类型参数错误");
        if (templateInfo.getType() == 1) {
            Assert.hasText(templateInfo.getTemplatePath(), "文件路径不能为空");
        } else {
            Assert.hasText(templateInfo.getContent(), "模板内容不能为空");
        }
        return Result.ok(templateService.save(templateInfo));
    }

    /**
     * 根据ID更新
     * @param templateInfo 模板信息
     * @return 是否成功
     */
    @PutMapping(value = "/update")
    public Result<Boolean> update(@RequestBody TemplateInfo templateInfo) {
        Assert.notNull(templateInfo.getTemplateId(), "模板ID为空");
        Assert.notNull(templateInfo.getType(), "模板类型为空");
        Assert.isTrue(templateInfo.getType() == 1 || templateInfo.getType() == 2, "模板类型参数错误");
        if (templateInfo.getType() == 1) {
            Assert.hasText(templateInfo.getTemplatePath(), "文件路径不能为空");
        } else {
            Assert.hasText(templateInfo.getContent(), "模板内容不能为空");
        }
        return Result.ok(templateService.updateById(templateInfo));
    }

    /**
     * 根据ID删除模板
     * @param id 模板ID
     * @return 是否成功
     */
    @DeleteMapping(value = "/delete/{id}")
    public Result<Boolean> removeById(@PathVariable(value = "id") Integer id) {
        return Result.ok(templateService.removeById(id));
    }

    /**
     * 根据ID批量删除模板
     * @param templateIds 模板ID
     * @return 是否成功
     */
    @DeleteMapping(value = "/delete/batch/ids")
    public Result<Boolean> removeBatchByIds(@RequestBody List<Integer> templateIds) {
        Assert.notEmpty(templateIds, "参数为空");
        Assert.notEmpty(templateIds.stream().filter(Objects::nonNull).collect(Collectors.toList()), "参数为空");
        return Result.ok(templateService.removeByIds(templateIds));
    }

    /**
     * 分页查询列表
     * @return 列表
     */
    @GetMapping(value = "/page")
    public Result<PageResult<TemplateInfo>> list(PageQuery query) {
        return Result.ok(BusinessUtils.page2List(templateService.pages(query.getPageIndex(), query.getPageSize())));
    }
}
