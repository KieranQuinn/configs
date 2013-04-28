#!/bin/sh

icons=("Ñ" "Î" "¨" "¹" "ê" "í" "È")

getCPU() {
    cpu="$(eval $(awk '/^cpu /{print "previdle="$5";prevtotal="$2+$3+$4+$5}' /proc/stat);sleep 0.4;eval $(awk '/^cpu /{print "idle="$5";total="$2+$3+$4+$5}' /proc/stat);intervaltotal=$((total-${prevtotal:-0}));echo -ne "$((100*((intervaltotal)-($idle-${previdle:-0}))/(intervaltotal)))")"    
    echo -ne "\x0A${icons[0]}\x01${cpu}%"
}

getMEM() {
    mem="$(free -m | awk '/-\/+/ {print $3}')"
    echo -ne "\x0A${icons[1]}\x01 ${mem}MB"
}

getHDD() {
    hdd="$(df | awk '/dev\/sda3/ {print $5}') $(df | awk '/dev\/sda4/ {print $5}')"
    echo -ne "\x0A${icons[2]}\x01 ${hdd}"
}

getUpdates() {
    upd="$(pacman -Qu | wc -l)"
    echo -ne "\x0A${icons[3]}\x01 ${upd} updates"
}

getMusic() {
    msc="$(ncmpcpp --now-playing '{%a - %t}|{%f}')"
    if [ ! $msc ]; then
        echo -ne "\x0A${icons[4]}\x01 no music"
    else
        echo -ne "\x0A${icons[4]}\x01 ${msc}" 
    fi
}

getVolume() {
    vol="$(amixer get PCM | awk '/Front Left:/ {print $5}' | tr -dc '0-9')"
    echo -ne "\x0A${icons[5]}\x01 ${vol}%"
}

getTime() {
    tme="$(date '+ %H:%M')"
    echo -ne "\x0A${icons[6]}\x01 ${tme}"
}

while true; do
    xsetroot -name "$(getCPU) $(getMEM) $(getHDD) $(getUpdates) $(getMusic) $(getVolume) $(getTime)"
    sleep 2
done
