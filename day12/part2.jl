using Memoize

function read_file(file)
    rows = String[]
    groups = []
    open(file, "r") do io
        for line ∈ eachline(io)
            new_line = split(line)
            push!(rows, new_line[1])
            push!(groups, Tuple(parse.(Int, split(new_line[2], ','))))
        end
    end
    rows, groups
end

# credit: https://github.com/goggle/AdventOfCode2023.jl
@memoize function count_combinations(pattern, groups)
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

function unfold(rows, groups)
    new_rows = String[]
    new_groups = []
    for (row, group) ∈ zip(rows, groups)
        push!(new_rows, row * ('?' * row)^4)
        push!(new_groups, Tuple(repeat(collect(group), 5)))
    end
    new_rows, new_groups
end

rows, groups = read_file("day12/input.txt")
new_rows, new_groups = unfold(rows, groups)
count_total_combinations(new_rows, new_groups)
