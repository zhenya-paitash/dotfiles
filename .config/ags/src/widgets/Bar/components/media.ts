import { MprisPlayer } from "types/service/mpris";
import Button from "types/widgets/button";
import Label from "types/widgets/label";
import { playerStore } from "@store"

const mpris = await Service.import('mpris');

const MEDIA_WIDGET_SHOW = Variable<boolean>(false);
let MEMO_CURRENT_MEDIA: string = '';
let MEMO_CURRENT_MEDIA_COVER: string = '';

function Content() {
  return Widget.Box({
    className: 'media',
    children: mpris.bind("players").as(getMediaButtons),
    setup: self => self.hook(MEDIA_WIDGET_SHOW, () => self.toggleClassName('media-active', MEDIA_WIDGET_SHOW.value)),
  });
}

function getMediaButtons(players: MprisPlayer[]): Button<any, unknown>[] {
  const mediaButtons: Button<any, unknown>[] = [];
  // TODO: switch to players[0] if this line not fix error media notification
  // for (const player of players) mediaButtons.push(createMediaButton(player));
  if (players.length) mediaButtons.push(createMediaButton(players[0]));
  return mediaButtons;
}

function createMediaButton(player: MprisPlayer): Button<any, unknown> {
  function onError(err: Error): void {
    Utils.notify({
      summary: 'mpris error',
      body: err?.toString() || 'unknown error',
      iconName: 'applications-development',
      timeout: 6000,
      urgency: 'critical',
    });
    console.error(err);
  }

  const onPrimaryClick = () => player.playPause().catch(onError);
  const onSecondaryClick = () => playerStore.toggle();
  const onMiddleClick = () => player.close();
  const onScrollUp = () => { if (player.can_go_prev) player.previous().catch(onError); }
  const onScrollDown = () => { if (player.can_go_next) player.next().catch(onError); }

  return Widget.Button({
    onPrimaryClick,
    onSecondaryClick,
    onMiddleClick,
    onScrollUp,
    onScrollDown,
    child: Widget.Label({
      class_name: "title",
      xalign: 0,
      justification: "left",
      hexpand: true,
      max_width_chars: 64,
      truncate: "end",
      wrap: true,
      use_markup: true,
    })
      .hook(player, widget => hookMediaButtonLabel(player, widget)),
  });
}

function hookMediaButtonLabel(player: MprisPlayer, widget: Label<any>): void {
  if (player.track_title === MEMO_CURRENT_MEDIA) return;
  let currentMedia = getPlayerLabel(player);
  widget.label = currentMedia;

  if (player.track_album) Utils.timeout(200, () => {
    if (!player.track_title) return;
    if (!player.track_album) return;
    if (!player.cover_path) return;
    if (MEMO_CURRENT_MEDIA_COVER === player.cover_path && player.track_title === MEMO_CURRENT_MEDIA) return;
    if (player.play_back_status !== "Playing") return;

    currentMedia = getPlayerLabel(player);
    widget.label = currentMedia;
    MEMO_CURRENT_MEDIA = player.track_title;
    MEMO_CURRENT_MEDIA_COVER = player.cover_path;

    Utils.notify({
      summary: 'Media',
      body: currentMedia,
      image: player.cover_path,
      timeout: 3_000,
      urgency: 'low',
    })
  });
}

function getPlayerLabel(player: MprisPlayer): string {
  const { track_artists, track_title } = player;
  let label: string = track_title;
  if (track_artists.join("").length) {
    if (track_artists.length > 3) {
      label = `<b>${track_artists.slice(0, 2).join(", ")}, ...</b> - ${track_title}`
    } else {
      label = `<b>${track_artists.join(", ")}</b> - ${track_title}`;
    }
  }

  return label;
}


// ------------------------------ //
//          MEDIA WIDGET          //
// ------------------------------ //
export function MediaWidget() {
  return Widget.Revealer({
    revealChild: false,
    transition: "slide_right",
    transitionDuration: 300,
    child: Content(),
    setup: self => self.bind('reveal_child', mpris, "players", player => {
      MEDIA_WIDGET_SHOW.setValue(player.length > 0);
      return MEDIA_WIDGET_SHOW.value;
    }),
  });
}

