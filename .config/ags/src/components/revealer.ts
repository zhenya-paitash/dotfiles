import Gtk from "types/@girs/gtk-3.0/gtk-3.0";
import { Binding } from "types/service";
import { RevealerProps } from "types/widgets/revealer";

interface IRevealerProps extends RevealerProps {
  children?: Gtk.Widget[] | Binding<any, any, Gtk.Widget[]> | undefined;
}

export function Revealer(props: IRevealerProps) {
  let child = props.child;
  if (props.children) child = Widget.Box({ children: props.children });
  return Widget.Revealer({ ...props, child });
}
