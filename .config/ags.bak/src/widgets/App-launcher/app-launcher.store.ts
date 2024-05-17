import GLib from "types/@girs/glib-2.0/glib-2.0";
import { Application } from "types/service/applications";

const { query } = await Service.import('applications');

import { AppLauncherStoreInterface } from "./app-launcher.interface";
import options from "@/options";

export class AppLauncherStore implements AppLauncherStoreInterface {
  search = Variable("");
  applications = Variable<Application[]>([]);
  show = Variable<boolean>(false);
  show_apps = Variable<boolean>(false);
  bg_image = Variable<string>("");
  use_bg_image: string = options.widget.applauncher.bg_image;
  #lock = Variable<boolean>(false);
  #timeout: GLib.Source | null = null;
  #timeout_duration: number = 300;

  constructor() {
    this.getApplications();
    this.asyncCheckNewBgImage()
  }

  open(): void {
    if (this.#lock.value) return;
    this.search.setValue("");
    this.getApplications();

    this.asyncCheckNewBgImage()
    this.#lock.setValue(true);
    this.show.setValue(true);
    this.clear_timeout().#timeout = setTimeout(() => {
      this.show_apps.setValue(true);
      this.#lock.setValue(false);
    }, this.#timeout_duration);
  }

  close(): void {
    if (this.#lock.value) return;

    this.#lock.setValue(true);
    this.show_apps.setValue(false);
    this.clear_timeout().#timeout = setTimeout(() => {
      this.show.setValue(false);
      this.#lock.setValue(false);
    }, this.#timeout_duration);
  }

  toggle(): void {
    this.show.value ? this.close() : this.open();
  }

  private async asyncCheckNewBgImage() {
    try {
      // const currentWallpaper = await Utils.execAsync(`sh -c "cat $HOME/.cache/swww/${monitorName}"`);
      const currentWallpaper = await Utils.execAsync(`sh -c "swww query | head -1 | awk -F 'image: ' '{print $2}'"`);
      if (this.bg_image.value === currentWallpaper) return;

      await Utils.execAsync(`convert ${currentWallpaper} -resize 256x256^ -gravity center -extent 256x256 -quality 80 ${this.use_bg_image}`);
      this.bg_image.setValue(currentWallpaper);
    } catch (err) {
      Utils.notify({
        summary: 'app-launcher error',
        body: err?.toString() || 'unknown error',
        iconName: 'applications-development',
        timeout: 10000,
        urgency: 'critical',
      });
      console.error(err);
    }
  }

  private getApplications() {
    // this.search.setValue("");
    this.applications.setValue(query(""));
  }

  private clear_timeout(): AppLauncherStore {
    if (this.#timeout) clearTimeout(this.#timeout);
    return this;
  }
}

const store = new AppLauncherStore();

export default store;
globalThis.applauncher = () => store.toggle();

