import { Variable as TypeVariable } from "types/variable";

export interface PlayerStoreInterface {
  isVisible: TypeVariable<boolean>;
  isVisibleContent: TypeVariable<boolean>;

  get visible(): boolean
  open: () => Promise<void>;
  close: () => Promise<void>;
  toggle: () => Promise<PlayerStoreInterface>;
}

