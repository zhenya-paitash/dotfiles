// import { Bar, Notifications, VolumeOverlay, BrightnessOverlay, AppLauncher, Player } from "@widgets"
// import { ApplyStyles, StylesWatcher } from "@/lib/utils";
// import options from "@/options";
//
// // StylesWatcher(options.style.src);
// ApplyStyles();
//
// const appConfig: Config = {
//   style: options.style.src.main,
//   icons: options.assets.src.folder,
//   windows: [
//     Bar(),
//     Notifications(),
//     VolumeOverlay(),
//     BrightnessOverlay(),
//     AppLauncher(),
//     Player(),
//   ],
//   closeWindowDelay: {},
//   onConfigParsed() { print("[config]: Welcome, friend.") },
//   onWindowToggled(windowName: string, visible: boolean): void { },
// };
//
// App.config(appConfig);

import options from "@options"
import AppUtils from "@/lib/utils"
import { Bar, Notifications, VolumeOverlay, BrightnessOverlay, AppLauncher, Player } from "@widgets";

AppUtils.prebuild();
AppUtils.watchStyles();
AppUtils.buildStyles();

App.config({
  style: `${options.variables.AGS_COMPILE_GEN_DIR}/style.css`,
  icons: `${options.variables.AGS_COMPILE_GEN_DIR}/assets`,

  windows: [
    Bar(),
    Notifications(),
    VolumeOverlay(),
    BrightnessOverlay(),
    AppLauncher(),
    Player(),
  ],

  closeWindowDelay: {},
  onConfigParsed() { print("[MAIN]: “It’s alive!” © AGS Frankenstein's monster"); },
  onWindowToggled(windowName: string, visible: boolean): void { },
});
