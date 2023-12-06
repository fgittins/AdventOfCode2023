function read_input(file)
    open(file, "r") do io
        times = parse.(Int, split(readline(io))[2:end])
        distance_records = parse.(Int, split(readline(io))[2:end])
        return times, distance_records
    end
end

function distance_travelled(hold_button, time)
    if hold_button ≡ 0 || hold_button ≥ time
        return 0
    end
    speed = hold_button
    distance = speed * (time - hold_button)
end

function ways_to_win(time, distance_record)
    ways_to_win = []
    has_started_winning = false
    for hold_button = 1:time
        distance = distance_travelled(hold_button, time)
        if distance > distance_record
            push!(ways_to_win, hold_button)
            has_started_winning = true
        elseif has_started_winning
            break
        end
    end
    ways_to_win
end

function multiply_number_of_ways(times, distance_records)
    value = 1
    for (time, distance_record) ∈ zip(times, distance_records)
        ways = ways_to_win(time, distance_record)
        number_of_ways = length(ways)
        value = value * number_of_ways
    end
    value
end

times, distance_records = read_input("day06/input.txt")
multiply_number_of_ways(times, distance_records)
