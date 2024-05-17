import { Application } from "types/service/applications";
import { Variable as TypeVariable } from "types/variable";

export interface AppLauncherStoreInterface {
  applications: TypeVariable<Application[]>;
  search: TypeVariable<string>;
  show: TypeVariable<boolean>;
  show_apps: TypeVariable<boolean>;
  bg_image: TypeVariable<string>;
  use_bg_image: string;
  open: () => void;
  close: () => void;
  toggle: () => void;
}

