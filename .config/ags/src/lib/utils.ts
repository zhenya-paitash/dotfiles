import { OptionsStyleSrc } from "@/options";

export function StylesWatcher({ folder, main, files }: OptionsStyleSrc): void {
  for (const file of files) Utils.monitorFile(folder + file, () => {
    App.resetCss();
    App.applyCss(main);
  });
}

