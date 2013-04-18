#!/bin/sh

pacman -Syu
pacman -Rscn $(pacman -Qtdq)
pacman -Sc
pacman-optimize && sync

exit 0
