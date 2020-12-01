# advent of code 2020 day 1

file = open("./data/day1.txt")
data_array = readlines(file)
close(file)

data_array = parse.(Int, data_array)

sum_to_find = 2020
length_data_array = length(data_array)

for (i, d_1) in enumerate(data_array)
    for d_2 in data_array[i:length_data_array]
        _sum = d_1 + d_2
        #println(_sum)
        if _sum == sum_to_find
            _prod = d_1 * d_2
            println("results are: $d_1, $d_2, sum: $_sum, prod: $_prod")
        end

    end
end


