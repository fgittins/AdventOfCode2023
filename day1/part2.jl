using DelimitedFiles

lines = readdlm("day1/input.txt", String)

Base.:(<)(::AbstractVector, ::Nothing) = true
Base.:(<)(::Nothing, ::AbstractVector) = false
Base.:(<)(::Nothing, ::Nothing) = false

"""
Searches string `line` for first instance of digit substring and replace all
instances of that substring in `line`.
"""
function replace_first(line)
    one_loc = findfirst("one", line)
    two_loc = findfirst("two", line)
    three_loc = findfirst("three", line)
    four_loc = findfirst("four", line)
    five_loc = findfirst("five", line)
    six_loc = findfirst("six", line)
    seven_loc = findfirst("seven", line)
    eight_loc = findfirst("eight", line)
    nine_loc = findfirst("nine", line)
    if one_loc < two_loc && one_loc < three_loc && one_loc < four_loc && one_loc < five_loc && one_loc < six_loc && one_loc < seven_loc && one_loc < eight_loc && one_loc < nine_loc
        new_line = replace(line, "one"=>'1')
    elseif two_loc < one_loc && two_loc < three_loc && two_loc < four_loc && two_loc < five_loc && two_loc < six_loc && two_loc < seven_loc && two_loc < eight_loc && two_loc < nine_loc
        new_line = replace(line, "two"=>'2')
    elseif three_loc < one_loc && three_loc < two_loc && three_loc < four_loc && three_loc < five_loc && three_loc < six_loc && three_loc < seven_loc && three_loc < eight_loc && three_loc < nine_loc
        new_line = replace(line, "three"=>'3')
    elseif four_loc < one_loc && four_loc < two_loc && four_loc < three_loc && four_loc < five_loc && four_loc < six_loc && four_loc < seven_loc && four_loc < eight_loc && four_loc < nine_loc
        new_line = replace(line, "four"=>'4')
    elseif five_loc < one_loc && five_loc < two_loc && five_loc < three_loc && five_loc < four_loc && five_loc < six_loc && five_loc < seven_loc && five_loc < eight_loc && five_loc < nine_loc
        new_line = replace(line, "five"=>'5')
    elseif six_loc < one_loc && six_loc < two_loc && six_loc < three_loc && six_loc < four_loc && six_loc < five_loc && six_loc < seven_loc && six_loc < eight_loc && six_loc < nine_loc
        new_line = replace(line, "six"=>'6')
    elseif seven_loc < one_loc && seven_loc < two_loc && seven_loc < three_loc && seven_loc < four_loc && seven_loc < five_loc && seven_loc < six_loc && seven_loc < eight_loc && seven_loc < nine_loc
        new_line = replace(line, "seven"=>'7')
    elseif eight_loc < one_loc && eight_loc < two_loc && eight_loc < three_loc && eight_loc < four_loc && eight_loc < five_loc && eight_loc < six_loc && eight_loc < seven_loc && eight_loc < nine_loc
        new_line = replace(line, "eight"=>'8')
    elseif nine_loc < one_loc && nine_loc < two_loc && nine_loc < three_loc && nine_loc < four_loc && nine_loc < five_loc && nine_loc < six_loc && nine_loc < seven_loc && nine_loc < eight_loc
        new_line = replace(line, "nine"=>'9')
    else
        new_line = line
    end
    new_line
end

Base.:(>)(::AbstractVector, ::Nothing) = true
Base.:(>)(::Nothing, ::AbstractVector) = false
Base.:(>)(::Nothing, ::Nothing) = false

"""
Searches string `line` for last instance of digit substring and replace all
instances of that substring in `line`.
"""
function replace_last(line)
    one_loc = findlast("one", line)
    two_loc = findlast("two", line)
    three_loc = findlast("three", line)
    four_loc = findlast("four", line)
    five_loc = findlast("five", line)
    six_loc = findlast("six", line)
    seven_loc = findlast("seven", line)
    eight_loc = findlast("eight", line)
    nine_loc = findlast("nine", line)
    if one_loc > two_loc && one_loc > three_loc && one_loc > four_loc && one_loc > five_loc && one_loc > six_loc && one_loc > seven_loc && one_loc > eight_loc && one_loc > nine_loc
        new_line = replace(line, "one"=>'1')
    elseif two_loc > one_loc && two_loc > three_loc && two_loc > four_loc && two_loc > five_loc && two_loc > six_loc && two_loc > seven_loc && two_loc > eight_loc && two_loc > nine_loc
        new_line = replace(line, "two"=>'2')
    elseif three_loc > one_loc && three_loc > two_loc && three_loc > four_loc && three_loc > five_loc && three_loc > six_loc && three_loc > seven_loc && three_loc > eight_loc && three_loc > nine_loc
        new_line = replace(line, "three"=>'3')
    elseif four_loc > one_loc && four_loc > two_loc && four_loc > three_loc && four_loc > five_loc && four_loc > six_loc && four_loc > seven_loc && four_loc > eight_loc && four_loc > nine_loc
        new_line = replace(line, "four"=>'4')
    elseif five_loc > one_loc && five_loc > two_loc && five_loc > three_loc && five_loc > four_loc && five_loc > six_loc && five_loc > seven_loc && five_loc > eight_loc && five_loc > nine_loc
        new_line = replace(line, "five"=>'5')
    elseif six_loc > one_loc && six_loc > two_loc && six_loc > three_loc && six_loc > four_loc && six_loc > five_loc && six_loc > seven_loc && six_loc > eight_loc && six_loc > nine_loc
        new_line = replace(line, "six"=>'6')
    elseif seven_loc > one_loc && seven_loc > two_loc && seven_loc > three_loc && seven_loc > four_loc && seven_loc > five_loc && seven_loc > six_loc && seven_loc > eight_loc && seven_loc > nine_loc
        new_line = replace(line, "seven"=>'7')
    elseif eight_loc > one_loc && eight_loc > two_loc && eight_loc > three_loc && eight_loc > four_loc && eight_loc > five_loc && eight_loc > six_loc && eight_loc > seven_loc && eight_loc > nine_loc
        new_line = replace(line, "eight"=>'8')
    elseif nine_loc > one_loc && nine_loc > two_loc && nine_loc > three_loc && nine_loc > four_loc && nine_loc > five_loc && nine_loc > six_loc && nine_loc > seven_loc && nine_loc > eight_loc
        new_line = replace(line, "nine"=>'9')
    else
        new_line = line
    end
    new_line
end

sum = 0
for line in lines
    # find first digit
    new_line1 = replace_first(line)
    nums1 = filter(isdigit, new_line1)
    first = nums1[begin]
    # find last digit
    new_line2 = replace_last(line)
    nums2 = filter(isdigit, new_line2)
    last = nums2[end]
    global sum += parse(Int, first * last)
end
sum
