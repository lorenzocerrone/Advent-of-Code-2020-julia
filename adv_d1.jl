# advent of code 2020 day 1

function load_data(path:: String):: AbstractArray
    file = open(path)
    data_array = readlines(file)
    close(file)
    # cast string to integer
    parse.(Int, data_array)
end

function find_sum_of_2(data_array:: AbstractArray, sum_to_find:: Int)
    length_data_array = length(data_array)
    for (i, d_1) in enumerate(data_array)
        for d_2 in data_array[i:length_data_array]
            _sum = d_1 + d_2
            if _sum == sum_to_find
                return d_1, d_2
            end
    
        end
    end

end

function find_sum_of_3(data_array:: AbstractArray, sum_to_find:: Int)
    length_data_array = length(data_array)
    for (i, d_1) in enumerate(data_array)
        for (j, d_2) in enumerate(data_array[i:length_data_array])
            for d_3 in data_array[j:length_data_array]

                _sum = d_1 + d_2 + d_3
                if _sum == sum_to_find
                    return d_1, d_2, d_3
                end
            end
    
        end
    end

end

data_array = load_data("./data/day1.txt")

sum_to_find = 2020

numbers = find_sum_of_2(data_array, sum_to_find)
numbers_product = prod(numbers)

println("results of 2: $numbers_product")

numbers = find_sum_of_3(data_array, sum_to_find)
numbers_product = prod(numbers)

println("results of 3: $numbers_product")
