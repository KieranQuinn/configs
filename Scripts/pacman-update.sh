#!/bin/sh

pacman -Rscn $(pacman -Qtdq)
pacman -Sc
pacman-optimize && sync

exit 0