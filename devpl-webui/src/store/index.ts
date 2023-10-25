import { defineStore } from "pinia";

//第一个参数为id，如果不再此处写id，可在配置选项中写id，总之id是必须的，而且是唯一的
export const appStore = defineStore("appStore", {
  id: "appStore", //该 id 是必要的，主要是用于 vue devtools
  state: () => ({
    ms: "https://www.baidu.com/"
  })
});
