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
  AGS_COMPILE_DIR: string;
  AGS_COMPILE_GEN_DIR: string;
}

// //////////////////////////////
//   options
//     ...
//     ╰── style
// //////////////////////////////
// type OptionsStyleThemeVariant = 'light' | 'dark';
export enum OptionsStyleThemeVariant { LIGHT, DARK }

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
  OptionsStyleNoiseVariant,
};
