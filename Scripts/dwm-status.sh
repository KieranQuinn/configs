#!/bin/sh

getCPU() {
	cpu="$(eval $(awk '/^cpu /{print "previdle=" $5 "; prevtotal=" $2+$3+$4+$5 }' /proc/stat); sleep 0.4; eval $(awk '/^cpu /{print "idle=" $5 "; total=" $2+$3+$4+$5 }' /proc/stat); intervaltotal=$((total-${prevtotal:-0})); echo "$((100*((intervaltotal)-($idle-${previdle:-0}) )/(intervaltotal)))")"    
	echo -e "\x0AÑ\x01 ${cpu}%"
}

getRAM() {
	mem="$(free -m | awk '/-\/+/ {print $3}')"
	echo -e "\x0AÎ\x01 ${mem}MB"
}

getHDD() {
	root="$(df | awk '/dev\/sda3/ {print $5}')"
	home="$(df | awk '/dev\/sda4/ {print $5}')"
	echo -e "\x0A¨\x01 ${root} ${home}"
}

getMusic() {
	song="$(ncmpcpp --now-playing '{{{{%a \uE01B }%t}}|{%f}}' | head -c 75)"
	[[ ! $song ]] && echo -e "\x0Aê\x01 no music" || echo -e "\x0Aê\x01 ${song}" 
}

getVolume() {
	status="$(amixer -D pulse sget Master | awk '/Front Left:/ {print $6}' | tr -dc "a-z")"
	[[ $status = "on" ]] && echo -e "\x0Aí\x01 $(amixer -D pulse sget Master | awk '/Front Left:/ {print $5}' | tr -dc "0-9")%" || echo -e "\x0Aí\x01 muted"
}

getDate() {
	datetime="$(date '+%H:%M')"
  	echo -e "\x0AÈ\x01 ${datetime}"
}

while true; do
	xsetroot -name "$(getCPU) $(getRAM) $(getHDD) $(getMusic) $(getVolume) $(getDate) "
	sleep 2
done
