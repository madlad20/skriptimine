#!/bin/bash
# Skript genereerib 5 erinevat lotonumbrit (1-50) ja salvestab või kuvab need

ajutine_fail="tmp_loto.txt"
> "$ajutine_fail" # Tühjendame vana ajutise faili, kui see on olemas

# Genereerime numbreid seni, kuni ajutises failis on täpselt 5 rida
while [ $(wc -l < "$ajutine_fail") -lt 5 ]; do
    # Moodustame juhusliku arvu vahemikus 1–50
    arv=$(( (RANDOM % 50) + 1 ))
    
    # Kontrollime, kas arv on juba ajutises failis olemas (-x nõuab täpset rea kattuvust)
    if ! grep -x -q "$arv" "$ajutine_fail"; then
        echo "$arv" >> "$ajutine_fail"
    fi
done

# Vormindame väljundi
numbrid=$(tr '\n' ' ' < "$ajutine_fail")
praegune_aeg=$(date "+%Y-%m-%d %H:%M:%S")

echo "----------------------------------------"
echo "Kuhu soovite tulemuse väljastada?"
echo "1) Terminali (stdout)"
echo "2) Salvestada faili koos kellaajaga"
echo -n "Valik (1 või 2): "
read valik

if [ "$valik" -eq 1 ]; then
    echo ""
    echo "Kuupäev ja kellaaeg: $praegune_aeg"
    echo "Genereeritud numbrid: $numbrid"
elif [ "$valik" -eq 2 ]; then
    echo -n "Sisesta faili nimi (nt lotonumbrid.txt): "
    read failinimi
    
    # Kui kasutaja eirab nime sisestamist, kasutame vaikimisi nime
    if [ -z "$failinimi" ]; then
        failinimi="lotonumbrid.txt"
    fi
    
    # Lisame tulemuse faili lõppu (ei kirjuta üle)
    echo "Aeg: $praegune_aeg | Numbrid: $numbrid" >> "$failinimi"
    echo "Tulemus edukalt salvestatud faili '$failinimi'."
else
    echo "Vigane valik! Kuvame tulemuse terminalis:"
    echo "Aeg: $praegune_aeg | Numbrid: $numbrid"
fi

# Kustutame ajutise faili
rm -f "$ajutine_fail"
