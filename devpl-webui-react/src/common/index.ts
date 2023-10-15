import { getLocalMenu, saveLocalMenu } from "@/utils";
import { getMenu } from "@/api";
import { MenuResponse } from "@/types";

let currentJob: Promise<MenuResponse> | null;

/**
 * 获取所有菜单列表
 */
export function getMenus() {
  if (currentJob) {
    return currentJob;
  }
  const job: Promise<MenuResponse> = new Promise((reslove) => {
    let localMenu = getLocalMenu();

    if (localMenu) {
      console.log("获取localMenu");
      return reslove(localMenu);
    }
    getMenu().then((result) => {
        saveLocalMenu(result);
        reslove(result);
      })
      .catch((err) => {
        reslove([]);
      });
  });
  currentJob = job;
  job.finally(() => {
    currentJob = null;
  });
  return job;
}
