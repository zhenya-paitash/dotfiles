import GLib from "types/@girs/glib-2.0/glib-2.0";
import { Application } from "types/service/applications";
import { Variable as TypeVariable } from "types/variable";

interface AppStoreInterface {
  volumeOverlayStore: VolumeOverlayStoreInterface;
  brightnessOverlayStore: BrightnessOverlayStoreInterface;
  playerStore: PlayerStoreInterface;
  appLauncherStore: AppLauncherStoreInterface;
}

interface BaseStoreInterface {
  isVisible: TypeVariable<boolean>;
  timeout: GLib.Source | undefined;
  timeout_duration: number;
  get visible(): boolean;
  clear_timeout: () => this;
  sleep: () => Promise<this>;
}

interface BaseStoreConfig {
  isVisible?: boolean;
  timeout?: BaseStoreInterface['timeout'];
  timeout_duration?: number;
}

interface BaseToggleStoreInterface extends BaseStoreInterface {
  isVisibleContent: TypeVariable<boolean>;
  isLock: TypeVariable<boolean>;
  get visible_content(): boolean;
  get lock(): boolean;
  open: () => Promise<void>;
  close: () => Promise<void>;
  toggle: () => Promise<void>;
}

interface BaseToggleStoreConfig extends BaseStoreConfig {
  isVisibleContent?: boolean;
  isLock?: boolean;
}

interface VolumeOverlayStoreInterface extends BaseStoreInterface {
  audio: TypeVariable<{ volume: number; mute: boolean }>;
}

interface BrightnessOverlayStoreInterface extends BaseStoreInterface {
  brightness: TypeVariable<number>;
}

interface PlayerStoreInterface extends BaseToggleStoreInterface { }

interface AppLauncherStoreInterface extends BaseToggleStoreInterface {
  applications: TypeVariable<Application[]>;
  search: TypeVariable<string>;
  bg_image: TypeVariable<string>;
  use_bg_image: string;
}

export {
  AppStoreInterface,
  BaseStoreInterface,
  BaseStoreConfig,
  BaseToggleStoreInterface,
  BaseToggleStoreConfig,
  VolumeOverlayStoreInterface,
  BrightnessOverlayStoreInterface,
  PlayerStoreInterface,
  AppLauncherStoreInterface,
}
