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

function extrapolate_back(history)
    differences = [history]
    i = 0
    while !iszero(differences[end])
        i += 1
        push!(differences, diff(differences[i]))
    end
    val = 0
    for j = i:-1:1
        val = differences[j][begin] - val
    end
    val
end

function sum_extrapolate_back(histories)
    sum = 0
    for history ∈ histories
        sum += extrapolate_back(history)
    end
    sum
end

histories = read_file("day09/input.txt")
sum_extrapolate_back(histories)
