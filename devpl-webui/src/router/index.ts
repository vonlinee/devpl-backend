import {
  createRouter,
  createWebHashHistory,
  Router,
  RouteRecordRaw,
} from "vue-router"

// 菜单路由
export const menuRoutes: RouteRecordRaw[] = [
  {
    path: "/codegen",
    meta: {
      title: "代码生成器",
      icon: "icon-appstore",
    },
    children: [
      {
        path: "/codegen/generator",
        name: "Generator",
        component: () => import("../views/generator/index.vue"),
        meta: {
          title: "代码生成",
          icon: "icon-fire",
        },
      },
      {
        path: "/codegen/datasource",
        name: "DataSource",
        component: () => import("../views/datasource/index.vue"),
        meta: {
          title: "数据源管理",
          icon: "icon-database-fill",
        },
      },
      {
        path: "/codegen/datatype",
        name: "FieldType",
        component: () => import("../views/datatype/index.vue"),
        meta: {
          title: "类型系统",
          icon: "icon-menu",
        },
      },
      {
        path: "/codegen/base-class",
        name: "BaseClass",
        component: () => import("../views/base-class/index.vue"),
        meta: {
          title: "基类管理",
          icon: "icon-cluster",
        },
      },
      {
        path: "/codegen/project",
        name: "ProjectIndex",
        component: () => import("../views/project/index.vue"),
        meta: {
          title: "项目名变更",
          icon: "icon-edit-square",
        },
      },
      {
        path: "/tools/mybatis",
        name: "MyBatis 工具",
        component: () => import("@/views/mybatis/index.vue"),
        meta: {
          title: "MyBatis 工具",
          icon: "icon-edit-square",
          keepAlive: true,
        },
      },
      {
        path: "/test",
        name: "测试",
        component: () => import("@/views/test/index.vue"),
        meta: {
          title: "测试",
          icon: "icon-edit-square",
        },
      },
      {
        path: "/gen/files",
        name: "目标文件管理",
        component: () => import("@/views/generator/genfile/index.vue"),
        meta: {
          title: "目标文件管理",
          icon: "icon-menu",
        },
      },
      {
        path: "/filegen",
        name: "文件生成",
        component: () => import("@/views/generator/gen/index.vue"),
        meta: {
          title: "文件生成",
          icon: "icon-menu",
        },
      },
    ],
  },
  {
    path: "/template",
    meta: {
      title: "模板管理",
      icon: "icon-appstore",
    },
    component: () => import("@/views/template/index.vue"),
    children: [],
  },
  {
    path: "/fields",
    meta: {
      title: "字段管理",
      icon: "icon-appstore",
    },
    component: () => import("@/views/fields/index.vue"),
    children: [],
  },
  {
    path: "/scripts",
    meta: {
      title: "脚本管理",
      icon: "icon-appstore",
    },
    component: () => import("@/views/scripts/index.vue"),
    children: [],
  },
  {
    path: "/mocker",
    meta: {
      title: "Mock工具",
      icon: "icon-appstore",
    },
    component: () => import("@/views/mocker/index.vue"),
    children: [
      {
        path: "/mocker/database",
        name: "数据库",
        component: () => import("../views/mocker/database/index.vue"),
        meta: {
          title: "数据库",
          icon: "icon-fire",
        },
      },
    ],
  },
]

/**
 * 默认路由
 */
export const constantRoutes: RouteRecordRaw[] = [
  {
    path: "/redirect",
    component: () => import("../layout/index.vue"),
    children: [
      {
        path: "/redirect/:path(.*)",
        component: () => import("../layout/components/Router/Redirect.vue"),
      },
    ],
  },
  {
    path: "/",
    component: () => import("../layout/index.vue"),
    redirect: "/gen/generator",
    children: [...menuRoutes],
  },
  {
    path: "/404",
    component: () => import("../views/404.vue"),
  },
  {
    path: "/:pathMatch(.*)",
    redirect: "/404",
  },
]

export const router: Router = createRouter({
  history: createWebHashHistory(),
  routes: constantRoutes,
})
