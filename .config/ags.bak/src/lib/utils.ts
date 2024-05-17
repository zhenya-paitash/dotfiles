import options, { OptionsStyleSrc } from "@/options";

export function StylesWatcher({ folder, main, files }: OptionsStyleSrc): void {
  for (const file of files) Utils.monitorFile(folder + file, () => {
    App.resetCss();
    App.applyCss(main);
    console.log('alskdjlaksj');
  });
}

// const COMPILED_STYLE_DIR = `${GLib.get_user_cache_dir()}/ags/user/generated`
// const range = (length, start = 1) => Array.from({ length }, (_, i) => i + start);
// function forMonitors(widget) {
//     const n = Gdk.Display.get_default()?.get_n_monitors() || 1;
//     return range(n, 0).map(widget).flat(1);
// }
// function forMonitorsAsync(widget) {
//     const n = Gdk.Display.get_default()?.get_n_monitors() || 1;
//     return range(n, 0).forEach((n) => widget(n).catch(print))
// }
//
// // SCSS compilation
// Utils.exec(`bash -c 'echo "" > ${App.configDir}/scss/_musicwal.scss'`); // reset music styles
// Utils.exec(`bash -c 'echo "" > ${App.configDir}/scss/_musicmaterial.scss'`); // reset music styles
// async function applyStyle() {
//     Utils.exec(`mkdir -p ${COMPILED_STYLE_DIR}`);
//     Utils.exec(`sass ${App.configDir}/scss/main.scss ${COMPILED_STYLE_DIR}/style.css`);
//     App.resetCss();
//     App.applyCss(`${COMPILED_STYLE_DIR}/style.css`);
//     console.log('[LOG] Styles loaded')
// }
// applyStyle().catch(print);


// export async function ApplyStyles(): Promise<void> {
//   try {
//     const { AGS_COMPILE_STYLE_DIR } = options.variables;
//
//     Utils.exec(`mkdir -p ${AGS_COMPILE_STYLE_DIR}`);
//     Utils.exec(`sass ${App.configDir}/styles/main.scss ${AGS_COMPILE_STYLE_DIR}/style.css`);
//     App.resetCss();
//     App.applyCss(`${AGS_COMPILE_STYLE_DIR}/style.css`);
//     console.log(`[STYLE] Reloaded!`);
//   } catch (err) {
//     print(err);
//   }
// }
