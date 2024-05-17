import GLib from "types/@girs/glib-2.0/glib-2.0";
import Box from "types/widgets/box";
import Button from "types/widgets/button";
import Icon from "types/widgets/icon";

const audio = await Service.import('audio');

let TIMEOUT: GLib.Source;
const TIMEOUT_DELAY = 3000;
let VOLUME_CONTROLLER_IS_SHOW = Variable<boolean>(false);
let MEMO_VOLUME_VALUE: number = -1;
let MEMO_VOLUME_IS_MUTED = Variable<boolean>(audio.speaker.stream?.is_muted || false);

function Content(): Button<any, unknown> {
  const onClicked = () => audio.speaker.is_muted = !audio.speaker.is_muted;
  const onScrollUp = (): number => audio.speaker.volume = Math.min(audio.speaker.volume + 0.05, 1);
  const onScrollDown = (): number => audio.speaker.volume = Math.max(0, audio.speaker.volume - 0.05);

  const children = [
    Widget.Revealer({
      revealChild: false,
      transition: "slide_left",
      transitionDuration: 300,
      child: ContentData(),
      setup: self => self.bind('reveal_child', VOLUME_CONTROLLER_IS_SHOW),
    }),

    ContentIcon(),
  ];

  return Widget.Button({
    onClicked,
    onScrollUp,
    onScrollDown,
    child: Widget.CenterBox({
      centerWidget: Widget.Box({ children }),
    }),
  });
}


function ContentData(): Box<any, unknown> {
  const closeVolumeData = (): void => {
    clearTimeout(TIMEOUT);
    VOLUME_CONTROLLER_IS_SHOW.setValue(false);
  }

  const onVolumeChange = (): void => {
    const volume = getVolume();
    // check if volume === init value and ignore it
    // if (MEMO_VOLUME_VALUE === -1) {
    //   MEMO_VOLUME_VALUE = volume;
    //   return;
    // }

    const notify = checkNotify(volume);
    if (!notify) return;
    if (!volume) return closeVolumeData();

    VOLUME_CONTROLLER_IS_SHOW.setValue(true);
    if (TIMEOUT) clearTimeout(TIMEOUT);
    TIMEOUT = setTimeout(closeVolumeData, TIMEOUT_DELAY);
  }

  return Widget.Box({
    className: 'sys-mng-data volume-data',
    children: [
      Widget.Box({
        className: 'volume-controller',
        setup: self => self
          .hook(audio.speaker, onVolumeChange)
          .bind('css', audio.speaker, 'volume', volume => `min-width: ${volume * 100}px;`),
      }),

      // Widget.Label({
      //   className: 'volume-value',
      //   label: audio.speaker.bind('volume').as(v => Math.round(v * 100).toString()),
      // }),
    ],
  });
}

function ContentIcon(): Icon<any> {
  const getIcon = (): string => {
    const icons = {
      101: "overamplified",
      67: "high",
      34: "medium",
      1: "low",
      0: "muted",
    };

    const icon: number = audio.speaker.is_muted
      ? 0
      : [101, 67, 34, 1, 0].find(t => t <= audio.speaker.volume * 100) || 0;

    return `audio-volume-${icons[icon]}-symbolic`;
  }

  return Widget.Icon({
    className: 'icon',
    icon: Utils.watch(getIcon(), audio.speaker, getIcon),
    setup: self => self.hook(MEMO_VOLUME_IS_MUTED, () => self.toggleClassName('icon-disabled', MEMO_VOLUME_IS_MUTED.value)),
  });
}

function getVolume(): number {
  let volume: number = audio.speaker.volume;
  if (volume > 1) audio.speaker.volume = volume = 1;
  return volume;
}

function checkNotify(volume: number): boolean {
  let notify: boolean = false;
  if (MEMO_VOLUME_VALUE !== volume) {
    MEMO_VOLUME_VALUE = volume;
    notify = true;
  }

  if (MEMO_VOLUME_IS_MUTED.value !== audio.speaker.stream?.is_muted) {
    let muted: boolean = Boolean(audio.speaker.stream?.is_muted);
    MEMO_VOLUME_IS_MUTED.setValue(muted);
    audio.speaker.is_muted = muted;
    notify = true;
  }

  return notify;
}

// ------------------------------ //
//          VOLUME WIDGET         //
// ------------------------------ //
export function VolumeWidget() {
  return Widget.Box({
    className: 'sys-mng volume',
    vertical: false,
    child: Content(),
    setup: self => self
      .hook(VOLUME_CONTROLLER_IS_SHOW, () => self.toggleClassName('sys-mng-active', VOLUME_CONTROLLER_IS_SHOW.value))
      .hook(MEMO_VOLUME_IS_MUTED, () => self.toggleClassName('volume-disabled', MEMO_VOLUME_IS_MUTED.value)),
  });
}

