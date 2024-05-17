import Gtk from "types/@girs/gtk-3.0/gtk-3.0";
import Overlay, { OverlayProps } from "types/widgets/overlay";

import options, { OptionsStyleNoiseVariant } from "@/options";

export enum NoiseVariant {
  DEFAULT = 'default',
  GRADIENT = 'gradient',
  GRADIENT2 = 'gradient2',
  LINEGRADIENT = 'linegradient',
  NONE = 'none',
}

interface NoiseProps {
  variant: NoiseVariant;
  opacity?: number;
}

export default function NoiseBox(props: NoiseProps | NoiseVariant, ...children: Gtk.Widget[]): Overlay<any, any, unknown> {
  // if props instanceof NoiseVariant convert props to NoiseProps
  if (typeof props === 'string') props = {
    variant: props,
  } as NoiseProps;

  const noise: OptionsStyleNoiseVariant = options.style.noise[props.variant];
  const css = ""
    + `background-image: url("${noise.bg}");`
    + `opacity: ${props.opacity || noise.opacity || 0.4};`;

  const overlayProps: OverlayProps = {
    passThrough: true,
    overlay: Widget.Box({
      vexpand: true,
      hexpand: true,
      canFocus: false,
      canDefault: false,
      className: 'noise-overlay',
      css,
    }),
  };

  let child: Gtk.Widget | undefined = undefined;
  if (children.length === 1) {
    child = children[0];
  } else if (children.length > 1) {
    child = Widget.Box(children);
  } else {
    child = Widget.Box();
  }

  return Widget.Overlay({ ...overlayProps, child });
}

