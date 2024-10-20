import { BatteryWidget } from "./components/battery";
import { BluetoothWidget } from "./components/bluetooth";
import { ClockWidget } from "./components/clock";
import { MediaWidget } from "./components/media";
import { NetworkWidget } from "./components/network";
import { PowerWidget } from "./components/power";
import { VolumeWidget } from "./components/volume";
import { WorkspaceWidget } from "./components/workspace";

export function SectionLeft() {
  return Widget.Box({
    className: 'section section-left',
    hpack: 'start',
    children: [
      MediaWidget(),
    ],
  });
}

export function SectionCenter() {
  return Widget.Box({
    className: 'section section-center',
    hpack: 'center',
    children: [
      WorkspaceWidget(),
      ClockWidget(),
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
      BluetoothWidget(),
      VolumeWidget(),
      BatteryWidget(),
      PowerWidget(),

      // ClockWidget(),
    ],
  });
}

