import http from "@/utils/http";

/**
 * 查询数据类型列表
 * @param pageIndex 当前页
 * @param pageSize 每页大小
 */
export const apiListDataTypes = (pageIndex: Number, pageSize: Number, param: any) => {
  return http.get("/api/datatype/page", {
    pageIndex: pageIndex,
    pageSize: pageSize
  });
};

/**
 * @returns 
 */
export const apiListAllDataTypeGroups = () => {
  return http.get("/api/datatype/groups");
};

/**
 * @returns 
 */
export const apiSaveDataTypeGroup = (group: any) => {
  console.log(group);
  
  return http.postJson("/api/datatype/group/add", {
    groupId: group.typeGroupId,
    groupName: group.typeGroupName
  });
};