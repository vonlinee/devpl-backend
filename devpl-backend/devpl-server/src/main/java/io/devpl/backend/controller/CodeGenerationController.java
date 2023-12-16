package io.devpl.backend.controller;

import io.devpl.backend.common.query.Result;
import io.devpl.backend.domain.FileNode;
import io.devpl.backend.domain.param.TableFileGenParam;
import io.devpl.backend.entity.TableFileGeneration;
import io.devpl.backend.entity.TargetGenerationFile;
import io.devpl.backend.service.*;
import io.devpl.sdk.validation.Assert;
import jakarta.annotation.Resource;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

/**
 * 代码生成控制器
 */
@RestController
@RequestMapping("/api/codegen")
public class CodeGenerationController {

    @Resource
    FileGenerationService fileGenService;
    @Resource
    TargetGenerationFileService targetGenFileService;
    @Resource
    TableFileGenerationService tableFileGenerationService;
    @Resource
    GeneratorConfigService generatorConfigService;

    /**
     * 生成代码（自定义目录）
     *
     * @param tableIds 数据库表ID
     * @return 所有生成的根目录
     */
    @PostMapping("/code")
    public Result<List<String>> generatorCode(@RequestBody Long[] tableIds) {
        // 生成代码
        List<String> rootDirs = new ArrayList<>(tableIds.length);
        for (Long tableId : tableIds) {
            rootDirs.add(fileGenService.generateForTable(tableId));
        }
        return Result.ok(rootDirs);
    }

    /**
     * 生成代码（自定义目录）
     *
     * @return 所有生成的根目录
     */
    @GetMapping("/config")
    public Result<String> getGeneratorConfig() {
        return Result.ok(generatorConfigService.getCodeGenConfigContent());
    }

    /**
     * 生成代码（自定义目录）
     *
     * @return 所有生成的根目录
     */
    @PostMapping("/config")
    public Result<Boolean> saveGeneratorConfig(String content) {
        return Result.ok(generatorConfigService.saveGeneratorConfig(content));
    }

    /**
     * 生成的文件类型列表
     *
     * @return 生成的文件列表
     */
    @GetMapping("/genfiles")
    public Result<List<TargetGenerationFile>> listGeneratedFileTypes() {
        return Result.ok(targetGenFileService.listGeneratedFileTypes());
    }

    /**
     * 修改和新增一条生成的文件类型列表
     *
     * @return 生成的文件列表
     */
    @PostMapping("/genfile")
    public Result<Boolean> saveOrUpdateOne(@RequestBody TargetGenerationFile param) {
        targetGenFileService.saveOrUpdate(param);
        return Result.ok(true);
    }

    /**
     * 保存或更新生成的文件类型列表
     * 不存在的删除，更新或新增
     *
     * @return 生成的文件列表
     */
    @PostMapping("/genfiles/replace")
    public Result<?> saveOrUpdateGeneratedFileTypes(@RequestBody List<TargetGenerationFile> files) {
        return Result.ok(targetGenFileService.saveOrUpdateBatch(files));
    }

    /**
     * 获取单个表需要生成哪些文件
     *
     * @param tableId 需要生活的表ID
     * @return 文件列表
     */
    @GetMapping("/genfiles/list")
    public Result<List<TableFileGeneration>> listFilesToBeGenerated(@RequestParam(name = "tableId") Long tableId) {
        return Result.ok(tableFileGenerationService.listByTableId(tableId));
    }

    /**
     * 修改单个表需要生成的文件信息
     *
     * @param param 单个表需要生成的文件信息
     * @return 文件列表
     */
    @PostMapping("/genfiles/config")
    public Result<Boolean> updateFilesToBeGenerated(@RequestBody TableFileGenParam param) {
        return Result.ok(tableFileGenerationService.updateFilesToBeGenerated(param));
    }

    /**
     * 保存或更新生成的文件类型列表
     * 不存在的删除，更新或新增
     *
     * @return 生成的文件列表
     */
    @DeleteMapping("/genfiles/replace")
    public Result<?> deleteGeneratedFileTypes(@RequestBody List<Integer> ids) {
        ids.removeIf(Objects::isNull);
        Assert.notEmpty(ids, "参数为空");
        return Result.ok(targetGenFileService.removeBatchByIds(ids));
    }

    /**
     * 获取生成结果的文件树
     *
     * @param rootPath 根路径
     * @return 该目录下的文件列表，树形结构
     */
    @GetMapping("/file-tree")
    public Result<List<FileNode>> get(String rootPath) {
        return Result.ok(fileGenService.getGeneratedFileTree(rootPath));
    }

    /**
     * 获取文件文本内容
     *
     * @param path 文件路径
     * @return 文本内容
     */
    @GetMapping("/file")
    public Result<String> getFileContent(String path) {
        return Result.ok(fileGenService.getFileContent(path));
    }
}