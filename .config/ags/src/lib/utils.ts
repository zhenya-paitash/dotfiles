import options from "@options";


interface AppUtilsInterface {
  prebuild(): void;
  buildStyles(): Promise<void>;
  watchStyles(): void;
}

class AppUtils implements AppUtilsInterface {
  #GEN_DIR: string = options.variables.AGS_COMPILE_GEN_DIR;
  #GEN_CSS: string = `${this.#GEN_DIR}/style.css`;
  #LOCK: boolean = false;

  prebuild(): void {
    Utils.exec(`mkdir -p ${this.#GEN_DIR}`);
    Utils.exec(`touch ${this.#GEN_CSS}`);
    console.log(`[UTILS] Directories and files created!`);
  }

  async buildStyles(): Promise<void> {
    await Utils
      .execAsync(`sassc ${App.configDir}/src/styles/main.scss ${this.#GEN_CSS}`)
      .catch(print);
    this.resetStyles();
    // console.log(`[UTILS] Reloaded!`);
  }

  watchStyles(): void {
    // export function StylesWatcher({ folder, main, files }: OptionsStyleSrc): void {
    //   for (const file of files) Utils.monitorFile(folder + file, () => {
    //     App.resetCss();
    //     App.applyCss(main);
    //   });
    // }

    // TODO: получить все файлы из /src/styles** и отслеживать любое их изменение 
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
  }

  private resetStyles(): void {
    App.resetCss();
    App.applyCss(this.#GEN_CSS);
  }
}


export default new AppUtils();

