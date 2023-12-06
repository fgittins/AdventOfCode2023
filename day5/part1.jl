"""
Take puzzle input and return `seeds` as a Vector and `maps`, which is a Vector
that contains each `map` with `dest_range` and `src_range` UnitRanges.
"""
function read_input(file)
    open(file, "r") do io
        seeds = parse.(Int64, split(split(readline(io), ": ")[2]))
        maps = []
        for (i, map) ∈ enumerate(eachsplit(read(io, String), "\n\n"))
            push!(maps, [])
            for line ∈ eachsplit(map, "\n")
                if "" == line
                    continue
                elseif occursin(':', line)
                    continue
                else
                    dest_start, src_start, len = parse.(Int64, split(line))
                    push!(maps[i], (dest_start:dest_start+len-1, src_start:src_start+len-1))
                end
            end
        end
        return seeds, maps
    end
end

"Return `locs` for given `seeds`."
function seeds_to_locs(seeds, maps)
    for map in maps
        mapped_seeds = copy(seeds)
        for (i, seed) ∈ enumerate(seeds)
            for (dest_range, src_range) ∈ map
                if seed ∈ src_range
                    mapped_seeds[i] = seed + dest_range[1] - src_range[1]
                    break
                end
            end
        end
        seeds = mapped_seeds
    end
    locs = seeds
end

seeds, maps = read_input("day5/input.txt")
locs = seeds_to_locs(seeds, maps)
minimum(locs)
