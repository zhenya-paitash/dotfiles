// //////////////////////////////
//   options
//     ├── variables
//     ╰── style
// //////////////////////////////
interface AppOptions {
  variables: OptionsVariables;
  style: OptionsStyle;
  // assets: OptionsAssets;
  // widget: OptionsWidget;
}


// //////////////////////////////
//   options
//     ├── variables
//     ...
// //////////////////////////////
interface OptionsVariables {
  /**
   * @const
   * @type string
   * @files $HOME/.cache/ags/user
   */
  AGS_COMPILE_DIR: string;

  /**
   * @const
   * @type string
   * @files $HOME/.cache/ags/user/generated
   */
  AGS_COMPILE_GEN_DIR: string;

  /**
   * @const
   * @type string
   * @file $HOME/.cache/ags/user/generated/style.css
   */
  AGS_COMPILE_GEN_CSS: string;

  /**
   * @const
   * @type string
   * @files $HOME/.cache/ags/user/generated/src
   */
  AGS_COMPILE_SRC_DIR: string;

  /**
   * @const
   * @type string
   * @file $HOME/.cache/ags/user/generated/src/\_bg.jpg
   */
  AGS_COMPILE_SRC_APPLAUNCHER_BG: string;
}


// //////////////////////////////
//   options
//     ...
//     ╰── style
// //////////////////////////////
/* 
 * @enum
 * */
enum OptionsStyleThemeVariant { LIGHT, DARK }

interface OptionsStyle {
  theme_variant: OptionsStyleThemeVariant;
}


// interface OptionsStyle {
//   src: OptionsStyleSrc;
//   theme: OptionsStyleTheme;
//   noise: OptionsStyleNoise;
// }
//
// interface OptionsStyleSrc {
//   folder: string;
//   main: string;
//   files: string[];
// }
//
// interface OptionsStyleTheme {
//   light: Record<string, unknown>;
//   dark: Record<string, unknown>;
// }
//
// interface OptionsStyleNoise {
//   src: {
//     folder: string;
//   }
//
//   none: OptionsStyleNoiseVariant;
//   default: OptionsStyleNoiseVariant;
//   gradient: OptionsStyleNoiseVariant;
//   gradient2: OptionsStyleNoiseVariant;
//   linegradient: OptionsStyleNoiseVariant;
// }
//
interface OptionsStyleNoiseVariant {
  bg: string;
  opacity?: number;
}
//
// interface OptionsAssets {
//   src: {
//     folder: string;
//   }
// }
//
// interface OptionsWidget {
//   applauncher: OptionsWidgetApplauncher;
//   bar: OptionsWidgetBar;
//   player: OptionsWidgetPlayer;
//   notifications: OptionsWidgetNotifications;
//   brightnessoverlay: OptionsWidgetBrightnessOverlay;
//   volumeoverlay: OptionsWidgetVolumeOverlay;
// }
//
// interface OptionsWidgetApplauncher {
//   asserts: string;
//   bg_image: string;
// }
//
// interface OptionsWidgetBar { }
//
// interface OptionsWidgetPlayer { }
//
// interface OptionsWidgetNotifications { }
//
// interface OptionsWidgetBrightnessOverlay { }
//
// interface OptionsWidgetVolumeOverlay { }


export {
  AppOptions,
  OptionsVariables,
  OptionsStyleNoiseVariant,
  OptionsStyleThemeVariant,
};
