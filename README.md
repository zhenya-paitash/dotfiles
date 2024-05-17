# Arch Linux

#### my install roadmap

> WARNING: None of the following is an installation guide, these are just my rough steps for setting up Arch Linux for the first time.
<details>
    <summary>show</summary>

```
sudo pacman -S neovim git xf86-video-amdgpu power-profiles-daemon
``` 

- install go, yay

```
sudo pacman -S wlroots wayland wayland-protocols hyprland
``` 

- config /etc/pacman.conf /etc/locale.gen

```
sudo pacman -S kitty python python-gobject xorg-server-xwayland yazi nwg-look firefox fish
``` 

- copy this config

```
sudo pacman -S jq starship lazygit
``` 

```
sudo pacman -S fisher
``` 

```
fisher install jorgebucaran/nvm.fish jethrokuan/z catppuccin/fish patrickf1/fzf.fish
``` 

- nvm: install node, add to .bashrc, add to fish_variables

```
sudo pacman -S alsa-utils tmux tpm alsa-plugins wl-clipboard cliphist libnotify brightnessctl fzf ripgrep fd bat unrar ttf-droid rustup
```

- rustup install rust

```
sudo pacman -S imagemagick noto-fonts noto-fonts-emoji eza zoxide pavucontrol 
```

```
yay -S hyprpicker aylurs-gtk-shell
```

- install bun

```
sudo pacman -S bluez bluez-utils mpv man xh jless
```

```
yay -S simple-mtpfs
```

```
sudo pacman -S openssh
```

- setup github config & ssh key for github


</details>


