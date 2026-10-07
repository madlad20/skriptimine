#!/bin/bash
# Numbrite genereerimise ja kontrolli funktsioonid

generate_lottery_numbers() {
    local temp_file="$1"
    local arv

    while [ $(wc -l < "$temp_file") -lt 5 ]; do
        arv=$(( (RANDOM % 50) + 1 ))
        if ! grep -x -q "$arv" "$temp_file"; then
            echo "$arv" >> "$temp_file"
        fi
    done
    tr '\n' ' ' < "$temp_file"
}

check_matches() {
    local player_nums="$1"
    local temp_file="$2"
    local count=0
    local nr

    for nr in $player_nums; do
        if grep -x -q "$nr" "$temp_file"; then
            count=$((count + 1))
        fi
    done
    return $count
}

get_matched_numbers() {
    local player_nums="$1"
    local temp_file="$2"
    local matched=""
    local nr

    for nr in $player_nums; do
        if grep -x -q "$nr" "$temp_file"; then
            matched="$matched $nr"
        fi
    done
    echo "$matched"
}
