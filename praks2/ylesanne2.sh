#!/bin/bash

echo -n "Sisesta aluskandiku pikkus cm: "
read pikkus

echo -n "Sisesta aluskandiku laius cm: "
read laius

echo -n "Sisesta küpsise pikkus cm: "
read kypsise_pikkus

echo -n "Sisesta küpsise laius cm: "
read kypsise_laius

echo -n "Mitu kihti torti soovid: "
read kihid

echo -n "Mitu küpsist on ühes pakis: "
read pakis

alus_pindala=$(expr $pikkus \* $laius)
kypsise_pindala=$(expr $kypsise_pikkus \* $kypsise_laius)
kypsised_kihis=$(expr $alus_pindala / $kypsise_pindala)
kypsised_kokku=$(expr $kypsised_kihis \* $kihid)

pakid=$(expr $kypsised_kokku / $pakis)
jaak=$(expr $kypsised_kokku % $pakis)

if [ $jaak -ne 0 ]; then
    pakid=$(expr $pakid + 1)
fi

echo "Vaja on osta $pakid pakki küpsiseid."
