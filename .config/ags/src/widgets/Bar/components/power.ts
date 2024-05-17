import GLib from "types/@girs/glib-2.0/glib-2.0";
import Box from "types/widgets/box";
import Button from "types/widgets/button";
import Icon from "types/widgets/icon";

interface IState {
  show: Variable<boolean>;
  show_data: Variable<string>;
  timeout?: GLib.Source;
  timeout_duration: number;

  open(data: string): void;
  close(): void;
  clear_timeout(): void;
}

class State implements IState {
  show: Variable<boolean>;
  show_data: Variable<string>;
  timeout?: GLib.Source;
  timeout_duration: number = 5000;

  constructor() {
    this.show = Variable(false);
    this.show_data = Variable('');
  }

  open(data: string): void {
    this.show.setValue(true);
    this.show_data.setValue(data);
    this.clear_timeout();
    this.timeout = setTimeout(this.close.bind(this), this.timeout_duration);
  }

  close(): void {
    this.show.setValue(false);
    this.show_data.setValue('');
    this.clear_timeout();
  }

  clear_timeout(): void {
    if (this.timeout) clearTimeout(this.timeout);
  }
}

const STATE = new State();

function Content(): Button<any, unknown> {
  const onClicked = () => Utils.notify({
    timeout: 10_000,
    summary: "Power Management",
    body: "System will be suspended",
    iconName: 'system-shutdown-symbolic',
    actions: {
      Suspend: () => Utils.exec('systemctl suspend'),
      'Power off': () => Utils.exec('poweroff'),
    },
    urgency: 'low',
  });

  const centerWidget = Widget.Box({
    children: [
      Widget.Revealer({
        revealChild: false,
        transition: "slide_left",
        transitionDuration: 300,
        child: ContentData(),
        setup: self => self.bind('reveal_child', STATE.show),
      }),

      ContentIcon(),
    ]
  });

  return Widget.Button({
    onClicked,
    // onHover: () => STATE.open("Suspend | Power off"),
    child: Widget.CenterBox({
      centerWidget,
    }),
  });
}

function ContentData(): Box<any, unknown> {
  return Widget.Box({
    className: 'sys-mng-data power-data',
    children: [
      Widget.Label({
        className: 'power-controller',
        label: STATE.show_data.bind(),
      }),
    ],
  });
}

function ContentIcon(): Icon<any> {
  return Widget.Icon({
    className: 'icon',
    icon: 'system-shutdown-symbolic',
  })
}

// ------------------------------ //
//          POWER WIDGET          //
// ------------------------------ //
export function PowerWidget() {
  return Widget.Box({
    className: 'sys-mng power',
    vertical: false,
    child: Content(),
    setup: self => self
      .hook(STATE.show, () => self.toggleClassName('sys-mng-active', STATE.show.value))
  });
}

