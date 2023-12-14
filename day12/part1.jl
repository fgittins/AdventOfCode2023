function read_file(file)
    rows = []
    groups = []
    open(file, "r") do io
        for line ∈ eachline(io)
            new_line = split(line)
            push!(rows, new_line[1])
            push!(groups, parse.(Int, split(new_line[2], ',')))
        end
    end
    rows, groups
end

# credit: https://github.com/goggle/AdventOfCode2023.jl
function count_combinations(pattern, groups)
    count = 0
    if isempty(groups)
        '#' ∈ pattern && return 0
        return 1
    end
    length(pattern) < sum(groups) + length(groups) - 1 && return 0
    if '.' ∉ pattern[begin:groups[begin]]
        if length(pattern) ≡ groups[begin] || pattern[groups[begin]+1] ≠ '#'
            count += count_combinations(pattern[groups[begin]+2:end], groups[begin+1:end])
        end
    end
    if pattern[begin] ≠ '#'
        count += count_combinations(pattern[begin+1:end], groups)
    end
    count
end

function count_total_combinations(rows, groups)
    total = 0
    for (row, group) ∈ zip(rows, groups)
        total += count_combinations(row, group)
    end
    total
end

rows, groups = read_file("day12/input.txt")
count_total_combinations(rows, groups)
