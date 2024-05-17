import NoiseBox, { NoiseVariant } from "@/components/noisebox";
import GLib from "types/@girs/glib-2.0/glib-2.0";
import Overlay from "types/widgets/overlay";

const audio = await Service.import('audio');

let TIMEOUT: GLib.Source;
const TIMEOUT_DELAY = 1_000;
let VOLUME_OVERLAY_IS_SHOW = Variable<boolean>(false);
let MEMO = Variable<{
  volume: number;
  is_muted: boolean;
}>({
  volume: -1,
  is_muted: audio.speaker.stream?.is_muted || false,
});

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
        startAt: MEMO.bind().as(({ volume }) => 0.5 + volume / 2),
        endAt: 1,
        value: 0,
      }),

      Widget.Box({ className: 'value', hpack: 'center' }).bind('child', MEMO, 'value', ({ volume, is_muted }) => {
        if (is_muted) return Widget.Icon('audio-volume-muted-symbolic');
        const volume100: number = Math.round(volume * 100);
        if (volume100 === 100) return Widget.Icon('audio-volume-high-symbolic');
        return Widget.Label({
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

function haveUpdates(): boolean {
  let updates: boolean = false;
  if (audio.speaker.stream && audio.speaker.stream.is_muted !== MEMO.value.is_muted) {
    MEMO.setValue({
      ...MEMO.value,
      is_muted: audio.speaker.stream.is_muted,
    });
    updates = true;
  }

  if (audio.speaker.volume !== MEMO.value.volume) {
    MEMO.setValue({
      ...MEMO.value,
      volume: audio.speaker.volume,
    });
    updates = true;
  }

  return updates;
}

function showWidget() {
  const updates = haveUpdates();
  if (!updates) return;

  VOLUME_OVERLAY_IS_SHOW.setValue(true);
  if (TIMEOUT) clearTimeout(TIMEOUT);
  TIMEOUT = setTimeout(() => VOLUME_OVERLAY_IS_SHOW.setValue(false), TIMEOUT_DELAY);
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
    canFocus: false,
    focus_on_click: false,
    sensitive: false,

    child: Content(),
    setup: self => self
      .hook(audio.speaker, showWidget)
      .bind('visible', VOLUME_OVERLAY_IS_SHOW, 'value'),
  });
}

