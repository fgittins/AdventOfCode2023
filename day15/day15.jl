function read_input(file)
    sequence = []
    open(file, "r") do io
        for line ∈ eachsplit(read(io, String), "\n")
            if "" == line
                continue
            end
            for step ∈ eachsplit(line, ',')
                push!(sequence, step)
            end
        end
    end
    sequence
end

function hash_algorithm(string)
    current_value = 0
    for character ∈ string
        current_value = current_value + Int(character)
        current_value = current_value * 17
        current_value = current_value % 256
    end
    current_value
end

function run_on_sequence(sequence)
    values = []
    for step ∈ sequence
        value = hash_algorithm(step)
        push!(values, value)
    end
    sum(values)
end

function hashmap!(step, boxes)
    m = match(r"(.*)(=|-)(.*)", step)
    label, operation, focal_length = m

    box = hash_algorithm(label)

    if operation == "-"
        if haskey(boxes, box)
            for (slot, element) ∈ enumerate(boxes[box])
                lbl, fcl = element
                if lbl == label
                    deleteat!(boxes[box], slot)
                    break
                end
            end
        end
    elseif operation == "="
        if haskey(boxes, box)
            is_lens_with_label = false
            for (slot, element) ∈ enumerate(boxes[box])
                lbl, fcl = element
                if lbl == label
                    is_lens_with_label = true
                    deleteat!(boxes[box], slot)
                    insert!(boxes[box], slot, (label, focal_length))
                    break
                end
            end
            if !is_lens_with_label
                push!(boxes[box], (label, focal_length))
            end
        else
            boxes[box] = [(label, focal_length)]
        end
    end
    boxes
end

function total_focusing_power(sequence)
    boxes = Dict()
    for step ∈ sequence
        hashmap!(step, boxes)
    end

    total_power = 0
    for box ∈ keys(boxes)
        for (slot, element) ∈ enumerate(boxes[box])
            label, focal_length = element
            power = (box + 1) * slot * parse(Int, focal_length)
            total_power = total_power + power
        end
    end
    total_power
end

sequence = read_input("day15/input.txt")
part1 = run_on_sequence(sequence)
part2 = total_focusing_power(sequence)
println("Part 1: $part1; Part 2: $part2")
