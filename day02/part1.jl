lines = readlines("day02/input.txt")

poss_ID = 0
for line in lines
    new_line = split(line, ": ")
    ID = parse(Int, split(new_line[1], " ")[end])
    handfuls = split(new_line[2], "; ")

    poss = true
    for handful in handfuls
        red_num = green_num = blue_num = 0
        colours_in_handful = split(handful, ", ")
        for string in colours_in_handful
            num, colour = split(string, " ")
            if "red" == colour
                red_num = parse(Int, num)
            elseif "green" == colour
                green_num = parse(Int, num)
            elseif "blue" == colour
                blue_num = parse(Int, num)
            end
        end
        if red_num > 12 || green_num > 13 || blue_num > 14
            poss = false
            break
        end
    end

    if poss
        global poss_ID += ID
    end
end
poss_ID
