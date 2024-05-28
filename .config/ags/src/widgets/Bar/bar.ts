import { SectionLeft, SectionCenter, SectionRight } from "./sections"


// ------------------------------ //
//              BAR               //
// ------------------------------ //
export function Bar(monitor: number = 0) {
  return Widget.Window({
    monitor,
    name: `bar-${monitor}`,
    anchor: ['top', 'left', 'right'],
    className: 'bar',
    exclusivity: 'exclusive',
    layer: 'top',

    child: Widget.CenterBox({
      className: 'bar-container',
      vertical: false,
      startWidget: SectionLeft(),
      // centerWidget: SectionCenter(),
      // endWidget: SectionRight(),
      centerWidget: SectionRight(),
    }),
  })
}

