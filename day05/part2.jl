"""
Take puzzle input and return `seeds` as a Vector and `maps`, which is a Vector
that contains each `map` with `dest_range` and `src_range` UnitRanges.
"""
function read_input(file)
    open(file, "r") do io
        seeds = parse.(Int64, split(split(readline(io), ": ")[2]))
        maps = []
        for (i, map) in enumerate(eachsplit(read(io, String), "\n\n"))
            push!(maps, [])
            for line in eachsplit(map, "\n")
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

"Return `loc_ranges` for given `seed_ranges`."
function seed_ranges_to_loc_ranges(seed_ranges, maps)
    for map ∈ maps
        mapped_seed_ranges = []
        while length(seed_ranges) > 0
            seed_range = popfirst!(seed_ranges)
            is_seed_range_mapped = false
            for (dest_range, src_range) ∈ map
                matching_range = seed_range ∩ src_range
                if length(matching_range) == 0
                    continue
                end
                mapped_seed_range = matching_range .+ (dest_range[1] - src_range[1])
                push!(mapped_seed_ranges, mapped_seed_range)
                if length(mapped_seed_range) ≠ length(seed_range)
                    if seed_range[1] < src_range[1]
                        residual = seed_range[1]:src_range[1]-1
                        push!(seed_ranges, residual)
                    end
                    if seed_range[end] > src_range[end]
                        residual = src_range[end]+1:seed_range[end]
                        push!(seed_ranges, residual)
                    end
                end
                is_seed_range_mapped = true
                break
            end
            if is_seed_range_mapped ≡ false
                push!(mapped_seed_ranges, seed_range)
            end
        end
        seed_ranges = mapped_seed_ranges
    end
    loc_ranges = seed_ranges
end

seeds, maps = read_input("day05/input.txt")
seed_ranges = broadcast(:, seeds[1:2:end], seeds[1:2:end] .+ seeds[2:2:end] .- 1)
loc_ranges = seed_ranges_to_loc_ranges(seed_ranges, maps)
minimum([x[1] for x in loc_ranges])
