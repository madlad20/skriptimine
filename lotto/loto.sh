#!/bin/bash
# Loto 5/50 mängu skript (funktsioonipõhine struktuur)

AJUTINE_FAIL="tmp_loto.txt"
TULEMUSED_FAIL="lotonumbrid.txt"

show_header() {
    echo "========================================"
    echo "           LOTO 5 / 50 MÄNG             "
    echo "========================================"
}

clear_files() {
    > "$AJUTINE_FAIL"
}

read_player() {
    echo -n "Sisesta oma nimi: "
    read mängija_nimi
    if [ -z "$mängija_nimi" ]; then
        mängija_nimi="Kasutaja"
    fi
}

read_player_numbers() {
    echo ""
    echo "Sisesta 5 erinevat numbrit vahemikus 1–50:"
    mängija_numbrid=""
    count=1
    
    while [ $count -le 5 ]; do
        echo -n "Sisesta $count. number: "
        read nr
        
        # Kontroll, kas sisend on täisarv vahemikus 1-50
        if ! [[ "$nr" =~ ^[0-9]+$ ]] || [ "$nr" -lt 1 ] || [ "$nr" -gt 50 ]; then
            echo "Viga! Sisesta arv vahemikus 1 kuni 50."
            continue
        fi
        
        # Kontroll, kas number on juba varem sisestatud
        if echo "$mängija_numbrid" | grep -qw "$nr"; then
            echo "Viga! Seda numbrit oled juba sisestanud."
            continue
        fi
        
        mängija_numbrid="$mängija_numbrid $nr"
        count=$((count + 1))
    done
}

show_player_numbers() {
    echo ""
    echo "Sinu valitud numbrid: $mängija_numbrid"
}

generate_lottery_numbers() {
    while [ $(wc -l < "$AJUTINE_FAIL") -lt 5 ]; do
        arv=$(( (RANDOM % 50) + 1 ))
        if ! grep -x -q "$arv" "$AJUTINE_FAIL"; then
            echo "$arv" >> "$AJUTINE_FAIL"
        fi
    done
    võidunumbrid=$(tr '\n' ' ' < "$AJUTINE_FAIL")
}

show_lottery_numbers() {
    echo "Loto võidunumbrid:    $võidunumbrid"
}

check_matches() {
    tabamused=0
    tabatud_numbrid=""
    for nr in $mängija_numbrid; do
        if grep -x -q "$nr" "$AJUTINE_FAIL"; then
            tabamused=$((tabamused + 1))
            tabatud_numbrid="$tabatud_numbrid $nr"
        fi
    done
}

show_result() {
    echo "----------------------------------------"
    echo "Tulemus: $mängija_nimi, täppi läks $tabamused numbrit 5-st!"
    if [ $tabamused -gt 0 ]; then
        echo "Tabatud numbrid: $tabatud_numbrid"
    fi
    echo "----------------------------------------"
}

save_result() {
    echo -n "Kas soovid tulemuse salvestada faili? (j/n): "
    read valik
    if [ "$valik" = "j" ] || [ "$valik" = "J" ]; then
        praegune_aeg=$(date "+%Y-%m-%d %H:%M:%S")
        echo "Aeg: $praegune_aeg | Mängija: $mängija_nimi | Sinu numbrid: $mängija_numbrid | Võidunumbrid: $võidunumbrid | Tabamused: $tabamused" >> "$TULEMUSED_FAIL"
        echo "Tulemus edukalt salvestatud faili '$TULEMUSED_FAIL'."
    fi
    rm -f "$AJUTINE_FAIL"
}

# ========================================
#          PROGRAMMI PÕHIOSA
# ========================================
show_header
clear_files
read_player
read_player_numbers
show_player_numbers
generate_lottery_numbers
show_lottery_numbers
check_matches
show_result
save_result
