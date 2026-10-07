#!/bin/bash
# Kasutaja sisendiga seotud funktsioonid

read_player_name() {
    local name
    echo -n "Sisesta oma nimi: " >&2
    read name
    if [ -z "$name" ]; then
        name="Kasutaja"
    fi
    echo "$name"
}

read_player_numbers() {
    local numbers=""
    local count=1
    local nr

    echo "" >&2
    echo "Sisesta 5 erinevat numbrit vahemikus 1–50:" >&2
    while [ $count -le 5 ]; do
        echo -n "Sisesta $count. number: " >&2
        read nr

        # Valideerimine: täisarv 1–50
        if ! [[ "$nr" =~ ^[0-9]+$ ]] || [ "$nr" -lt 1 ] || [ "$nr" -gt 50 ]; then
            echo "Viga! Sisesta täisarv vahemikus 1 kuni 50." >&2
            continue
        fi

        # Valideerimine: dublikaadid
        if echo "$numbers" | grep -qw "$nr"; then
            echo "Viga! Seda numbrit oled juba sisestanud." >&2
            continue
        fi

        numbers="$numbers $nr"
        count=$((count + 1))
    done
    echo "$numbers"
}
