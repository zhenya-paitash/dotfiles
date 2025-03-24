import Box from "types/widgets/box";

import { NotificationWidget } from "./components/notification";
import { notificationsStore as store } from "@store"

function Content(): Box<any, unknown> {
  const onNotified = (widget: Box<any, unknown>) => (_: Box<any, unknown>, id: number) => {
    const notif = store.notifications.getNotification(id);
    if (notif) widget.children = [NotificationWidget(notif), ...widget.children];
  }

  const onDismissed = (widget: Box<any, unknown>) => (_: Box<any, unknown>, id: number) => {
    widget.children.find(notif => notif.attribute.id === id)?.destroy();
  }

  return Widget.Box({
    vertical: true,
    children: store.notifications.popups.map(NotificationWidget),
    setup: self => self
      .hook(store.notifications, onNotified(self), "notified")
      .hook(store.notifications, onDismissed(self), "dismissed"),
  });
}


// ------------------------------ //
//         NOTIFICATIONS          //
// ------------------------------ //
export function Notifications(monitor: number = 0) {
  return Widget.Window({
    monitor,
    name: `notifications-${monitor}`,
    className: 'notification-popups',
    // anchor: ['top'],
    // margins: [0, 0, 0, 0],
    anchor: ['top', 'right'],
    margins: [0, 8, 0, 0],
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
        setup: self => self.bind('reveal_child', store.notifications, 'popups', popups => popups.length > 0),
      }),
      setup: self => self
        .bind('class_name', store.notifications, 'popups', popups => {
          return popups.length > 0 ? 'notifications notifications-active' : 'notifications';
        })
    }),
  })
}

