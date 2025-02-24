#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Eroare: programul ruleaza cu un singur argument."
    exit 1
fi

fisier_in=$1
fisier_out="rezultat.html"


if [ ! -f "$fisier_in" ]; then
    echo "Eroare: fisierul $fisier_in nu exista"
    exit 1
fi

ind=0
spatii=4

indentare() {
    local n=$1
    for ((i=0; i<n; i++)); do
        printf " "
    done
}

echo -n ""> "$fisier_out" 

while IFS= read -r line; do
    line=$(echo "$line" | awk '{$1=$1; print}')

    if echo "$line" | grep -qE '^</'; then
        ind=$((ind - spatii))
    fi


    indentare "$ind" >> "$fisier_out"
    echo "$line" >> "$fisier_out"

    if echo "$line" | grep -qE '^<[^/!?][^>]*[^/]>$'; then
        ind=$((ind + spatii))
    fi
done < "$fisier_in"

echo "fisierul indentat este salvat in: $fisier_out"