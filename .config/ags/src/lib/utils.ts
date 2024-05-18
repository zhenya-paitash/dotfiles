import options from "@options";


interface AppUtilsInterface {
  prebuild(): AppUtils;
  watchStyles(): AppUtils;
  buildStyles(): Promise<void>;
}

class AppUtils implements AppUtilsInterface {
  prebuild(): AppUtils {
    Utils.exec(`mkdir -p ${options.variables.AGS_COMPILE_GEN_DIR}`);
    Utils.exec(`mkdir -p ${options.variables.AGS_COMPILE_SRC_DIR}`);
    Utils.exec(`touch ${options.variables.AGS_COMPILE_GEN_CSS}`);
    Utils.exec(`touch ${options.variables.AGS_COMPILE_SRC_APPLAUNCHER_BG}`);
    Utils.execAsync(`bash -c "cp ${App.configDir}/src/assets/texture/* ${options.variables.AGS_COMPILE_SRC_DIR}"`);
    console.log(`[UTILS] Directories and files created!`);

    return this;
  }

  watchStyles(): AppUtils {
    const files: string[] = [
      '/home/zh/.config/ags/src/styles/main.scss',
      '/home/zh/.config/ags/src/styles/colors.scss',
      '/home/zh/.config/ags/src/styles/theme.scss',
      '/home/zh/.config/ags/src/styles/core.scss',
      '/home/zh/.config/ags/src/styles/themes/_generated.scss',
      '/home/zh/.config/ags/src/styles/widgets/bar.scss',
      '/home/zh/.config/ags/src/styles/widgets/notifications.scss',
      '/home/zh/.config/ags/src/styles/widgets/brightness-overlay.scss',
      '/home/zh/.config/ags/src/styles/widgets/volume-overlay.scss',
      '/home/zh/.config/ags/src/styles/widgets/app-launcher.scss',
      '/home/zh/.config/ags/src/styles/widgets/player.scss',
    ];

    for (const file of files) Utils.monitorFile(file, this.buildStyles.bind(this));

    return this;
  }

  async buildStyles(): Promise<void> {
    await Utils
      .execAsync(`sassc ${App.configDir}/src/styles/main.scss ${options.variables.AGS_COMPILE_GEN_CSS}`)
      .catch(print);
    this.resetStyles();
    // console.log(`[UTILS] Reloaded!`);
  }

  private resetStyles(): void {
    App.resetCss();
    App.applyCss(options.variables.AGS_COMPILE_GEN_CSS);
  }
}


export default new AppUtils();

