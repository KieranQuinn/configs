#!/bin/sh

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
# mpd
mpd &
# compositor
xcompmgr -c -D5 -f &
# status bar
$HOME/Scripts/dwm-status.sh &
# start dwm
exec dwm
