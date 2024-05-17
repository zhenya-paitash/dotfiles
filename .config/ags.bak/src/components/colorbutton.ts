import { Style } from "types/@girs/gtk-3.0/gtk-3.0.cjs";
import { ButtonProps } from "types/widgets/button";

interface ColorButtonProps extends ButtonProps {
  bg?: string;
  fg?: string;
}

export function ColorButton(props: ColorButtonProps) {
  if (!props.bg || !props.fg) return Widget.Button(props);

  let css: string = "";
  if (props.css) css = props.css as string;
  if (props.bg) css += `background-color: ${props.bg};`;
  if (props.fg) css += `color: ${props.fg};`;

  return Widget.Button({
    ...props,
    css,
  });
}

