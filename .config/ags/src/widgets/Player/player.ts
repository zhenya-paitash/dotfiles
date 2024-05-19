

import { playerStore as store } from "@store"
// import store from './player.store'
import NoiseBox, { NoiseVariant } from "@/components/noisebox";

function Content() {
  // Utils.interval(2000, () => store.toggle());

  // return Widget.CenterBox({
  //   className: 'container',
  //   startWidget: Widget.Revealer({
  //     revealChild: false,
  //     transition: "slide_left",
  //     transitionDuration: 200,
  //     child: PlayerContent(),
  //     setup: self => self
  //       .bind('reveal_child', store.isVisibleContent)
  //   }),
  //   endWidget: PlayerCover(),
  // });

  // return NoiseBox(NoiseVariant.DEFAULT, Widget.CenterBox({
  //   className: 'container',
  //   startWidget: Widget.Revealer({
  //     revealChild: false,
  //     transition: "slide_left",
  //     transitionDuration: 200,
  //     child: PlayerContent(),
  //     setup: self => self
  //       .bind('reveal_child', store.isVisibleContent)
  //   }),
  //   endWidget: PlayerCover(),
  // }));

  // return Widget.Overlay({
  //   child: Widget.CenterBox({
  //     className: 'container',
  //     startWidget: Widget.Revealer({
  //       revealChild: false,
  //       transition: "slide_left",
  //       transitionDuration: 200,
  //       child: PlayerContent(),
  //       setup: self => self
  //         .bind('reveal_child', store.isVisibleContent)
  //     }),
  //     endWidget: PlayerCover(),
  //   }),
  // });

  return Widget.Box({

  });

}

function PlayerContent() {
  return Widget.Box({
    className: 'content',
    child: Widget.Label('Content')
  });
}

function PlayerCover() {
  return Widget.Button({
    hpack: 'end',
    className: 'cover',
    onClicked: () => store.close(),
    child: Widget.Label('Cover'),
  });
}


// ------------------------------ //
//         PLAYER WIDGET          //
// ------------------------------ //
export function Player(monitor: number = 0) {
  return Widget.Window({
    monitor,
    name: `player`,
    className: 'player',
    layer: 'overlay',
    anchor: ["top", "left"],
    // margins: [10, 0, 0, 17],
    child: Content(),
    setup: self => self
      .bind('visible', store.isVisible)
      .keybind('Escape', () => store.close())
  });
}

