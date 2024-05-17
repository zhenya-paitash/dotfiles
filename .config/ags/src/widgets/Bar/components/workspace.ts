import { Workspace } from "types/service/hyprland";
import Button from "types/widgets/button";

const hyprland = await Service.import('hyprland')

const WORKSPACE_WIDGET_SHOW = Variable<boolean>(false);

function Content() {
  return Widget.Box({
    className: 'workspace',
    children: hyprland.bind('workspaces').as(getWorkspaceButtons),
    setup: self => self.hook(WORKSPACE_WIDGET_SHOW, () => self.toggleClassName('workspace-active', WORKSPACE_WIDGET_SHOW.value)),
  });
}


function getWorkspaceButtons(wss: Workspace[]) {
  const goToWorkspace = (id: string | number) => hyprland.messageAsync(`dispatch workspace ${id}`);

  const workspaceButtons: Button<any, unknown>[] = [];
  for (const ws of wss) {
    if (ws.id < 0) continue;
    workspaceButtons[ws.id] = Widget.Button({
      onClicked: () => goToWorkspace(ws.id),
      onScrollUp: () => goToWorkspace("-1"),
      onScrollDown: () => goToWorkspace("+1"),
      className: hyprland.active.workspace.bind('id').as(id => id === ws.id ? 'current' : ''),
      child: Widget.Label(),
    });
  }

  return workspaceButtons;
}


// ------------------------------ //
//        WORKSPACE WIDGET        //
// ------------------------------ //
export function WorkspaceWidget() {
  return Widget.Revealer({
    revealChild: false,
    transition: "slide_left",
    transitionDuration: 100,
    child: Content(),
    setup: self => self.bind('reveal_child', hyprland, 'workspaces', wss => {
      WORKSPACE_WIDGET_SHOW.setValue(wss.filter(ws => ws.id >= 0).length > 1);
      return WORKSPACE_WIDGET_SHOW.value;
    }),
  });
}

