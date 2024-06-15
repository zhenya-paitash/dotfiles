import { SectionLeft, SectionCenter, SectionRight } from "./sections"


// ------------------------------ //
//              BAR               //
// ------------------------------ //
export function Bar(monitor: number = 0) {
  return Widget.Window({
    monitor,
    name: `bar-${monitor}`,
    // anchor: ['top', 'left', 'right'],
    // margins: [2, 560, 0, 560],
    anchor: ['bottom', 'left', 'right'],
    margins: [0, 560, 5, 560],
    className: 'bar',
    exclusivity: 'exclusive',
    layer: 'top',

    child: Widget.CenterBox({
      className: 'bar-container',
      vertical: false,
      startWidget: SectionLeft(),
      centerWidget: SectionCenter(),
      endWidget: SectionRight(),
    }),
  })
}

