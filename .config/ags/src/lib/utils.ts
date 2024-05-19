import options from "@options";


interface AppUtilsInterface {
  prebuild(): AppUtils;
  watchStyles(): AppUtils;
  buildStyles(): Promise<void>;
  sleep(ms: number): Promise<void>;
}

class AppUtils implements AppUtilsInterface {
  prebuild(): AppUtils {
    Utils.exec(`mkdir -p ${options.variables.AGS_COMPILE_GEN_DIR}`);
    Utils.exec(`mkdir -p ${options.variables.AGS_COMPILE_SRC_DIR}`);
    Utils.exec(`touch ${options.variables.AGS_COMPILE_GEN_CSS}`);
    // Utils.exec(`touch ${options.variables.AGS_COMPILE_SRC_APPLAUNCHER_BG}`);
    Utils.execAsync(`bash -c "cp ${App.configDir}/src/assets/texture/* ${options.variables.AGS_COMPILE_SRC_DIR}"`);
    console.log(`[UTILS] Directories and files created!`);

    return this;
  }

  watchStyles(): AppUtils {
    for (const file of options.styles.files) Utils.monitorFile(file, this.buildStyles.bind(this));
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

  async sleep(ms: number): Promise<void> {
    return new Promise(resolve => setTimeout(resolve, ms));
  }
}


export default new AppUtils();

