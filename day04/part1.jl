function calculate_points_from_card(line)
    new_line1 = split(line, ": ")
    new_line2 = split(new_line1[2], " | ")
    winning_nums = split(new_line2[1])
    nums_you_have = split(new_line2[2])

    total_winning_nums = 0
    for num in nums_you_have
        if num in winning_nums
            total_winning_nums += 1
        end
    end
    points = 0
    if total_winning_nums >= 1
        points = 2^(total_winning_nums - 1)
    end
    points
end

function calculate_total_points(lines)
    total_points = 0
    for line in lines
        points = calculate_points_from_card(line)
        total_points += points
    end
    total_points
end

lines = readlines("day04/input.txt")
calculate_total_points(lines)
