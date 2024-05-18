import GLib from 'types/@girs/glib-2.0/glib-2.0';

import { AppOptions, OptionsStyleThemeVariant } from './options.interface'

const AGS_COMPILE_DIR = GLib.build_filenamev([GLib.get_user_cache_dir(), 'ags', 'user']);

const options: AppOptions = {
  variables: {
    // $HOME/.cache/ags/user
    AGS_COMPILE_DIR,

    // $HOME/.cache/ags/user/generated
    AGS_COMPILE_GEN_DIR: `${AGS_COMPILE_DIR}/generated`,
    AGS_COMPILE_GEN_CSS: `${AGS_COMPILE_DIR}/generated/style.css`,

    // $HOME/.cache/ags/user/generated/src
    AGS_COMPILE_SRC_DIR: `${AGS_COMPILE_DIR}/generated/src`,
    AGS_COMPILE_SRC_APPLAUNCHER_BG: `${AGS_COMPILE_DIR}/generated/src/_bg.jpg`,
  },

  style: {
    theme_variant: OptionsStyleThemeVariant.DARK,
  },
};


export * from './options.interface'
export default options;
globalThis.options = options;

