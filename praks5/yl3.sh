#!/bin/bash

echo -n "Sisesta aja väärtus (tund 0-23): "
read tund

if [ $tund -ge 6 -a $tund -lt 12 ]; then
    echo "Tere hommikust!"
elif [ $tund -ge 12 -a $tund -lt 18 ]; then
    echo "Tere päevast!"
elif [ $tund -ge 18 -a $tund -lt 22 ]; then
    echo "Tere õhtust!"
elif [ \( $tund -ge 22 -a $tund -lt 24 \) -o \( $tund -ge 0 -a $tund -lt 6 \) ]; then
    echo "Head ööd!"
else
    echo "Vigane sisend! Sisesta tund vahemikus 0 kuni 23."
fi
