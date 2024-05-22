import { Application } from "types/service/applications";
import Box from "types/widgets/box";

import { appLauncherStore as store } from "@store"
import NoiseBox, { NoiseVariant } from "@/components/noisebox";

function Content() {
  return Widget.CenterBox({
    className: 'container',
    startWidget: ContentLeft(),
    endWidget: Widget.Revealer({
      revealChild: false,
      transition: "slide_right",
      transitionDuration: 200,
      child: ContentRight(),
      setup: self => self.bind('reveal_child', store.isVisibleContent),
    }),
  });
}

export function ContentLeft(): Box<any, unknown> {
  const searchInput = Widget.Entry({
    className: 'search',
    vpack: 'start',
    hpack: 'center',
    hexpand: true,
    text: store.search.bind(),
    onChange: ({ text }) => {
      store.search.setValue(text || "");
      // class_name = store.search.value.length ? 'search search-active' : 'search';
    },
    onAccept: () => {
      const availableApps = store.applications.value.filter(app => app.match(store.search.value));
      if (!availableApps.length) return;

      try {
        availableApps[0].launch();
        store.close();
      } catch (err) {
        Utils.notify({
          summary: 'app-launcher error',
          body: err?.toString() || 'unknown error',
          iconName: 'applications-development',
          timeout: 6000,
          urgency: 'critical',
        });
      }
    },
    setup: self => self.bind('class_name', store.search, 'value', length => length ? 'search search-active' : 'search'),
  });

  return Widget.Box({
    className: 'left',
    hpack: 'start',
    child: Widget.Overlay({
      overlays: [
        // Widget.Box({ className: 'mask' }),
        searchInput,
      ],
      child: NoiseBox(NoiseVariant.GRADIENT, Widget
        .Box({ className: 'overlay left-overlay' })
        .bind('css', store.bg_image, 'value', () => `background-image: url("${store.use_bg_image}");`),
      )
    }),

    setup: self => self.hook(store.isVisibleContent, () => {
      if (!store.visible_content) return;
      searchInput.grab_focus();
    }),
  });
}

function ContentRight(): Box<any, unknown> {
  const applicationsList = Widget.Scrollable({
    className: 'applications-scroll',
    hscroll: 'never',
    child: Widget.Box({
      className: 'applications-list',
      vertical: true,
      children: store.search.bind().as(search => {
        let apps = store.applications.value;
        if (search) apps = apps.filter(app => app.match(search));
        return apps.map(AppItem);
      })
    }),
  });

  return Widget.Box({
    className: 'right',
    hpack: 'end',
    child: Widget.CenterBox({
      className: 'applications',
      vertical: true,
      // startWidget: searchInput,
      endWidget: applicationsList,
    }),
  });
}

function AppItem(app: Application) {
  const onClicked = () => {
    try {
      app.launch();
      store.close();
    } catch (err) {
      Utils.notify({
        summary: 'app-launcher error',
        body: err?.toString() || 'unknown error',
        iconName: 'applications-development',
        timeout: 6000,
        urgency: 'critical',
      });
    }
  }

  const applicationButton = Widget.Button({
    className: 'btn applicaion-button',
    onClicked,
    hexpand: true,
    child: Widget.Box([
      // ICON
      Widget.Icon({
        className: 'application-icon',
        size: 20,
        icon: app.icon_name
          ? Utils.lookUpIcon(app.icon_name)
            ? app.icon_name
            : "application-x-executable-symbolic"
          : "application-x-executable-symbolic"
      }),
      Widget.Overlay({
        overlays: [
          Widget.Label({
            // TITLE
            className: 'application-title',
            vpack: 'start',
            hpack: 'start',
            truncate: 'end',
            xalign: 0,
            label: app.name,
          }),
          // DESCRIPTION
          Widget.Label({
            className: 'application-description',
            vpack: 'center',
            hpack: 'start',
            truncate: 'end',
            xalign: 0,
            label: app?.description || '',
          }),
          // Executable
          Widget.Label({
            className: 'application-executable',
            vpack: 'end',
            hpack: 'start',
            truncate: 'end',
            xalign: 0,
            label: app?.executable || '',
          }),
        ],
        child: Widget.Box({ className: 'btn-overlay', hexpand: true }),
      }),
    ]),
  });

  return Widget.Box({
    className: 'application',
    child: applicationButton,
  });
}

// ------------------------------ //
//          APP LAUNCHER          //
// ------------------------------ //
export function AppLauncher(monitor: number = 0) {
  return Widget.Window({
    monitor,
    name: `app-launcher`,
    className: 'app-launcher',
    keymode: 'exclusive',
    exclusivity: 'exclusive',
    layer: 'overlay',
    visible: true,
    child: Content(),
    setup: self => self
      .bind('visible', store.isVisible)
      .keybind('Escape', () => store.close())
      .keybind(['CONTROL'], 'w', () => store.search.setValue(""))
  });
}

