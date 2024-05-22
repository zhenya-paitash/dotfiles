import options from "@options"
import {
  AppStoreInterface,
  BaseStoreInterface,
  BaseStoreConfig,
  BaseToggleStoreInterface,
  BaseToggleStoreConfig,

  VolumeOverlayStoreInterface,
  BrightnessOverlayStoreInterface,
  PlayerStoreInterface,
  AppLauncherStoreInterface,
  NotificationsStoreInterface,
  BarBatteryStoreInterface,
} from "./store.interface";

import brightness from '@/services/brightness.service'
const audio = await Service.import('audio');
const { query } = await Service.import('applications');
const notifications = await Service.import('notifications');


class AppStore implements AppStoreInterface {
  volumeOverlayStore: VolumeOverlayStoreInterface;
  brightnessOverlayStore: BrightnessOverlayStoreInterface;
  playerStore: PlayerStoreInterface;
  appLauncherStore: AppLauncherStore;
  notificationsStore: NotificationsStoreInterface;

  constructor() {
    this.volumeOverlayStore = new VolumeOverlayStore();
    this.brightnessOverlayStore = new BrightnessOverlayStore();
    this.playerStore = new PlayerStore();
    this.appLauncherStore = new AppLauncherStore();
    this.notificationsStore = new NotificationsStore();
  }
}

class BaseStore implements BaseStoreInterface {
  isVisible: BaseStoreInterface['isVisible'];
  timeout: BaseStoreInterface['timeout'];
  timeout_duration: BaseStoreInterface['timeout_duration'];

  constructor(config: BaseStoreConfig = {}) {
    this.isVisible = Variable(config.isVisible ?? false);
    this.timeout = config.timeout;
    this.timeout_duration = config.timeout_duration ?? 1_000;
  }

  get visible(): boolean {
    return this.isVisible.value;
  }

  clear_timeout(): this {
    if (this.timeout) clearTimeout(this.timeout);
    return this;
  }

  sleep(ms: number = this.timeout_duration): Promise<this> {
    return new Promise(resolve => setTimeout(() => resolve(this), ms));
  }
}

class BaseToggleStore extends BaseStore implements BaseToggleStoreInterface {
  isVisibleContent: BaseToggleStoreInterface['isVisibleContent'];
  isLock: BaseToggleStoreInterface['isLock'];

  constructor(config: BaseToggleStoreConfig = {}) {
    config.timeout_duration = config.timeout_duration ?? 300;
    super(config);

    this.isVisibleContent = Variable(config.isVisibleContent ?? false);
    this.isLock = Variable(config.isLock ?? false);
  }

  get visible_content(): boolean {
    return this.isVisibleContent.value;
  }

  get lock(): boolean {
    return this.isLock.value;
  }

  async open(): Promise<void> {
    if (this.lock) return;
    this.isLock.setValue(true);
    this.isVisible.setValue(true);
    await this.sleep(this.timeout_duration);
    this.isVisibleContent.setValue(true);
    this.isLock.setValue(false);
  }

  async close(): Promise<void> {
    if (this.lock) return;
    this.isLock.setValue(true);
    this.isVisibleContent.setValue(false);
    await this.sleep(this.timeout_duration);
    this.isVisible.setValue(false);
    this.isLock.setValue(false);
  }

  async toggle(): Promise<void> {
    return this.visible_content ? this.close() : this.open();
  }
}

class VolumeOverlayStore extends BaseStore implements VolumeOverlayStoreInterface {
  audio = Variable({ volume: -1, mute: false });
  #isInit: boolean = true;

  constructor() {
    super();
    audio.speaker.connect('changed', ({ volume, stream }) => {
      const mute: boolean = stream?.is_muted ?? this.audio.value.mute;
      // disable init show widget
      if (this.#isInit) {
        this.audio.setValue({ volume, mute });
        this.#isInit = false;
        return;
      }

      if (mute === this.audio.value.mute && volume === this.audio.value.volume) return;

      this.isVisible.setValue(true);
      this.audio.setValue({ volume, mute });
      if (this.timeout) clearTimeout(this.timeout);
      this.timeout = setTimeout(() => {
        this.isVisible.setValue(false);
      }, this.timeout_duration);
    });
  }
}

class BrightnessOverlayStore extends BaseStore implements BrightnessOverlayStoreInterface {
  brightness = Variable<number>(brightness.screen_value);

  constructor() {
    super();
    brightness.connect('changed', ({ screen_value }) => {
      if (screen_value === this.brightness.value) return;

      this.brightness.setValue(screen_value);
      this.isVisible.setValue(true);
      if (this.timeout) clearTimeout(this.timeout);
      this.timeout = setTimeout(() => {
        this.isVisible.setValue(false);
      }, this.timeout_duration);
    });
  }
}

class PlayerStore extends BaseToggleStore implements PlayerStoreInterface {
  constructor(config: BaseToggleStoreConfig = {}) {
    super(config);
  }
}

class AppLauncherStore extends BaseToggleStore implements AppLauncherStoreInterface {
  applications: AppLauncherStoreInterface['applications'];
  search: AppLauncherStoreInterface['search'];
  bg_image: AppLauncherStoreInterface['bg_image'];
  use_bg_image: AppLauncherStoreInterface['use_bg_image'];

  constructor(config: BaseToggleStoreConfig = {}) {
    super(config);
    this.applications = Variable(query(""));
    this.search = Variable("");
    this.bg_image = Variable("");
    this.use_bg_image = options.variables.AGS_COMPILE_SRC_APPLAUNCHER_BG;
  }

  // переопределение open
  async open(): Promise<void> {
    if (this.lock) return;
    this.search.setValue("");
    this.getApplications();
    this.asyncCheckNewBgImage();
    super.open();
  }

  async close(): Promise<void> {
    this.search.setValue("");
    super.close();
  }

  private async asyncCheckNewBgImage() {
    try {
      const currentWallpaper = await Utils.execAsync(`sh -c "swww query | head -1 | awk -F 'image: ' '{print $2}'"`);
      if (this.bg_image.value === currentWallpaper) return;

      await Utils.execAsync(`convert ${currentWallpaper} -resize 256x256^ -gravity center -extent 256x256 -quality 80 ${this.use_bg_image}`);
      this.bg_image.setValue(currentWallpaper);
    } catch (err) {
      Utils.notify({
        summary: 'app-launcher error',
        body: err?.toString() || 'unknown error',
        iconName: 'applications-development',
        timeout: 10_000,
        urgency: 'critical',
      });
      console.error(err);
    }
  }

  private getApplications() {
    this.applications.setValue(query(""));
  }
}

class NotificationsStore implements NotificationsStoreInterface {
  notifications: NotificationsStoreInterface["notifications"] = notifications;
}

class BarBatteryStore extends BaseToggleStore implements BarBatteryStoreInterface {
  constructor(config: BaseToggleStoreConfig = {}) {
    super(config);
  }
}


export {
  BarBatteryStore,
}

const store = new AppStore();
export const volumeOverlayStore = store.volumeOverlayStore;
export const brightnessOverlayStore = store.brightnessOverlayStore;
export const playerStore = store.playerStore;
export const appLauncherStore = store.appLauncherStore;
export const notificationsStore = store.notificationsStore;

export default store;
globalThis.store = store;

