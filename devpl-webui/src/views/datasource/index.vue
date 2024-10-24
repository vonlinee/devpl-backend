<template>
  <el-card>
    <el-form :inline="true" :model="state.queryForm" @keyup.enter="getDataList()">
      <el-form-item>
        <el-input v-model="state.queryForm.connectionName" placeholder="连接名"></el-input>
      </el-form-item>
      <el-form-item prop="dbType">
        <el-select v-model="state.queryForm.dbType" clearable placeholder="数据库类型">
          <el-option v-for="dbType in supportedDbTypes" :key="dbType.id" :value="dbType.id"
            :label="dbType.name"></el-option>
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button @click="getDataList()">查询</el-button>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="addOrUpdateHandle()">新增</el-button>
      </el-form-item>
      <el-form-item>
        <el-button type="danger" @click="deleteBatchHandle()">删除</el-button>
      </el-form-item>
    </el-form>
    <el-table v-loading="state.dataListLoading" :data="state.dataList" border style="width: 100%"
      @selection-change="selectionChangeHandle">
      <el-table-column type="selection" header-align="center" align="center" width="50"></el-table-column>
      <el-table-column prop="connectionName" label="连接名" header-align="center" align="center"></el-table-column>
      <el-table-column prop="driverType" label="驱动类型" header-align="center" align="center"></el-table-column>
      <el-table-column prop="connectionUrl" label="数据库URL" show-overflow-tooltip header-align="center"
        align="center"></el-table-column>
      <el-table-column prop="username" label="用户名" header-align="center" align="center"></el-table-column>
      <el-table-column label="密码" header-align="center" align="center">
        <template #default="scope">
          <span>{{ formatPassword(scope.row.password) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" fixed="right" header-align="center" align="center" width="170">
        <template #default="scope">
          <el-button type="primary" link @click="datasourceHandle(scope.row.id)">测试</el-button>
          <el-button type="primary" link @click="addOrUpdateHandle(scope.row.id)">编辑</el-button>
          <el-button type="primary" link @click="deleteBatchHandle(scope.row.id)">删除</el-button>
        </template>
      </el-table-column>
    </el-table>
    <el-pagination :current-page="state.page" :page-sizes="state.pageSizes" :page-size="state.limit" :total="state.total"
      layout="total, sizes, prev, pager, next, jumper" @size-change="sizeChangeHandle"
      @current-change="currentChangeHandle">
    </el-pagination>

    <!-- 弹窗, 新增 / 修改 -->
    <add-or-update ref="addOrUpdateRef" @refresh-data-list="getDataList"></add-or-update>
  </el-card>
</template>

<script setup lang="ts">
import { onMounted, reactive, ref } from "vue"
import { DataTableOption } from "@/hooks/interface"
import {
  apiListDataSource,
  apiListSupportedDbTypes,
  apiRemoveDataSourceByIds,
  useDataSourceTestApi,
} from "@/api/datasource"
import { useCrud } from "@/hooks"
import { ElButton } from "element-plus"
import AddOrUpdate from "./add-or-update.vue"
import { decrypt } from "@/utils/tool"
import { DriverTypeVO } from "./types"
import { Message } from "@/hooks/message"

const state: DataTableOption = reactive({
  dataListUrl: "/api/datasource/page",
  deleteUrl: "/api/datasource",
  queryForm: {
    connectionName: "",
    dbType: "",
  },
  queryPage: apiListDataSource,
  removeByIds: apiRemoveDataSourceByIds,
})

const supportedDbTypes = ref<DriverTypeVO[]>([])

onMounted(() => {
  apiListSupportedDbTypes().then((res) => {
    supportedDbTypes.value = res.data
  })
})

const datasourceHandle = (id: number) => {
  useDataSourceTestApi(id).then((res) => {
    if (!res.data?.failed) {
      Message.info("连接成功")
    } else {
      Message.error(res.data.errorMsg)
    }
  })
}

const addOrUpdateRef = ref()
const addOrUpdateHandle = (id?: number) => {
  addOrUpdateRef.value.init(id)
}

const {
  getDataList,
  selectionChangeHandle,
  sizeChangeHandle,
  currentChangeHandle,
  deleteBatchHandle,
} = useCrud(state)

const formatPassword = (str: string): string => {
  return Array(decrypt(str).length).fill("•").join("")
}
</script>
