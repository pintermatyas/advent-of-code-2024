#!/usr/bin/bash

enabled=true
total=0

while IFS= read -r component; do
        if [[ $component == "do()"  ]]; then enabled=true;
        elif [[ $component == "don't()" ]]; then enabled=false;
        elif [[ $component =~ mul\(([0-9]+),([0-9]+)\) ]]; then
            if [[ $enabled == "true" ]]; then
                multiplication=$(echo $component | sed -E 's/mul\(([0-9]+),([0-9]+)\)/\1 * \2/' | bc)
                total=$(( total + multiplication))
            fi
        fi
done < <(grep -o "\(mul([0-9]\+,[0-9]\+)\|do()\|don't()\)" input.txt)

echo "Total: $total"
