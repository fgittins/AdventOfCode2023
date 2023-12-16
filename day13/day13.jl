function read_input(file)
    open(file, "r") do io
        patterns = []
        for pattern ∈ eachsplit(read(io, String), "\n\n")
            lines = []
            for line ∈ eachsplit(pattern, '\n')
                if "" == line
                    continue
                end
                push!(lines, line)
            end
            pm = [lines[i][j] for i=1:length(lines), j=1:length(lines[1])]
            push!(patterns, pm)
        end
        return patterns
    end
end

function find_reflection(pattern; n_smudge=0)
    n, m = size(pattern)

    for i = 1:n-1
        n_diffs = 0
        δ = 1
        while 0 < i - δ + 1 && i + δ ≤ n
            n_diffs += sum(pattern[i - δ + 1, :] .≠ pattern[i + δ, :])
            if n_diffs > n_smudge
                break
            end
            δ += 1
        end
        if n_diffs ≡ n_smudge
            return i
        end
    end
    0
end

function summarize(patterns; n_smudge=0)
    value = 0
    for pattern ∈ patterns
        row = find_reflection(pattern; n_smudge=n_smudge)
        col = 0
        if row ≡ 0
            col = find_reflection(rotr90(pattern); n_smudge=n_smudge)
        end
        value += col + 100*row
    end
    value
end

patterns = read_input("day13/input.txt")
part1 = summarize(patterns; n_smudge=0)
part2 = summarize(patterns; n_smudge=1)
println("Part 1: $part1; Part 2: $part2")
