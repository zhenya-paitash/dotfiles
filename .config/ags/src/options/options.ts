import GLib from 'types/@girs/glib-2.0/glib-2.0';

import { OptsStylesThemeVariant, Opts } from './options.interface'

const AGS_COMPILE_DIR = GLib.build_filenamev([GLib.get_user_cache_dir(), 'ags', 'user']);
const _STYLES_DIR = `${App.configDir}/src/styles`;

const options: Opts = {
  variables: {
    AGS_COMPILE_DIR,
    AGS_COMPILE_GEN_DIR: `${AGS_COMPILE_DIR}/generated`,
    AGS_COMPILE_GEN_CSS: `${AGS_COMPILE_DIR}/generated/style.css`,
    AGS_COMPILE_SRC_DIR: `${AGS_COMPILE_DIR}/generated/src`,
    AGS_COMPILE_SRC_APPLAUNCHER_BG: `${AGS_COMPILE_DIR}/generated/src/_bg.jpg`,
  },

  styles: {
    theme_variant: OptsStylesThemeVariant.DARK,
    files: [
      `${_STYLES_DIR}/main.scss`,
      `${_STYLES_DIR}/colors.scss`,
      `${_STYLES_DIR}/theme.scss`,
      `${_STYLES_DIR}/core.scss`,
      `${_STYLES_DIR}/themes/_generated.scss`,
      `${_STYLES_DIR}/widgets/bar.scss`,
      `${_STYLES_DIR}/widgets/notifications.scss`,
      `${_STYLES_DIR}/widgets/brightness-overlay.scss`,
      `${_STYLES_DIR}/widgets/volume-overlay.scss`,
      `${_STYLES_DIR}/widgets/app-launcher.scss`,
      `${_STYLES_DIR}/widgets/player.scss`,
      `${_STYLES_DIR}/widgets/widgets.scss`,
    ],
  },
};


export * from './options.interface'
export default options;
globalThis.options = options;

