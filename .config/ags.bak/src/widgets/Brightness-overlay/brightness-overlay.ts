import GLib from "types/@girs/glib-2.0/glib-2.0";

import brightness from '@/services/brightness.service';
import Overlay from "types/widgets/overlay";
import NoiseBox, { NoiseVariant } from "@/components/noisebox";

let TIMEOUT: GLib.Source;
const TIMEOUT_DELAY = 1_000;
let BRIGHTNESS_OVERLAY_IS_SHOW = Variable<boolean>(false);
let MEMO_BRIGHTNESS = Variable<number>(brightness.screen_value);

function Content(): Overlay<any, any, unknown> {
  return Widget.Overlay({
    className: 'brightness-overlay',
    pass_through: false,

    sensitive: false,
    focus_on_click: false,
    canFocus: false,
    focusOnClick: false,
    has_focus: false,
    is_focus: false,

    overlays: [
      Widget.Box({ className: 'brightness-bar' }),

      Widget.Label({
        className: 'title',
        vpack: 'start',
        label: 'Brightness',
      }),

      Widget.CircularProgress({
        className: 'brightness-bar-progress',
        rounded: true,
        inverted: false,
        startAt: 0.5,
        endAt: 1,
        value: MEMO_BRIGHTNESS.bind().as(b => b),
      }),
    ],

    child: NoiseBox({
      variant: NoiseVariant.DEFAULT,
      opacity: 0.5,
    }, Widget.Box({
      className: 'container',
      sensitive: false,
      focus_on_click: false,
      canFocus: false,
      focusOnClick: false,
      has_focus: false,
      is_focus: false,
    })),
  });
}

function haveUpdates(): boolean {
  let updates: boolean = false;
  if (brightness.screen_value !== MEMO_BRIGHTNESS.value) {
    MEMO_BRIGHTNESS.setValue(brightness.screen_value);
    updates = true;
  }

  return updates;
}

function showWidget() {
  const updates = haveUpdates();
  if (!updates) return;

  BRIGHTNESS_OVERLAY_IS_SHOW.setValue(true);
  if (TIMEOUT) clearTimeout(TIMEOUT);
  TIMEOUT = setTimeout(() => BRIGHTNESS_OVERLAY_IS_SHOW.setValue(false), TIMEOUT_DELAY);
}


// ------------------------------ //
//         VOLUME OVERLAY         //
// ------------------------------ //
export function BrightnessOverlay(monitor: number = 0) {
  return Widget.Window({
    monitor,
    name: `brightness-overlay-${monitor}`,
    className: 'brightness',
    anchor: ['bottom'],
    margins: [0, 0, 100, 0],
    layer: 'overlay',
    canFocus: false,
    focus_on_click: false,
    sensitive: false,

    child: Content(),
    setup: self => self
      .hook(brightness, showWidget)
      .bind('visible', BRIGHTNESS_OVERLAY_IS_SHOW, 'value'),
  });
}

