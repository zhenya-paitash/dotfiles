import { BatteryWidget } from "./components/battery";
import { BluetoothWidget } from "./components/bluetooth";
import { ClockWidget } from "./components/clock";
import { MediaWidget } from "./components/media";
import { NetworkWidget } from "./components/network";
import { VpnWidget } from "./components/vpn";
import { PowerWidget } from "./components/power";
import { VolumeWidget } from "./components/volume";
import { WorkspaceWidget } from "./components/workspace";

export function SectionLeft() {
  return Widget.Box({
    className: 'section section-left',
    hpack: 'start',
    children: [
      MediaWidget(),
      // ClockWidget(),
    ],
  });
}

export function SectionCenter() {
  return Widget.Box({
    className: 'section section-center',
    hpack: 'center',
    children: [
      // ClockWidget(),
      WorkspaceWidget(),
    ],
  });
}

export function SectionRight() {
  return Widget.Box({
    className: 'section section-right',
    hpack: 'end',
    // spacing: 8,
    children: [
      NetworkWidget(),
      VpnWidget(),
      BluetoothWidget(),
      VolumeWidget(),
      BatteryWidget(),
      PowerWidget(),

      ClockWidget(),
    ],
  });
}

