import { Config } from "types/app";

import { Bar, Notifications, VolumeOverlay, BrightnessOverlay, AppLauncher, Player } from "@widgets"
import { StylesWatcher } from "@/lib/utils";
import options from "@/options";

StylesWatcher(options.style.src);
// ApplyStyles();

const appConfig: Config = {
  style: options.style.src.main,
  icons: options.assets.src.folder,
  windows: [
    Bar(),
    Notifications(),
    VolumeOverlay(),
    BrightnessOverlay(),
    AppLauncher(),
    Player(),
  ],
  closeWindowDelay: {},
  onConfigParsed() { print("[config]: Welcome, friend.") },
  onWindowToggled(windowName: string, visible: boolean): void { },
};

App.config(appConfig);

