#!/bin/bash
input="input.txt"


left_list=($(awk '{print $1}' "$input"))
right_list=($(awk '{print $2}' "$input"))

total_distance=0

for i in "${!left_list[@]}"; do
  count_in_right=$(printf "%s\n" "${right_list[@]}" | grep -c "${left_list[i]}")
  echo "count in right: ${count_in_right}"
  total_distance=$((total_distance + (left_list[i]*count_in_right)))
done

echo "Total distance: $total_distance"
