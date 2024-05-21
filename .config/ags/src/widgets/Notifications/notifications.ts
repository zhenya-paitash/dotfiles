import Box from "types/widgets/box";

import { NotificationWidget } from "./components/notification";

const notifications = await Service.import("notifications")

// const NOTIFICATIONS_WIDGET_IS_SHOW = Variable<boolean>(false);

function Content(): Box<any, unknown> {
  const onNotified = (widget: Box<any, unknown>) => (_, id: number) => {
    const notif = notifications.getNotification(id);
    if (notif) widget.children = [NotificationWidget(notif), ...widget.children];
  }

  const onDismissed = (widget: Box<any, unknown>) => (_, id: number) => {
    widget.children.find(notif => notif.attribute.id === id)?.destroy();
  }

  return Widget.Box({
    vertical: true,
    children: notifications.popups.map(NotificationWidget),
    setup: self => self
      .hook(notifications, onNotified(self), "notified")
      .hook(notifications, onDismissed(self), "dismissed"),
  });
}


// ------------------------------ //
//         NOTIFICATIONS          //
// ------------------------------ //
// window .notification-popups
//   box .notifications [  ~  add 'revealer'
//
//     eventbox
//       box .notification ${notification.urgency}
//         box [
//
//           box .notification-icon
//             box || box icon .icon
//
//           box .notification-data [
//             label .title
//             label .body
//           ]
//
//           box .notification-actions [
//             button .action-button
//               label
//           ]
//
//         ]
//
//     ]
export function Notifications(monitor: number = 0) {
  return Widget.Window({
    monitor,
    name: `notifications-${monitor}`,
    className: 'notification-popups',
    anchor: ['top'],
    margins: [0, 0, 0, 0],

    // margins: [-34, 0, 0, 0],

    // anchor: ['top', 'right'],
    // margins: [0, 8, 0, 0],
    layer: 'overlay',

    child: Widget.Box({
      className: "notifications",
      css: "min-width: 320px; min-height: 2px;",
      vertical: true,
      child: Widget.Revealer({
        reveal_child: false,
        transition: 'slide_down',
        transition_duration: 300,
        child: Content(),
        setup: self => self.bind('reveal_child', notifications, 'popups', popups => popups.length > 0),
      }),
      setup: self => self
        .bind('class_name', notifications, 'popups', popups => {
          return popups.length > 0 ? 'notifications notifications-active' : 'notifications';
        })
    }),
  })
}

