// //////////////////////////////
//   options
//     ├── variables
//     ╰── styles
// //////////////////////////////
interface Opts {
  variables: OptsVariables;
  styles: OptsStyles;
}


// //////////////////////////////
//   options
//     ├── variables
//     ...
// //////////////////////////////
interface OptsVariables {
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
//     ╰── styles
// //////////////////////////////
  /* 
   * @enum
   * */
enum OptsStylesThemeVariant { LIGHT, DARK }

interface OptsStyles {
  /* 
   * @type {OptsStylesThemeVariant} 
   * */
  theme_variant: OptsStylesThemeVariant;
  files: string[];
}


interface OptsStylesNoiseVariant {
  bg: string;
  opacity?: number;
}


export {
  Opts,
  OptsVariables,
  OptsStylesThemeVariant,
  OptsStylesNoiseVariant,
};
