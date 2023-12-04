lines = readlines("day3/input.txt")

"""
Return a matrix that places the numbers at all the points that the digits appear
in `lines`.
"""
function generate_table(lines)
    n = length(lines)
    m = length(lines[1])
    table = Matrix{String}(undef, n, m)
    for i = 1:n
        line = lines[i]
        num = ""
        js = Vector{Int64}()
        for j = 1:m
            if isdigit(line[j])
                num *= line[j]
                push!(js, j)
                
                if j == m
                    for k in js
                        table[i, k] = string(num)
                    end
                end
            else
                table[i, j] = string(line[j])
                for k in js
                table[i, k] = string(num)
                end
                # reset variables
                # this could be better optimised by not doing this for every symbol
                num = ""
                js = Vector{Int64}()
            end
        end
    end
    table
end

function get_adjacent_numbers(table, i, j)
    n, m = size(table)
    nums = Vector{Int64}()
    for I = i-1:i+1, J = j-1:j+1
        # ignore the middle point
        if I == i && J == j
            continue
        end
        # ignore coordinates outside `lines`
        if I == 0 || I == n+1 || J == 0 || J == m+1
            continue
        end

        if tryparse(Int64, table[I, J]) != nothing
            # check that number is not repeated
            if (J == j || J == j+1) && table[I, J] == table[I, J-1]
                continue
            end
            push!(nums, parse(Int64, table[I, J]))
        end
    end
    nums
end

function calculate_total_gear_ratio(table)
    n, m = size(table)
    total_gear_ratio = 0
    for i = 1:n, j = 1:m
        if table[i, j] == "*"
            nums = get_adjacent_numbers(table, i, j)
            if length(nums) == 2
                gear_ratio = 1
                for num in nums
                    gear_ratio *= num
                end
                total_gear_ratio += gear_ratio
            end
        end
    end
    total_gear_ratio
end

table = generate_table(lines)
calculate_total_gear_ratio(table)
