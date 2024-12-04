input_file="input.txt"

mapfile -t grid < "$input_file"

rows=${#grid[@]}
cols=${#grid[0]}

xmas_count=0

check_xmas() {
    row=$1
    column=$2
    dir_row=$3
    dir_column=$4

    word=""

    for i in {0..3}; do
        x=$((row + i * dir_row))
        y=$((column + i * dir_column))
        if ((x < 0 || x >= rows || y < 0 || y >= cols)); then
            return 1
        fi
        word+="${grid[x]:y:1}"
    done

    [[ "$word" == "XMAS" ]]
}

for row in $(seq 0 $((rows - 1))); do
    for col in $(seq 0 $((cols - 1))); do
        for dir_row in -1 0 1; do
            for dir_col in -1 0 1; do
                if ((dir_row == 0 && dir_col == 0)); then
                    continue
                fi
                if check_xmas "$row" "$col" "$dir_row" "$dir_col"; then
                    ((xmas_count++))
                fi
            done
        done
    done
done

echo $xmas_count
