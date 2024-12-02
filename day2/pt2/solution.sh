#!/bin/bash

total_safe_lines=0

is_safe() {
    local -n temp_numbers=$1
    local mode=""
    for ((i = 1; i < ${#temp_numbers[@]}; i++)); do
        local diff=$((temp_numbers[i-1] - temp_numbers[i]))

        if [[ $i -eq 1 ]]; then
            if [[ $diff -gt 0 ]]; then
                mode="increasing"
            elif [[ $diff -lt 0 ]]; then
                mode="decreasing"
            else
                return 1
            fi
        fi

        if [[ ($mode == "increasing" && $diff -le 0) || ($mode == "decreasing" && $diff -ge 0) ]]; then
            return 1
        fi

        if [[ $mode == "increasing" ]]; then
            if [[ $diff -lt 1 || $diff -gt 3 || ${temp_numbers[i-1]} -le ${temp_numbers[i]} ]]; then
                return 1
            fi
        elif [[ $mode == "decreasing" ]]; then
            if [[ $diff -gt -1 || $diff -lt -3 || ${temp_numbers[i-1]} -ge ${temp_numbers[i]} ]]; then
                return 1
            fi
        fi
    done
    return 0
}

check_safety() {
    local line="$1"
    read -a numbers <<< "$line"

    if is_safe numbers; then
        ((total_safe_lines++))
        return
    fi

    for ((n = 0; n < ${#numbers[@]}; n++)); do
        local temp_array=("${numbers[@]:0:$n}" "${numbers[@]:$((n + 1))}")
        if is_safe temp_array; then
            ((total_safe_lines++))
            return
        fi
    done
}

while IFS= read -r line; do
    check_safety "$line"
done < input.txt

echo "Number of safe lines: $total_safe_lines"
