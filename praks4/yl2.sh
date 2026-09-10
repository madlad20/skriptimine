#!/bin/bash

echo -n "Sisesta reisijate arv: "
read reisijad

echo -n "Sisesta kohtade arv bussis: "
read kohad

bussid=$((reisijad / kohad))
jaak=$((reisijad % kohad))

if [ $jaak -gt 0 ]; then
    bussid=$((bussid + 1))
fi

echo "Kokku on vaja $bussid bussi"
