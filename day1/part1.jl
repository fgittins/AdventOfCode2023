using DelimitedFiles

lines = readdlm("day1/input.txt", String)

sum = 0
for line in lines
    nums = filter(isdigit, line)
    global sum += parse(Int, nums[begin] * nums[end])
end
sum
