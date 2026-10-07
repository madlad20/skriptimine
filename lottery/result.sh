#!/bin/bash
# Väljundite kuvamise funktsioonid

show_header() {
    echo "========================================"
    echo "           LOTO 5 / 50 MÄNG             "
    echo "========================================"
}

show_player_numbers() {
    local numbers="$1"
    echo ""
    echo "Sinu valitud numbrid: $numbers"
}

show_lottery_numbers() {
    local numbers="$1"
    echo "Loto võidunumbrid:    $numbers"
}

show_result() {
    local name="$1"
    local matches="$2"
    local matched_nums="$3"

    echo "----------------------------------------"
    echo "Tulemus: $name, täppi läks $matches numbrit 5-st!"
    if [ "$matches" -gt 0 ]; then
        echo "Tabatud numbrid: $matched_nums"
    fi
    echo "----------------------------------------"
}
