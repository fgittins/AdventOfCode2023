function read_file(file)
    data = readlines(file)
    image = collect.(data)
end

function expand(image)
    n, m = length(image), length(image[1])
    new_image = deepcopy(image)
    count_row = 0
    for (i, row) in enumerate(image)
        if all(==('.'), row)
            insert!(new_image, i + count_row, row)
            count_row += 1
        end
    end
    count_col = 0
    for j = 1:m
        col = [image[i][j] for i = 1:n]
        if all(==('.'), col)
            for i = 1:m+count_row
                insert!(new_image[i], j + count_col, '.')
            end
            count_col += 1
        end
    end
    new_image
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

function calculate_shortest_path(image)
    galaxy_locs = find_galaxies(image)
    total_dist = 0
    while length(galaxy_locs) > 0
        galaxy_loc = popfirst!(galaxy_locs)
        for other_galaxy_loc in galaxy_locs
            dist = abs(galaxy_loc[1] - other_galaxy_loc[1]) + abs(galaxy_loc[2] - other_galaxy_loc[2])
            total_dist += dist
        end
    end
    total_dist
end

image = read_file("day11/input.txt")
new_image = expand(image)
calculate_shortest_path(new_image)
