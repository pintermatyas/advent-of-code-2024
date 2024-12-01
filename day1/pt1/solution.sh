#!/bin/bash
input="input.txt"


left_list=($(awk '{print $1}' "$input"))
right_list=($(awk '{print $2}' "$input"))

sorted_left=($(printf "%s\n" "${left_list[@]}" | sort -n))
sorted_right=($(printf "%s\n" "${right_list[@]}" | sort -n))

total_distance=0

for i in "${!sorted_left[@]}"; do
  diff=$((sorted_left[i] - sorted_right[i]))
  abs_diff=${diff#-}
  total_distance=$((total_distance + abs_diff))
done

echo "Total distance: $total_distance"
