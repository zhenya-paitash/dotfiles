const hyprland = await Service.import('hyprland')

interface Monitor {
  id: number;
}

function MonitorButton(monitor: Monitor) {
  return Widget.Button({
    className: 'monitor',
  });
}

// ------------------------------ //
//         MONITORS WIDGET        //
// ------------------------------ //
export function MonitorsWidget() {
  // const monitors1 = hyprland.bind('monitors');
  console.log(hyprland.monitors);

  // TODO: get all monitors
  const monitors: Monitor[] = [
    { id: 1 },
    { id: 2 },
  ];

  const children = monitors.map(monitor => MonitorButton(monitor));

  return Widget.Box({
    className: 'monitors',
    vpack: 'center',
    hpack: 'center',
    vertical: true,
    children,
  });
}
