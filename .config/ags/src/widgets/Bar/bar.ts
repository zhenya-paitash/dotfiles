import { SectionLeft, SectionCenter, SectionRight } from "./sections"


// ------------------------------ //
//              BAR               //
// ------------------------------ //
export function Bar(monitor: number = 0) {
  return Widget.Window({
    monitor,
    name: `bar-${monitor}`,
    // default: for `bar` style
    // anchor: ['top', 'left', 'right'],
    // margins: [2, 10, 0, 10],

    // center: for `bar.center.*` style
    anchor: ['bottom', 'left', 'right'],
    margins: [0, 720, 0, 720],
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

