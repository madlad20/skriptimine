#!/bin/bash

tund=$(date +%-H)
kasutaja=$(whoami)

if [ $tund -ge 6 -a $tund -lt 12 ]; then
    echo "Tere hommikust, $kasutaja!"
elif [ $tund -ge 12 -a $tund -lt 18 ]; then
    echo "Tere päevast, $kasutaja!"
elif [ $tund -ge 18 -a $tund -lt 22 ]; then
    echo "Tere õhtust, $kasutaja!"
else
    echo "Head ööd, $kasutaja!"
fi
