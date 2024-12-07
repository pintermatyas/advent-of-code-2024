total = 0

def check_permutation(target, array):
    def next_permutation(index, current_value):
        if index == len(array):
            return current_value == target
        return (
            next_permutation(index + 1, current_value + array[index]) or
            next_permutation(index + 1, current_value * array[index]) or
            next_permutation(index + 1, int(str(current_value) + str(array[index])))
        )
    return next_permutation(1, array[0])

with open("input.txt", "r") as file:
    for line in file:
        parts = line.split(":")
        if len(parts) == 2:
            target = int(parts[0].strip())
            array = list(map(int, parts[1].split()))
            if check_permutation(target, array):
                total+=target


print(f"Total: {total}")
