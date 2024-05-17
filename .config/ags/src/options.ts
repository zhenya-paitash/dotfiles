// ////////////////////////////////////////////////////////////////////
//                            INTERFACES
// ////////////////////////////////////////////////////////////////////
// @export
export interface AppOptions {
  style: OptionsStyle;
  assets: OptionsAssets;
  widget: OptionsWidget;
}

interface OptionsStyle {
  src: OptionsStyleSrc;
  theme: OptionsStyleTheme;
  noise: OptionsStyleNoise;
}

// @export
export interface OptionsStyleSrc {
  folder: string;
  main: string;
  files: string[];
}

interface OptionsStyleTheme {
  light: Record<string, unknown>;
  dark: Record<string, unknown>;
}

interface OptionsStyleNoise {
  src: {
    folder: string;
  }

  none: OptionsStyleNoiseVariant;
  default: OptionsStyleNoiseVariant;
  gradient: OptionsStyleNoiseVariant;
  gradient2: OptionsStyleNoiseVariant;
  linegradient: OptionsStyleNoiseVariant;
}

// @export
export interface OptionsStyleNoiseVariant {
  bg: string;
  opacity?: number;
}

interface OptionsAssets {
  src: {
    folder: string;
  }
}

interface OptionsWidget {
  applauncher: OptionsWidgetApplauncher;
  bar: OptionsWidgetBar;
  player: OptionsWidgetPlayer;
  notifications: OptionsWidgetNotifications;
  brightnessoverlay: OptionsWidgetBrightnessOverlay;
  volumeoverlay: OptionsWidgetVolumeOverlay;
}

interface OptionsWidgetApplauncher {
  asserts: string;
  bg_image: string;
}

interface OptionsWidgetBar { }

interface OptionsWidgetPlayer { }

interface OptionsWidgetNotifications { }

interface OptionsWidgetBrightnessOverlay { }

interface OptionsWidgetVolumeOverlay { }


// ////////////////////////////////////////////////////////////////////
//                              OPTIONS
// ////////////////////////////////////////////////////////////////////
const folders = {
  styles: `${App.configDir}/src/styles`,
  assets: `${App.configDir}/src/assets`,
  noise: `${App.configDir}/src/assets/noise`,
}

const options: AppOptions = {
  style: {
    src: {
      folder: folders.styles,
      main: folders.styles + '/main.css',
      files: [
        '/main.css',
        '/colors.css',
        '/theme.css',
        '/core.css',
        '/themes/_generated.css',
        '/widgets/bar.css',
        '/widgets/notifications.css',
        '/widgets/brightness-overlay.css',
        '/widgets/volume-overlay.css',
        '/widgets/app-launcher.css',
        '/widgets/player.css',
      ],
    },

    theme: {
      light: {},
      dark: {},
    },

    noise: {
      src: {
        folder: folders.noise,
      },

      none: {
        bg: 'none',
      },
      default: {
        bg: folders.noise + '/texture-noise-default-min.png',
        opacity: 0.2,
      },
      gradient: {
        bg: folders.noise + '/texture-noise-gradient-min.png',
      },
      gradient2: {
        bg: folders.noise + '/texture-noise-gradient2-min.png',
        opacity: 0.1,
      },
      linegradient: {
        bg: folders.noise + '/texture-noise-linegradient-min.png',
      },
    },
  },

  assets: {
    src: {
      folder: folders.assets,
    },
  },

  widget: {
    applauncher: {
      asserts: folders.assets + '/app-launcher',
      bg_image: folders.assets + '/app-launcher/bg.jpg',
    },
    bar: {},
    player: {},
    notifications: {},
    brightnessoverlay: {},
    volumeoverlay: {},
  },
}


// ////////////////////////////////////////////////////////////////////
//                              EXPORTS    
// ////////////////////////////////////////////////////////////////////
globalThis.options = options;
export default options;

