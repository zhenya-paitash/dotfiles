import GLib from "types/@girs/glib-2.0/glib-2.0";
import { Wifi } from "types/service/network";
import Box from "types/widgets/box";
import Button from "types/widgets/button";
import Stack from "types/widgets/stack";

const network = await Service.import('network');

let TIMEOUT: GLib.Source;
const TIMEOUT_DELAY = 5000;
let NETWORK_WIDGET_IS_SHOW = Variable<boolean>(false);
let NETWORK_CONTROLLER_LABEL = Variable<string>('');
let MEMO_NETWORK_WIFI_SSID = Variable<Wifi['ssid']>(null);
let MEMO_NETWORK_WIFI_STATE = Variable<Wifi["state"]>('unknown');


function Content(): Button<any, unknown> {
  const onClicked = () => {
    if (NETWORK_WIDGET_IS_SHOW.value) return;

    NETWORK_WIDGET_IS_SHOW.setValue(true);
    NETWORK_CONTROLLER_LABEL.setValue(MEMO_NETWORK_WIFI_SSID.value || 'unknown');
    if (TIMEOUT) clearTimeout(TIMEOUT);
    TIMEOUT = setTimeout(cloeseNetworkController, TIMEOUT_DELAY);
  }

  const children = [
    Widget.Revealer({
      revealChild: false,
      transition: "slide_left",
      transitionDuration: 300,
      child: ContentData(),
      setup: self => self.bind('reveal_child', NETWORK_WIDGET_IS_SHOW),
    }),

    ContentIcon(),
  ];

  return Widget.Button({
    onClicked,
    // onHoverLost: cloeseNetworkController,
    child: Widget.CenterBox({
      centerWidget: Widget.Box({
        children,
      }),
    }),
  })
}

function ContentData(): Box<any, unknown> {
  return Widget.Box({
    className: 'sys-mng-data network-data',
    children: [
      Widget.Label({
        className: 'network-controller',
        label: NETWORK_CONTROLLER_LABEL.bind(),
        // tooltipText: network.wifi.bind('ssid').as(ssid => ssid || 'Unknown'),
      }),
    ],
  });
}

function ContentIcon(): Stack<any, unknown> {
  const wifi = Widget.Box({
    // tooltipText: MEMO_NETWORK_WIFI_SSID.bind().as(ssid => ssid || 'Unknown'),
    children: [
      Widget.Icon({
        className: 'icon',
        icon: network.wifi.bind('icon_name'),
      }),

      // Widget.Label({
      //   label: network.wifi.bind('access_points')
      //     // .as(ssid => ssid || 'Unknown'),
      //     .as(ssid => {
      //     // console.log(ssid)
      //     return "";
      //   }),
      // }),
    ],
  });

  const wired = Widget.Icon({
    className: 'icon',
    visible: false,
    icon: network.wired.bind('icon_name'),
  });



  return Widget.Stack({
    children: { wifi, wired },
    shown: network.bind('primary').as(p => p || 'wifi'),
  });
}

function checkNotify(): boolean {
  let notify: boolean = false;
  if (network.wifi?.state !== MEMO_NETWORK_WIFI_STATE.value) {
    MEMO_NETWORK_WIFI_STATE.setValue(network.wifi.state);
    NETWORK_CONTROLLER_LABEL.setValue(network.wifi.state);
    notify = true;
  }

  if (network.wifi?.ssid !== MEMO_NETWORK_WIFI_SSID.value) {
    MEMO_NETWORK_WIFI_SSID.setValue(network.wifi.ssid);
    NETWORK_CONTROLLER_LABEL.setValue(network.wifi.ssid || 'unknown');
    // notify = true;
    return true;
  }

  return notify;
}

function cloeseNetworkController() {
  NETWORK_WIDGET_IS_SHOW.setValue(false);
  NETWORK_CONTROLLER_LABEL.setValue("");
  clearTimeout(TIMEOUT);
}

function onNetworkChange() {
  const notify = checkNotify();
  if (!notify) return;

  if (network.wifi.ssid) {
    NETWORK_CONTROLLER_LABEL.setValue(network.wifi.ssid);
  }

  NETWORK_WIDGET_IS_SHOW.setValue(true);
  if (TIMEOUT) clearTimeout(TIMEOUT);
  TIMEOUT = setTimeout(cloeseNetworkController, TIMEOUT_DELAY);
}

// ------------------------------ //
//         NETWORK WIDGET         //
// ------------------------------ //
// ─┬─ box .sys-mng.network
//  ╰─┬─ button
//    ╰─┬─ centerbox
//      ╰─┬─ box
//        ├─┬─ revealer
//        │ ╰─┬─ box .sys-mng-data.battery-data
//        │   ╰─── label .battery-controller
//        ╰─┬─ stack
//          ├─┬─ box
//          │ ╰─── icon .icon
//          ╰─── icon .icon
export function NetworkWidget() {
  return Widget.Box({
    className: 'sys-mng network',
    vertical: false,
    child: Content(),
    setup: self => self
      .hook(NETWORK_WIDGET_IS_SHOW, () => self.toggleClassName('sys-mng-active', NETWORK_WIDGET_IS_SHOW.value))
      .hook(network.wifi, onNetworkChange)
  });
}

