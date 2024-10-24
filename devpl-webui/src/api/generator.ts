import http from "@/utils/http"

/**
 * 生成代码（zip压缩包）
 * @param tableIds
 */
export const useDownloadApi = (tableIds: any[]): void => {
  location.href =
    import.meta.env.VITE_API_URL +
    "/api/codegen/download?tableIds=" +
    tableIds.join(",")
}

/**
 * 生成代码（自定义目录）
 * @param tableIds
 */
export const apiFileGenerate = (tableIds: any[]) => {
  return http.post<FileGenerationResult>("/api/codegen/file", {
    tableIds: tableIds,
  })
}

/**
 * 查询所有生成的文件类型
 */
export const apiListGenFiles = () => {
  return http.get("/api/codegen/genfiles")
}

/**
 * 查询所有生成的文件类型
 * @return boolean
 */
export const apiSaveOrUpdateGenFile = (genFile: TargetGenFile) => {
  return http.post("/api/codegen/genfile", genFile)
}

/**
 * 保存或更新生成文件类型
 * @param genFiles
 */
export const apiSaveOrUpdateGenFiles = (genFiles: TargetGenFile[]) => {
  return http.post("/api/codegen/genfiles/replace", genFiles)
}

/**
 * 查询生成文件列表
 * @param tableId
 */
export const apiListGenerationFiles = (tableId: number) => {
  return http.get<TableFileGeneration[]>("/api/codegen/genfiles/list", {
    tableId: tableId,
  })
}

/**
 * 保存或更新生成文件信息
 * @param tableId
 */
export const apiSaveOrUpdateGenerationFiles = (
  files: TableFileGeneration[]
) => {
  return http.post<TableFileGeneration[]>("/api/codegen/genfiles/config", {
    fileInfoList: files,
  })
}

/**
 * 保存或更新生成文件信息
 * @param tableId
 * @param files
 */
export const apiRemoveGenerationFiles = (
  tableId: number,
  files: TableFileGeneration[]
) => {
  return http.delete<TableFileGeneration[]>("/api/codegen/genfiles/remove", {
    tableId: tableId,
    fileInfoList: files,
  })
}

/**
 * 保存或更新生成文件配置
 * @param tableId
 * @param files
 */
export const apiSaveGenerationFileConfig = (
  tableId: number,
  files: TableFileGeneration[]
) => {
  return http.post<boolean>("/api/codegen/genfiles/config", {
    tableId: tableId,
    fileInfoList: files,
  })
}

/**
 * 删除生成文件类型
 * @param genFiles
 */
export const apiDeleteGenFiles = (genFiles: TargetGenFile[]) => {
  return http.delete(
    "/api/codegen/genfiles/replace",
    genFiles.map((file: TargetGenFile) => file.id)
  )
}

/**
 * 获取生成器配置
 * @return JSON字符串
 */
export const apiGetGeneratorConfig = () => {
  return http.get("/api/codegen/config")
}

/**
 * 生成代码（自定义目录）
 * @return JSON字符串
 */
export const apiSaveGeneratorConfig = (content: string) => {
  return http.post(
    "/api/codegen/config",
    {
      content: content,
    },
    { "Content-Type": "multipart/form-data" }
  )
}

/**
 * 生成JavaPojo类
 * @param param
 */
export const apiCodeGenJavaPojo = (param: any) => {
  return http.post<string>("/api/codegen/java/pojo", param)
}

/**
 * 获取示例文本
 */
export const apiGetSampleText = (name: string) => {
  return http.get("/api/codegen/sample/text", {
    name: name
  })
}
