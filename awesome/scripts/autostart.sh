#!/bin/bash

# Evitar múltiplas execuções
function run {
  if ! pgrep -x "$1" > /dev/null ; then
    "$@" &
  fi
}

# Inicializar Gnome Keyring (para cookies, senhas, ssh)
if [ -z "$SSH_AUTH_SOCK" ]; then
    eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh,gpg)
    export SSH_AUTH_SOCK
fi

# Segundo monitor
xrandr --output HDMI-1-0 --auto --right-of eDP-2 &

# Compositor para transparência e blur
run picom --config ~/.config/picom/picom.conf

# Wallpaper
feh --bg-scale ~/Imagens/Wallpapers/lock.png &

# Applets de sistema
run nm-applet         # Ícone de rede Wi-Fi
run blueman-applet    # Bluetooth manager
run copyq             # Gerenciador de clipboard
run flameshot         # Ferramenta de screenshots
# run dunst             # Sistema de notificações

# Bloqueio automático de tela (opcional)
xautolock -time 10 -locker "betterlockscreen -l" &

# Sincronização de hora via NTP (opcional)
# run systemctl start systemd-timesyncd.service

# Programas pessoais no boot
run discord
# run pavucontrol  # Controle de áudio (volume)

