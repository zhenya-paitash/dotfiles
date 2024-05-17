import GLib from "types/@girs/glib-2.0/glib-2.0";

import { DATE_HMa, DATE_dbY } from "@/services/date";

let TIMEOUT: GLib.Source;
const TIMEOUT_DELAY = 10_000;
const MODE = Variable<"clock" | "date">("clock");

function Content() {
  const onClicked = () => {
    MODE.value = MODE.value === "clock" ? "date" : "clock";
    if (TIMEOUT) clearTimeout(TIMEOUT);
    if (MODE.value === "date") TIMEOUT = setTimeout(onClicked, TIMEOUT_DELAY);
  }

  // TODO: ToggleButton?
  return Widget.Button({
    onClicked,
    child: Widget.CenterBox({
      centerWidget: Widget.Stack({
        children: {
          clock: Widget.Label({ label: DATE_HMa }),
          date: Widget.Label({ label: DATE_dbY })
            // .bind('visible', MODE, 'value', mode => mode === 'date'),
        },
        shown: MODE.bind(),
      }),
    }),
  });
}

// ------------------------------ //
//          CLOCK WIDGET          //
// ------------------------------ //
export function ClockWidget() {
  const children = [Content()];

  return Widget.Box({
    className: 'clock',
    children,
  });
}
