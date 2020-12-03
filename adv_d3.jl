# advent of code 2020 day 3

function load_data(path:: String):: AbstractArray
    file = open(path)
    data_array = readlines(file)
    close(file)
    return data_array
end


function walker_acc(data_array:: AbstractArray, x_step=1, y_step=3):: Int
    size_x, size_y = size(data_array)[1], length(data_array[1])
    numb_tree, pos_x, pos_y = 0, 1 + x_step, 1 + y_step
    while (pos_x <= size_x)
        if data_array[pos_x][(pos_y - 1)%end + 1] == '#'
            numb_tree += 1
        end
        pos_x += x_step
        pos_y += y_step
    end

    return numb_tree
end


data_array = load_data("./data/day3.txt")
numb_tree = walker_acc(data_array)
println("Numb of tree is: $numb_tree")

slope_to_test = [[1, 1], [3, 1], [5, 1], [7, 1], [1, 2]]
let prod_path = 1
    for slope in slope_to_test
        prod_path *= walker_acc(data_array, slope[2], slope[1])
    end
    println("product of multipel slopes is: $prod_path")
end
