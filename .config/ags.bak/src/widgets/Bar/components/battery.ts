import GLib from "types/@girs/glib-2.0/glib-2.0";
import Box from "types/widgets/box";
import Button from "types/widgets/button";
import Icon from "types/widgets/icon";
import Label from "types/widgets/label";

const battery = await Service.import('battery');

let TIMEOUT: GLib.Source;
const TIMEOUT_DELAY = 5000;
let BATTERY_WIDGET_IS_SHOW = Variable<boolean>(false);
let BATTERY_CONTROLLER_LABEL = Variable<string>("");
// TODO: mb rebuild all MEMO to 'battery.bind('charged')' and 'battery.bind('charging')'
let MEMO_BATTERY_CHARGING = Variable<boolean>(battery.charging);
let MEMO_BATTERY_IS_CHARGED = Variable<boolean>(battery.charged);

function Content(): Button<any, unknown> {
  // const onClicked = () => Utils.execAsync(`notify-send 'Battery' '${battery.charging ? '+' : '-'}'`);
  const visible = battery.bind('available');


  const children = [
    Widget.Revealer({
      revealChild: false,
      transition: "slide_left",
      transitionDuration: 300,
      child: ContentData(),
      setup: self => self.bind('reveal_child', BATTERY_WIDGET_IS_SHOW),
    }),

    ContentLabel(),

    ContentIcon(),
  ];

  return Widget.Button({
    className: battery.bind('charging').as(chrg => chrg ? 'battery-charging' : ''),
    // onClicked,
    visible,
    child: Widget.CenterBox({
      centerWidget: Widget.Box({
        children,
      })
    }),
  });
}

function ContentData(): Box<any, unknown> {
  return Widget.Box({
    className: 'sys-mng-data battery-data',
    children: [
      Widget.Label({
        className: 'battery-controller',
        label: BATTERY_CONTROLLER_LABEL.bind(),
        setup: self => self.hook(battery, onBatteryChange),
      }),
    ],
  });
}

function ContentIcon(): Icon<any> {
  const icon = battery.bind('icon_name');

  return Widget.Icon({
    className: 'icon',
    icon,
  });
}

function ContentLabel(): Label<any> {
  return Widget.Label({
    className: 'battery-percent',
    label: battery.bind('percent').as((percent: number) => {
      if (percent <= 0) return '!';
      if (percent > 95) return '';
      return String(percent);
    }),
  })
  // .bind('visible', MEMO_BATTERY_IS_CHARGED, 'value', isCharged => {
  //   return battery.percent < 95 && isCharged;
  // })
}

function closeBatteryData(): void {
  BATTERY_WIDGET_IS_SHOW.setValue(false);
  BATTERY_CONTROLLER_LABEL.setValue("");
  clearTimeout(TIMEOUT);
}

function onBatteryChange(): void {
  const notify = checkNotify();
  if (!notify) return;

  BATTERY_WIDGET_IS_SHOW.setValue(true);
  if (TIMEOUT) clearTimeout(TIMEOUT);
  TIMEOUT = setTimeout(closeBatteryData, TIMEOUT_DELAY);
}

function checkNotify(): boolean {
  let notify: boolean = false;
  let event: string[] = [];
  if (battery.charging !== MEMO_BATTERY_CHARGING.value) {
    MEMO_BATTERY_CHARGING.setValue(Boolean(battery.charging));
    if (MEMO_BATTERY_CHARGING.value) {
      event.push('⚡ connected');
      notify = true;
      Utils.notify({
        summary: 'Battery',
        body: `Cable charging. Until fully charged ~${Math.round(battery.time_remaining / 60)} minutes.`,
        iconName: battery.icon_name,
        timeout: 5000,
        urgency: 'normal',
      });
    }
  }

  if (MEMO_BATTERY_IS_CHARGED.value !== battery.charged) {
    MEMO_BATTERY_IS_CHARGED.setValue(Boolean(battery.charged));
    if (MEMO_BATTERY_CHARGING.value) {
      event.push('🔋 full charged');
      notify = true;
      Utils.notify({
        summary: 'Battery',
        body: `Battery is charged!`,
        iconName: battery.icon_name,
        timeout: 3000,
        urgency: 'normal',
      });
    }
  }

  if (event.length) BATTERY_CONTROLLER_LABEL.setValue(event.join(" "));

  return notify;
}


// ------------------------------ //
//         BATTERY WIDGET         //
// ------------------------------ //
// ─┬─ box .sys-mng.battery
//  ╰─┬─ button .battery-charging
//    ╰─┬─ centerbox
//      ╰─┬─ box
//        ├─┬─ revealer
//        │ ╰─┬─ box .sys-mng-data.battery-data
//        │   ╰─ label .battery-controller
//        ├─── icon .icon
//        ╰─── label
export function BatteryWidget() {
  return Widget.Box({
    className: 'sys-mng battery',
    vertical: false,
    child: Content(),
    setup: self => self
      .hook(BATTERY_WIDGET_IS_SHOW, () => self.toggleClassName('sys-mng-active', BATTERY_WIDGET_IS_SHOW.value))
      .hook(MEMO_BATTERY_CHARGING, () => self.toggleClassName('battery-disabled', MEMO_BATTERY_CHARGING.value)),
  });
}

