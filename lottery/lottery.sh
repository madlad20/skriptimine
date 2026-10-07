#!/bin/bash
# Loto mängu peamine käivitusfail

SCRIPT_DIR="$(dirname "$0")"

# Laadime abifailid
source "$SCRIPT_DIR/files.sh"
source "$SCRIPT_DIR/input.sh"
source "$SCRIPT_DIR/lottery_functions.sh"
source "$SCRIPT_DIR/result.sh"

AJUTINE_FAIL="tmp_loto.txt"
TULEMUSED_FAIL="lotonumbrid.txt"

main() {
    show_header
    clear_temp_file "$AJUTINE_FAIL"

    local player_name
    player_name=$(read_player_name)

    local player_numbers
    player_numbers=$(read_player_numbers)
    show_player_numbers "$player_numbers"

    local lottery_numbers
    lottery_numbers=$(generate_lottery_numbers "$AJUTINE_FAIL")
    show_lottery_numbers "$lottery_numbers"

    check_matches "$player_numbers" "$AJUTINE_FAIL"
    local matches=$?

    local matched_numbers
    matched_numbers=$(get_matched_numbers "$player_numbers" "$AJUTINE_FAIL")

    show_result "$player_name" "$matches" "$matched_numbers"

    echo -n "Kas soovid tulemuse salvestada faili? (j/n): "
    read valik
    if [ "$valik" = "j" ] || [ "$valik" = "J" ]; then
        local timestamp
        timestamp=$(date "+%Y-%m-%d %H:%M:%S")
        if save_result_to_file "$TULEMUSED_FAIL" "$timestamp" "$player_name" "$player_numbers" "$lottery_numbers" "$matches"; then
            echo "Tulemus edukalt salvestatud faili '$TULEMUSED_FAIL'."
        else
            echo "Viga tulemuse salvestamisel!"
        fi
    fi

    rm -f "$AJUTINE_FAIL"
}

main
