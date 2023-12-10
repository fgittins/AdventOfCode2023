function read_file(file)
    open(file, "r") do io
        tiles = readlines(io)
        return tiles
    end
end

function find_start(tiles)
    n, m = length(tiles), length(tiles[1])
    I, J = 0, 0
    for i = 1:n, j = 1:m
        if tiles[i][j] ≡ 'S'
            I, J = i, j
            break
        end
    end
    I, J
end

function step(i, j, direction, tiles)
    tile = tiles[i][j]
    if direction ≡ 'N'
        if tile ≡ '|'
            i_new = i - 1
            j_new = j
            direction_new = direction
        elseif tile ≡ '7'
            i_new = i
            j_new = j - 1
            direction_new = 'W'
        elseif tile ≡ 'F'
            i_new = i
            j_new = j + 1
            direction_new = 'E'
        end
    elseif direction ≡ 'E'
        if tile ≡ '-'
            i_new = i
            j_new = j + 1
            direction_new = direction
        elseif tile ≡ 'J'
            i_new = i - 1
            j_new = j
            direction_new = 'N'
        elseif tile ≡ '7'
            i_new = i + 1
            j_new = j
            direction_new = 'S'
        end
    elseif direction ≡ 'S'
        if tile ≡ '|'
            i_new = i + 1
            j_new = j
            direction_new = direction
        elseif tile ≡ 'L'
            i_new = i
            j_new = j + 1
            direction_new = 'E'
        elseif tile ≡ 'J'
            i_new = i
            j_new = j - 1
            direction_new = 'W'
        end
    elseif direction ≡ 'W'
        if tile ≡ '-'
            i_new = i
            j_new = j - 1
            direction_new = direction
        elseif tile ≡ 'L'
            i_new = i - 1
            j_new = j
            direction_new = 'N'
        elseif tile ≡ 'F'
            i_new = i + 1
            j_new = j
            direction_new = 'S'
        end
    end
    i_new, j_new, direction_new
end

function traverse_loop(tiles)
    i, j = find_start(tiles)
    locations = [(i, j)]
    j = j - 1
    push!(locations, (i, j))
    direction = 'W'
    while tiles[i][j] ≠ 'S'
        i, j, direction = step(i, j, direction, tiles)
        push!(locations, (i, j))
    end
    locations
end

tiles = read_file("day10/input.txt")
locations = traverse_loop(tiles)

# for each point not on the loop, count intersections with the loop to the left
# of it, except if they are '-', 'J' or 'L'
# meeting '-', 'J' or 'L' means you are following the boundary in a tangent way
inside = 0
for i = 1:length(tiles), j = 1:length(tiles[1])
    if !((i, j) ∈ locations)
        counter = length([(i, l) for l ∈ 1:j if (i, l) ∈ locations && !(tiles[i][l] ∈ ['-', 'J', 'L'])])
        global inside += counter % 2
    end
end
inside
