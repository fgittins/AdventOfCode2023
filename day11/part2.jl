function read_file(file)
    data = readlines(file)
    image = collect.(data)
end

function find_empty(image)
    n, m = length(image), length(image[1])
    is = []
    for (i, row) in enumerate(image)
        if all(==('.'), row)
            push!(is, i)
        end
    end
    js = []
    for j = 1:m
        col = [image[i][j] for i = 1:n]
        if all(==('.'), col)
            push!(js, j)
        end
    end
    is, js
end

function find_galaxies(image)
    n, m = length(image), length(image[1])
    galaxy_locs = []
    for i = 1:n, j = 1:m
        if image[i][j] ≡ '#'
            push!(galaxy_locs, (i, j))
        end
    end
    galaxy_locs
end

function calculate_shortest_path(image; expansion=2)
    is, js = find_empty(image)
    galaxy_locs = find_galaxies(image)
    total_dist = 0
    while length(galaxy_locs) > 0
        galaxy_loc = popfirst!(galaxy_locs)
        for other_galaxy_loc in galaxy_locs
            expand = 0
            if galaxy_loc[1] ≥ other_galaxy_loc[1]
                i_max, i_min = galaxy_loc[1], other_galaxy_loc[1]
            else
                i_min, i_max = galaxy_loc[1], other_galaxy_loc[1]
            end
            if galaxy_loc[2] ≥ other_galaxy_loc[2]
                j_max, j_min = galaxy_loc[2], other_galaxy_loc[2]
            else
                j_min, j_max = galaxy_loc[2], other_galaxy_loc[2]
            end
            for i in is
                if i in i_min:i_max
                    expand += expansion - 1
                end
            end
            for j in js
                if j in j_min:j_max
                    expand += expansion - 1
                end
            end
            total_dist += i_max - i_min + j_max - j_min + expand
        end
    end
    total_dist
end

image = read_file("day11/input.txt")
calculate_shortest_path(image; expansion=1_000_000)
