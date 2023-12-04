lines = readlines("day3/input.txt")

function is_symbol_adjacent(lines, i, js)
    n = length(lines)
    m = length(lines[1])
    for I = i-1:i+1
        for j = js[begin]-1:js[end]+1
            # ignore the number itself
            if I == i && j in js
                continue
            # ignore coordinates outside `lines`
            elseif I == 0 || I == n+1 || j == 0 || j == m+1
                continue
            # identify symbol
            elseif !isdigit(lines[I][j]) && lines[I][j] != '.'
                return true
            end
        end
    end
    false
end

sum = 0
n = length(lines)
m = length(lines[1])
for i = 1:n
    line = lines[i]
    num = ""
    js = Vector{Int64}()
    for j = 1:m
        if isdigit(line[j])
            num *= line[j]
            push!(js, j)
            
            if j == m
                if is_symbol_adjacent(lines, i, js)
                    global sum += parse(Int64, num)
                end
            end
        else
            if length(js) >= 1 && is_symbol_adjacent(lines, i, js)
                global sum += parse(Int64, num)
            end
            
            # reset variables
            # this could be better optimised by not doing this for every symbol
            num = ""
            js = Vector{Int64}()
        end
    end
end
sum
