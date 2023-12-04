function calculate_matching_nums_from_card(line)
    new_line1 = split(line, ": ")
    new_line2 = split(new_line1[2], " | ")
    winning_nums = split(new_line2[1])
    nums_you_have = split(new_line2[2])

    total_matching_nums = 0
    for num in nums_you_have
        if num in winning_nums
            total_matching_nums += 1
        end
    end
    total_matching_nums
end

function calculate_card_instances(lines)
    n = length(lines)
    instances = ones(Int64, n)
    for i = 1:n
        matching_nums = calculate_matching_nums_from_card(lines[i])
        if matching_nums != 0
            for j = i+1:i+matching_nums
                instances[j] += instances[i]
            end
        end
    end
    instances
end

lines = readlines("day4/input.txt")
sum(calculate_card_instances(lines))
