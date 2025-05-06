#!/bin/bash

# Segundo monitor
xrandr --output HDMI-1-0 --auto --right-of eDP-2 &

# Start network manager
nm-applet &

# Start bluetooth tray
blueman-applet &

# Clipboard
copyq &

# Wallpaper
feh --bg-scale ~/Imagens/Wallpapers/lock.png &

# Notificações
dunst &

# Compositor
picom &

# Screenshot
flameshot &

# Discord
pgrep -x discord || discord &

# Bluetooth
pgrep -x blueman-applet || blueman-applet &

# Picom
pgrep -x picom || picom --config ~/.config/picom/picom.conf &
