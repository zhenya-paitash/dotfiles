import GLib from "types/@girs/glib-2.0/glib-2.0";
import Button from "types/widgets/button";
import Box from "types/widgets/box";
import Icon from "types/widgets/icon";

import {
  BLUETOOTH_POWER,
  BLUETOOTH_POWER_ICON,
  BLUETOOTH_POWER_OPEN,
  BLUETOOTH_POWER_TOGGLE
} from "@/services/bluetooth";

let TIMEOUT: GLib.Source;
const TIMEOUT_DELAY = 5000;
let BLUETOOTH_WIDGET_IS_SHOW = Variable<boolean>(false);
let BLUETOOTH_CONTROLLER_LABEL = Variable<string>('disable');


function Content(): Button<any, unknown> {

  const children = [
    Widget.Revealer({
      revealChild: false,
      transition: "slide_left",
      transitionDuration: 300,
      child: ContentData(),
      setup: self => self.bind('reveal_child', BLUETOOTH_WIDGET_IS_SHOW),
    }),

    ContentIcon(),
  ];

  return Widget.Button({
    onClicked: BLUETOOTH_POWER_TOGGLE,
    onSecondaryClick: BLUETOOTH_POWER_OPEN,
    child: Widget.CenterBox({
      centerWidget: Widget.Box({
        children
      })
    }),
    // setup: self => self.hook(BLUETOOTH_POWER, onBluetoothChange),
  });
}

function ContentData(): Box<any, unknown> {
  return Widget.Box({
    className: 'sys-mng-data bluetooth-data',
    children: [
      Widget.Label({
        className: 'bluetooth-controller',
        label: BLUETOOTH_CONTROLLER_LABEL.bind(),
        // setup: self => self.hook(BLUETOOTH_POWER, onBluetoothChange),
      }),
    ],
  });
}

function ContentIcon(): Icon<any> {
  return Widget.Icon({
    className: 'icon',
    icon: BLUETOOTH_POWER_ICON,
  });
}

function closeBluetoothController(): void {
  BLUETOOTH_WIDGET_IS_SHOW.setValue(false);
  // BLUETOOTH_CONTROLLER_LABEL.setValue("");
  clearTimeout(TIMEOUT);
}

function onBluetoothChange(): void {
  const newLabel: string = BLUETOOTH_POWER.value ? 'ON' : 'disable';
  if (BLUETOOTH_CONTROLLER_LABEL.value === newLabel) return;

  BLUETOOTH_CONTROLLER_LABEL.setValue(newLabel);
  BLUETOOTH_WIDGET_IS_SHOW.setValue(true);
  if (TIMEOUT) clearTimeout(TIMEOUT);
  TIMEOUT = setTimeout(closeBluetoothController, TIMEOUT_DELAY);
}


// ------------------------------ //
//        BLUETOOTH WIDGET        //
// ------------------------------ //
export function BluetoothWidget() {
  return Widget.Box({
    className: 'sys-mng bluetooth',
    vertical: false,
    child: Content(),
    setup: self => self
      .hook(BLUETOOTH_WIDGET_IS_SHOW, () => self.toggleClassName('sys-mng-active', BLUETOOTH_WIDGET_IS_SHOW.value))
      .hook(BLUETOOTH_POWER, () => {
        self.toggleClassName('bluetooth-disabled', !BLUETOOTH_POWER.value);
        onBluetoothChange();
      })
  });
}


