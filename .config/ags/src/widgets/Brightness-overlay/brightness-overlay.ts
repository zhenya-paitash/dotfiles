import Overlay from "types/widgets/overlay";

import NoiseBox, { NoiseVariant } from "@/components/noisebox";
import { brightnessOverlayStore } from "@store"

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
        value: brightnessOverlayStore.brightness.bind(),
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
    visible: false,
    canFocus: false,
    focus_on_click: false,
    sensitive: false,

    child: Content(),
    setup: self => self
      .bind('visible', brightnessOverlayStore.isVisible, 'value'),
  });
}

