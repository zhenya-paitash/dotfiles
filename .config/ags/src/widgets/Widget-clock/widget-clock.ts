import dateService from "@/services/date.service";

function Content() {
  return Widget.CenterBox({
    className: 'widget-clock',
    startWidget: Widget.Label()
      .bind('label', dateService, 'date', ({ hour, minute }) => `${hour}:${minute}`),
  });
}

// ------------------------------ //
//          WIDGET CLOCK          //
// ------------------------------ //
export function WidgetClock(monitor: number = 0) {
  return Widget.Window({
    monitor,
    name: `widget-clock-${monitor}`,
    className: 'widgets',
    anchor: ['left', 'bottom'],
    margins: [0, 0, 20, 0],
    layer: "background",
    canFocus: false,
    focus_on_click: false,
    sensitive: false,

    child: Content(),
  });
}

