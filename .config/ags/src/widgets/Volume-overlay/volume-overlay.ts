import NoiseBox, { NoiseVariant } from "@/components/noisebox";
import Overlay from "types/widgets/overlay";
import { volumeOverlayStore } from "@store"

function Content(): Overlay<any, any, unknown> {
  return Widget.Overlay({
    className: 'volume-overlay',
    pass_through: false,
    sensitive: false,
    focus_on_click: false,
    canFocus: false,
    focusOnClick: false,
    has_focus: false,
    is_focus: false,

    overlays: [
      Widget.Box({ className: 'volume-bar' }),

      Widget.Label({
        className: 'title',
        vpack: 'start',
        label: 'Volume',
      }),

      // TODO: set to BOX and static on center top. Rotate .volume-bar with 
      Widget.CircularProgress({
        className: 'volume-bar-progress',
        rounded: true,
        inverted: false,
        startAt: volumeOverlayStore.audio.bind().as(({ volume }) => 0.5 + volume / 2),
        endAt: 1,
        value: 0,
      }),

      Widget
        .Box({ className: 'value', hpack: 'center' })
        .bind('child', volumeOverlayStore.audio, 'value', ({ volume, mute }) => {
          if (mute) return Widget.Icon('audio-volume-muted-symbolic');

          const volume100: number = Math.round(volume * 100);
          if (volume100 === 100) return Widget.Icon('audio-volume-high-symbolic');
          return Widget.Label({
            // label: String(volume100).padStart(3, "0"),
            label: String(volume100),
            // angle: volume100 >= 50 ? 450 - (180 / 100) * volume100 : 90 - (180 / 100) * volume100,
          });
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
export function VolumeOverlay(monitor: number = 0) {
  return Widget.Window({
    monitor,
    name: `volume-overlay-${monitor}`,
    className: 'volume',
    anchor: ['bottom'],
    margins: [0, 0, 100, 0],
    layer: 'overlay',
    visible: false,
    canFocus: false,
    focus_on_click: false,
    sensitive: false,

    child: Content(),
    setup: self => self
      .bind('visible', volumeOverlayStore.isVisible, 'value'),
  });
}

