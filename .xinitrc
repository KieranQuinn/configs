#!/bin/sh

export XDG_MENU_PREFIX=gnome-

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# wallpaper
$HOME/.fehbg
# keyboard
setxkbmap gb
# terminal
urxvtd -q -o -f &
# compositor
xcompmgr -c -D5 -f &
# status bar
# $HOME/Scripts/dwm-status.sh &
# start dwm
exec dwm
