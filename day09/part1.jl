function read_file(file)
    histories = []
    open(file, "r") do io
        for line ∈ eachline(io)
            new_line = split(line)
            push!(histories, parse.(Int, new_line))
        end
    end
    histories
end

function extrapolate(history)
    differences = [history]
    i = 0
    while !iszero(differences[end])
        i += 1
        push!(differences, diff(differences[i]))
    end
    val = 0
    for j = i:-1:1
        val += differences[j][end]
    end
    val
end

function sum_extrapolate(histories)
    sum = 0
    for history ∈ histories
        sum += extrapolate(history)
    end
    sum
end

histories = read_file("day09/input.txt")
sum_extrapolate(histories)
