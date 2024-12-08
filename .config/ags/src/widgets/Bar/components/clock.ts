import GLib from "types/@girs/glib-2.0/glib-2.0";

import dateService from "@/services/date.service";

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
          clock: Widget.Label()
            .bind('label', dateService, 'date', ({ hour, minute, weekday }) => `${weekday} ${hour}:${minute}`),
          date: Widget.Label()
            .bind('label', dateService, 'date', ({ day, month_number, year }) => `${day}.${month_number}.${year}`),
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
