#!/bin/sh

# add these to net-install
# this script
# base-devel gtk-engine-murrine yaourt gksu manjaro-pulse

repo=("https://github.com/KieranQuinn/dwm.git" "https://github.com/configs.git")
pkg=("skype" "transmission-gtk" "rxvt-unicode" "pcmanfm" "file-roller" "geany" "vlc" "feh" "lxappearance" "dmenu")
aur=("google-chrome" "ohsnap")

if [ "whoami" != root ]; then
	echo "This script requires root privileges."
	exit
fi

cloneRepos() {
	echo "Cloning repositories.."
	git clone ${repo[@]}
	# copy configs to ~/
	sudo cp -r configs/* $HOME
	rm -r configs
	# move dwm to ~/Build
	mkdir $HOME/Build
	mv dwm $HOME/Build
}

installPkgs() {
	echo "Installing packages.."
	pacman -S ${pkg[@]}
	# aur
	cd $HOME
	yaourt -G ${aur[@]}
	for i in "${aur[@]}"
	do
		cd $HOME/$i && makepkg -i
		rm -r $HOME/$i
	done
}

