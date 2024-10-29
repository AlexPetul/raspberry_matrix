lst = [9, 8, 7, 1, 3, 9, 3, 2, 1, 0, 9, 0, 6, 7, 6, 4, 8, 9, 3, 4, 8, 8, 1, 0, 0, 0, 3, 5, 5, 8, 3, 9, 6, 4, 3, 2, 4, 3,
       5, 6, 8, 8, 9, 0, 0, 1, 2, 1]

print(len(lst))
start = 0
iterations = 9

for x in range(iterations):
    new_list = []
    if x == 0:
        new_list = lst[:16]
    elif x == 9:
        new_list = lst[32:]
    else:
        old_start = start
        multiplier = divmod(old_start, 16)[0] * 16
        line = 1
        while line <= 4:
            j = (4 * line) + multiplier
            counter = 0
            for i in range(start, j):
                counter += 1
                new_list.append(lst[i])
                
            
            for ix in range(4 - counter):
                new_list.append(lst[i + 13])
                i += 1

            start += 4
            line += 1

        start = old_start

    start += 1
    if start % 4 == 0:
        start += 12

    print(f"Iteration {x + 1}: ", new_list)
