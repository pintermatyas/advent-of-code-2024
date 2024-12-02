total_safe_lines=0

while IFS= read -r line; do
    read -a numbers <<< "$line"

    safe=true
    mode=increasing
    for ((i = 1; i < ${#numbers[@]}; i++)); do
        diff=$((numbers[i-1] - numbers[i]))
        if [[ $i -eq 1 ]]; then
            if [[ $diff -gt 0 ]]; then
                mode="increasing"
            elif [[ $diff -lt 0 ]]; then
                mode="decreasing"
            fi
        fi
        if [[ ($mode == "increasing" && $diff -le 0)  || ( $mode == "decreasing" && $diff -ge 0 ) ]] && [[ $i -ne 1 ]]; then
            safe=false;
        fi
        if [[ $mode == "increasing" ]]; then
            if [[ $diff -lt 1 ||$diff -gt 3 || ${numbers[i-1]} -le ${numbers[i]} ]]; then
    	        safe=false
            fi
	elif [[ $mode == "decreasing" ]]; then
            if [[ $diff -gt "-1" || $diff -lt "-3" || ${numbers[i-1]} -ge ${numbers[i]} ]]; then
                safe=false
            fi
        fi
    done
    if [ $safe == "true" ]; then
        total_safe_lines=$((total_safe_lines+1))
    fi
done < input.txt
echo "Number of safe lines: $total_safe_lines"
