import options from "@options"
import AppUtils from "@/lib/utils"
import {
  Bar,
  Notifications,
  VolumeOverlay,
  BrightnessOverlay,
  AppLauncher,
  Player,
  WidgetClock,
} from "@widgets";

AppUtils
  .prebuild()
  .watchStyles()
  .buildStyles();

App.config({
  style: options.variables.AGS_COMPILE_GEN_CSS,
  icons: options.variables.AGS_COMPILE_SRC_DIR,
  windows: [
    Bar(),
    Notifications(),
    VolumeOverlay(),
    BrightnessOverlay(),
    AppLauncher(),
    Player(),
    WidgetClock(),
  ],
  closeWindowDelay: {},
  onConfigParsed() { print("[MAIN]: “It’s alive!” © AGS Frankenstein's monster"); },
  onWindowToggled(windowName: string, visible: boolean): void { },
});

