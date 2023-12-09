function read_file(file)
    open(file, "r") do io
        instructions = readline(io)
        readline(io)
        network = Dict{String, Tuple{String, String}}()
        for line ∈ eachline(io)
            m = match(r"(.*) = \((.*), (.*)\)", line)
            first, second, third = m
            network[first] = (second, third)
        end
        return instructions, network
    end
end

function count_steps_until_ZZZ(instructions, network)
    node = "AAA"
    i = 0
    while node ≠ "ZZZ"
        i += 1
        instruction = instructions[(i - 1) % length(instructions) + 1]
        if instruction ≡ 'L'
            node = network[node][begin]
        elseif instruction ≡ 'R'
            node = network[node][end]
        end
    end
    i
end

instructions, network = read_file("day08/input.txt")
count_steps_until_ZZZ(instructions, network)
