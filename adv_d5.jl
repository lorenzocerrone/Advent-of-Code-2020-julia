# advent of code 2020 day 5

function load_data(path:: String):: AbstractArray
    file = open(path)
    data_array = readlines(file)
    close(file)
    return data_array
end

function get_row(row_bin, max_row, query)
    min_row, max_row = 0, max_row
    for _char in row_bin
        new_row = min_row + div(max_row - min_row, 2)
        if _char === query
            max_row = new_row
        else
            min_row = new_row + 1
        end
    end
    if min_row !== max_row
        println("something whent wrong: $query, $min_row, $max_row")
    end
    return min_row

end

function parse_data(data_array, max_row, max_seat, encoding_len)
    all_rows, all_seats = [], []
    for _string in data_array
        row_bin, seat_bin = _string[1:encoding_len], _string[encoding_len+1:end]
        all_rows = push!(all_rows, get_row(row_bin, max_row - 1, 'F'))
        all_seats = push!(all_seats, get_row(seat_bin, max_seat - 1, 'L'))
    end
    return all_rows, all_seats, all_rows * max_seat + all_seats
end

encoding_len = 7
max_row, max_seat = 127, 8
data_array = load_data("data/day5.txt")
all_rows, all_seats, all_ids = parse_data(data_array, max_row, max_seat, encoding_len) 

println("Maximum ids: $(maximum(all_ids))")

max_ids = max_row * max_seat
for id in 1:max_ids
    if ~(id in all_ids) && ((id - 1) in all_ids) && ((id + 1) in all_ids)
        println("My seat: $id")
    end
end