input_file="input.txt"

mapfile -t grid < "$input_file"

rows=${#grid[@]}
cols=${#grid[0]}

xmas_count=0

check_xmas() {
    row=$1
    column=$2

    word=""

    for i in {0..2}; do
        for j in {0..2}; do
            x=$((row + i))
            y=$((column + j))
            if ((x < 0 || x >= rows || y < 0 || y >= cols)); then
                return 1
            fi
            word+="${grid[x]:y:1}"
        done
    done

    [[ "$word" =~ ^(M.S.A.M.S|S.S.A.M.M|M.M.A.S.S|S.M.A.S.M)$ ]]
}

for r in $(seq 0 $((rows - 1))); do
    for c in $(seq 0 $((cols - 1))); do
        if check_xmas "$r" "$c"; then
            ((xmas_count++))
        fi
    done
done

echo $xmas_count
