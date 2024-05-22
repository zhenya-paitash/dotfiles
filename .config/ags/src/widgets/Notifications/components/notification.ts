import NoiseBox, { NoiseVariant } from "@/components/noisebox";
import { Notification } from "types/service/notifications";
import Box from "types/widgets/box";

function Content(notif: Notification) {
  const children = [
    Widget.Box({
      children: [
        Widget.Box({
          className: 'notification-icon',
          vpack: 'start',
          hpack: 'center',
          child: ContentIcon(notif),
        }),

        ContentData(notif),
      ],
    }),

    ContentActions(notif),
  ];

  // return Widget.Box({
  //   className: `notification ${notif.urgency}`,
  //   vexpand: true,
  //   vertical: true,
  //   children,
  // });

  return NoiseBox({
    variant: NoiseVariant.DEFAULT,
    opacity: 0.1,
  }, Widget.Box({
    className: `notification ${notif.urgency}`,
    vexpand: true,
    vertical: true,
    children,
  }));
}

function ContentIcon({ app_entry, app_icon, image }: Notification) {
  if (image) {
    return Widget.Box({
      // expand: true,
      className: 'image',
      css: `background-image: url("${image}");`,
    });
  }

  let icon: string = 'dialog-information-symbolic';
  if (Utils.lookUpIcon(app_icon)) icon = app_icon;
  if (app_entry && Utils.lookUpIcon(app_entry)) icon = app_entry;

  return Widget.Box({
    child: Widget.Icon({
      className: 'icon',
      icon
    }),
  });
}

function ContentData(notif: Notification): Box<any, unknown> {
  const title = Widget.Label({
    class_name: "title",
    xalign: 0,
    justification: "left",
    hexpand: true,
    max_width_chars: 24,
    truncate: "end",
    wrap: true,
    label: notif.summary,
    use_markup: true,
  });

  const body = Widget.Label({
    class_name: "body",
    hexpand: true,
    use_markup: true,
    xalign: 0,
    justification: "left",
    label: notif.body,
    wrap: true,
  });

  return Widget.Box({
    className: 'notification-data',
    vertical: true,
    vpack: 'start',
    children: [
      title,
      body,
    ],
  });
}

function ContentActions(notif: Notification): Box<any, unknown> {
  return Widget.Box({
    className: 'notification-actions',
    children: notif.actions.map(action => Widget.Button({
      className: 'action-button',
      onClicked: () => {
        notif.invoke(action.id);
        notif.dismiss();
      },
      hexpand: true,
      child: Widget.Label(action.label),
    })),
  });
}


// ------------------------------ //
//       NOTIFICATION WIDGET      //
// ------------------------------ //
export function NotificationWidget(notif: Notification) {
  return Widget.EventBox({
    attribute: { id: notif.id },
    onPrimaryClick: notif.dismiss,
    child: Content(notif),
  });
}

