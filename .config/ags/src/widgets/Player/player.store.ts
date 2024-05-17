import { PlayerStoreInterface } from "./player.interface";

export class PlayerStore<T> implements PlayerStoreInterface {
  isVisible = Variable(false);
  isVisibleContent = Variable(false);
  isLock = Variable(false);
  private ANIMATION_DURATION: number = 300;

  get(key: keyof PlayerStore<T>): PlayerStore<T>[keyof PlayerStore<T>] {
    switch (key) {
      case "isVisible":
      case "isVisibleContent":
      case "isLock":
        return this[key].value;
    }

    return this[key];
  }

  set(key: keyof PlayerStore<T>, value: PlayerStore<T>[keyof PlayerStore<T>]): PlayerStore<T> {
    switch (key) {
      case "isVisible":
      case "isVisibleContent":
      case "isLock":
        this[key].setValue(Boolean(value));
    }

    return this;
  }


  get visible(): boolean {
    return this.isVisible.value;
  }

  async open(): Promise<void> {
    // if (this.isLock.value) return;
    // this.isLock.setValue(true);
    // this.isVisible.setValue(true);
    // await this.sleep(this.ANIMATION_DURATION);
    // this.isVisibleContent.setValue(true);
    // this.isLock.setValue(false);

    if (this.get('isLock')) return;
    await this
      .set('isLock', true)
      .set('isVisible', true)
      .sleep(this.ANIMATION_DURATION).then(() => this
        .set('isVisibleContent', true)
        .set('isLock', false)
      );
  }

  async close(): Promise<void> {
    // if (this.isLock.value) return;
    // this.isLock.setValue(true);
    // this.isVisibleContent.setValue(false);
    // await this.sleep(this.ANIMATION_DURATION);
    // this.isVisible.setValue(false);
    // this.isLock.setValue(false);

    if (this.get('isLock')) return;
    await this
      .set('isLock', true)
      .set('isVisibleContent', false)
      .sleep(this.ANIMATION_DURATION).then(() => this
        .set('isVisible', false)
        .set('isLock', false)
      );
  }

  async toggle(): Promise<PlayerStoreInterface> {
    await (this.isVisible.value ? this.close() : this.open());
    return this;
  }

  private async sleep(ms: number): Promise<void> {
    return new Promise(resolve => setTimeout(resolve, ms));
  }
}

const store = new PlayerStore();

export default store;
globalThis.player = () => store.toggle();

