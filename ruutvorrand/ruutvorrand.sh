#!/bin/bash
# Skript lahendab ruutvõrrandi Ax^2 + Bx + C = 0 ja väljastab lahendid viie komakohaga

# 1. Kontrolli, et kasutaja sisestas täpselt kolm argumenti
if [ $# -ne 3 ]; then
    echo "Viga: Palun sisesta täpselt 3 kordajat (A, B ja C)."
    echo "Kasutamine: $0 A B C"
    echo "Näiteks: $0 1 -3 2"
    exit 1
fi

A=$1
B=$2
C=$3

# 2. Kontrolli, et A ei oleks 0
if [ $(echo "$A == 0" | bc -l) -eq 1 ]; then
    echo "Viga: Kordaja A ei tohi olla 0!"
    exit 1
fi

# 3. Arvuta diskriminant D = B^2 - 4AC
D=$(echo "$B * $B - 4 * $A * $C" | bc -l)

# 4. Kontrolli diskriminandi väärtust ja leia lahendid
if [ $(echo "$D > 0" | bc -l) -eq 1 ]; then
    # D > 0: Kaks reaalarvulist lahendit
    x1=$(echo "(-($B) + sqrt($D)) / (2 * $A)" | bc -l)
    x2=$(echo "(-($B) - sqrt($D)) / (2 * $A)" | bc -l)
    
    printf "Võrrandil on kaks lahendit:\n"
    printf "x1 = %.5f\n" "$x1"
    printf "x2 = %.5f\n" "$x2"

elif [ $(echo "$D == 0" | bc -l) -eq 1 ]; then
    # D = 0: Üks reaalarvuline lahend
    x=$(echo "(-($B)) / (2 * $A)" | bc -l)
    
    printf "Võrrandil on üks lahend:\n"
    printf "x = %.5f\n" "$x"

else
    # D < 0: Reaalarvulisi lahendeid ei ole
    echo "Reaalarvulisi lahendeid ei ole"
fi
