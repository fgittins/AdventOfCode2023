function read_file(file)
    lines = readlines(file)
    platform = [lines[i][j] for i = 1:length(lines), j = 1:length(lines[1])]
end

function tilt!(platform)
    n, m = size(platform)
    for j = 1:m, i = 2:n
        if platform[i, j] ≡ 'O'
            for ii = i-1:-1:1
                if platform[ii, j] ≡ '.'
                    platform[ii, j] = 'O'
                    platform[ii+1, j] = '.'
                else
                    break
                end
            end
        end
    end
    nothing
end

function total_load(platform)
    n, m = size(platform)
    loads = []
    for j = 1:m, i = 1:n
        if platform[i, j] ≡ 'O'
            push!(loads, n - i + 1)
        end
    end
    sum(loads)
end

function cycle!(platform)
    for _ = 1:4
        tilt!(platform)
        platform .= rotr90(platform)
    end
    nothing
end

function many_cycles!(platform, n_cycles)
    seen = Dict{String, Int}()
    seen[join(platform)] = 0
    first = last = 0
    for n = 1:n_cycles
        cycle!(platform)
        if haskey(seen, join(platform))
            first = seen[join(platform)]
            last = n
            break
        else 
            seen[join(platform)] = n
        end
    end

    cycles_left = (n_cycles - last)%(last - first)
    for _ = 1:cycles_left
        cycle!(platform)
    end
end

function part1(platform)
    tilt!(platform)
    total_load(platform)
end

function part2(platform)
    n_cycles = 1_000_000_000
    many_cycles!(platform, n_cycles)
    total_load(platform)
end

platform = read_file("day14/input.txt")
part1_load = part1(platform)
part2_load = part2(platform)
println("Part 1: $part1_load; Part 2: $part2_load")
