lines = readlines("day02/input.txt")

sum_of_power = 0
for line in lines
    new_line = split(line, ": ")
    ID = parse(Int, split(new_line[1], " ")[end])
    handfuls = split(new_line[2], "; ")

    red_min = green_min = blue_min = 0
    for handful in handfuls
        colours_in_handful = split(handful, ", ")
        for string in colours_in_handful
            num, colour = split(string, " ")
            num = parse(Int, num)
            if "red" == colour && num > red_min
                red_min = num
            elseif "green" == colour && num > green_min
                green_min = num
            elseif "blue" == colour && num > blue_min
                blue_min = num
            end
        end
    end

    global sum_of_power += red_min * green_min * blue_min
end
sum_of_power
