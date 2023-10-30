package io.devpl.generator.controller;

import io.devpl.generator.common.query.ListResult;
import io.devpl.generator.domain.param.Query;
import io.devpl.generator.common.query.Result;
import io.devpl.generator.utils.ServletUtils;
import io.devpl.generator.entity.ProjectModify;
import io.devpl.generator.service.ProjectModifyService;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.validation.Valid;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 项目名变更
 */
@RestController
@RequestMapping("/gen/project")
public class ProjectModifyController {

    @Resource
    ProjectModifyService projectModifyService;

    @GetMapping("/page")
    public ListResult<ProjectModify> page(@Valid Query query) {
        return projectModifyService.page(query);
    }

    @GetMapping("/{id}")
    public Result<ProjectModify> get(@PathVariable("id") Long id) {
        return Result.ok(projectModifyService.getById(id));
    }

    @PostMapping
    public Result<Boolean> save(@RequestBody ProjectModify entity) {
        return Result.ok(projectModifyService.save(entity));
    }

    @PutMapping
    public Result<Boolean> update(@RequestBody @Valid ProjectModify entity) {
        return Result.ok(projectModifyService.updateById(entity));
    }

    @DeleteMapping
    public Result<Boolean> delete(@RequestBody List<Long> idList) {
        return Result.ok(projectModifyService.removeByIds(idList));
    }

    /**
     * 源码下载
     */
    @GetMapping("download/{id}")
    public void download(@PathVariable("id") Long id, HttpServletResponse response) throws Exception {
        // 项目信息
        ProjectModify project = projectModifyService.getById(id);
        byte[] data = projectModifyService.download(project);
        ServletUtils.downloadFile(response, project.getModifyProjectName() + ".zip", data);
    }
}
