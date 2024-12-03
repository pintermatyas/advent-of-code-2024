#!/usr/bin/bash

while IFS= read -r line; do
    echo $(echo $line | grep -o 'mul([0-9]\+,[0-9]\+)' | \
        sed -E 's/mul\(([0-9]+),([0-9]+)\)/\1 * \2/' | bc | awk '{sum += $1} END {print sum}')
done < input.txt
