function char_to_num(char::Char)
    if char ≡ 'T'
        return 10
    elseif char ≡ 'J'
        return 11
    elseif char ≡ 'Q'
        return 12
    elseif char ≡ 'K'
        return 13
    elseif char ≡ 'A'
        return 14
    else
        return parse(Int, char)
    end
end

struct Hand <: AbstractVector{Int}
    card1::Int
    card2::Int
    card3::Int
    card4::Int
    card5::Int
    bid::Int
end

Base.size(hand::Hand) = (5,)
Base.getindex(hand::Hand, i) = getfield(hand, i)

count_unique(hand::Hand) = sort([count(==(card), hand) for card ∈ unique(hand)])

is_five_of_a_kind(hand::Hand) = [5] == count_unique(hand)
is_four_of_a_kind(hand::Hand) = [1, 4] == count_unique(hand)
is_full_house(hand::Hand) = [2, 3] == count_unique(hand)
is_three_of_a_kind(hand::Hand) = [1, 1, 3] == count_unique(hand)
is_two_pair(hand::Hand) = [1, 2, 2] == count_unique(hand)
is_one_pair(hand::Hand) = [1, 1, 1, 2] == count_unique(hand)
is_high_card(hand::Hand) = [1, 1, 1, 1, 1] == count_unique(hand)

function Base.isless(hand1::Hand, hand2::Hand)
    if !is_five_of_a_kind(hand1) && is_five_of_a_kind(hand2)
        return true
    elseif is_five_of_a_kind(hand1) && !is_five_of_a_kind(hand2)
        return false
    elseif !is_five_of_a_kind(hand1) && !is_four_of_a_kind(hand1) && is_four_of_a_kind(hand2)
        return true
    elseif is_four_of_a_kind(hand1) && !is_five_of_a_kind(hand2) && !is_four_of_a_kind(hand2)
        return false
    elseif !is_five_of_a_kind(hand1) && !is_four_of_a_kind(hand1) && !is_full_house(hand1) && is_full_house(hand2)
        return true
    elseif is_full_house(hand1) && !is_five_of_a_kind(hand2) && !is_four_of_a_kind(hand2) && !is_full_house(hand2)
        return false
    elseif (is_two_pair(hand1) || is_one_pair(hand1) || is_high_card(hand1)) && is_three_of_a_kind(hand2)
        return true
    elseif is_three_of_a_kind(hand1) && (is_two_pair(hand2) || is_one_pair(hand2) || is_high_card(hand2))
        return false
    elseif (is_one_pair(hand1) || is_high_card(hand1)) && is_two_pair(hand2)
        return true
    elseif is_two_pair(hand1) && (is_one_pair(hand2) || is_high_card(hand2))
        return false
    elseif is_high_card(hand1) && is_one_pair(hand2)
        return true
    elseif is_one_pair(hand1) && is_high_card(hand2)
        return false  
    else
        for (card1, card2) ∈ zip(hand1, hand2)
            if card1 ≡ card2
                continue
            elseif card1 < card2
                return true
            else
                return false
            end
        end
    end
end

function read_file(file)
    hands = Hand[]
    open(file, "r") do io
        for line ∈ eachline(file)
            new_line = split(line)
            char1, char2, char3, char4, char5 = new_line[1]
            bid = new_line[2]
            push!(hands, Hand(char_to_num(char1), char_to_num(char2), char_to_num(char3), char_to_num(char4), char_to_num(char5), parse(Int, bid)))
        end
    end
    hands
end

function calculate_total_winnings(hands)
    leaderboard = sort(hands)
    total_winnings = 0
    for (i, hand) ∈ enumerate(leaderboard)
        winnings = i*hand.bid
        total_winnings += winnings
    end
    total_winnings
end

hands = read_file("day07/input.txt")
calculate_total_winnings(hands)
