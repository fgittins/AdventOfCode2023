function read_input(file)
    open(file, "r") do io
        time = parse.(Int, filter(x -> !isspace(x), split(readline(io), ":")[2]))
        distance_record = parse.(Int, filter(x -> !isspace(x), split(readline(io), ":")[2]))
        return time, distance_record
    end
end

function solve_hold_button_quadratic(time, distance_record)
    hold_button_min = (time - √(time^2 - 4*distance_record))/2
    hold_button_max = (time + √(time^2 - 4*distance_record))/2
    floor(Int, hold_button_min + 1), ceil(Int, hold_button_max - 1)
end

time, distance_record = read_input("day06/input.txt")
hold_button_min, hold_button_max = solve_hold_button_quadratic(time, distance_record)
hold_button_max - hold_button_min + 1
