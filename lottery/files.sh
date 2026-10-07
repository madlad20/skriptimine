#!/bin/bash
# Failidega seotud funktsioonid

clear_temp_file() {
    local target_file="$1"
    > "$target_file"
}

save_result_to_file() {
    local file="$1"
    local timestamp="$2"
    local name="$3"
    local player_nums="$4"
    local win_nums="$5"
    local matches="$6"

    echo "Aeg: $timestamp | Mängija: $name | Sinu numbrid: $player_nums | Võidunumbrid: $win_nums | Tabamused: $matches" >> "$file"
    return $?
}
