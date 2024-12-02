import GLib from "types/@girs/glib-2.0/glib-2.0";
import Button from "types/widgets/button";
import Box from "types/widgets/box";
import Icon from "types/widgets/icon";

import {
  VPN_ENABLED,
  VPN_ENABLED_ICON,
  VPN_ENABLED_TOGGLE,
  SHOW_CONNECTIONS,
  WIREGUARD_CONNECTION_NAME,
} from "@/services/vpn";

let TIMEOUT: GLib.Source;
const TIMEOUT_DELAY = 5000;
let VPN_WIDGET_IS_SHOW = Variable<boolean>(false);
let VPN_CONTROLLER_LABEL = Variable<string>('disable');


function Content(): Button<any, unknown> {
  const children = [
    Widget.Revealer({
      revealChild: false,
      transition: "slide_left",
      transitionDuration: 300,
      child: ContentData(),
      setup: self => self.bind('reveal_child', VPN_WIDGET_IS_SHOW),
    }),

    ContentIcon(),
  ];

  return Widget.Button({
    onClicked: VPN_ENABLED_TOGGLE,
    onSecondaryClick: SHOW_CONNECTIONS,
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
    className: 'sys-mng-data vpn-data',
    children: [
      Widget.Label({
        className: 'vpn-controller',
        label: VPN_CONTROLLER_LABEL.bind(),
        // setup: self => self.hook(BLUETOOTH_POWER, onBluetoothChange),
      }),
    ],
  });
}

function ContentIcon(): Icon<any> {
  return Widget.Icon({
    className: 'icon',
    icon: VPN_ENABLED_ICON,
  });
}

function closeVpnController(): void {
  VPN_WIDGET_IS_SHOW.setValue(false);
  // BLUETOOTH_CONTROLLER_LABEL.setValue("");
  clearTimeout(TIMEOUT);
}

function onVpnChange(): void {
  const newLabel: string = VPN_ENABLED.value ? "online: " + WIREGUARD_CONNECTION_NAME : 'vpn-disabled';
  if (VPN_CONTROLLER_LABEL.value === newLabel) return;

  VPN_CONTROLLER_LABEL.setValue(newLabel);
  VPN_WIDGET_IS_SHOW.setValue(true);
  if (TIMEOUT) clearTimeout(TIMEOUT);
  TIMEOUT = setTimeout(closeVpnController, TIMEOUT_DELAY);
}


// ------------------------------ //
//            VPN WIDGET          //
// ------------------------------ //
export function VpnWidget() {
  return Widget.Box({
    className: 'sys-mng vpn',
    vertical: false,
    child: Content(),
    setup: self => self
      .hook(VPN_WIDGET_IS_SHOW, () => self.toggleClassName('sys-mng-active', VPN_WIDGET_IS_SHOW.value))
      .hook(VPN_ENABLED, () => {
        self.toggleClassName('vpn-disabled', !VPN_ENABLED.value);
        onVpnChange();
      })
  });
}


