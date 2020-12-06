# advent of code 2020 day 6

function load_data(path:: String):: AbstractArray
    file = open(path)
    data_array = readlines(file)
    close(file)
    return data_array
end

function parse_group_one(answers_list)
    answers = ""
    for answer in answers_list
        answers *= answer
    end
    answers_array = [_c for _c in answers]
    answers_array = unique(answers_array)
    return length(answers_array)
end

function parse_group_two(answers_list)
    num_answers = 0
    for _c in 'a':'z'
        hits = 0
        for answers in answers_list
            hits += _c in answers
        end

        if length(answers_list) === hits
            num_answers += 1
        end
    end
    return num_answers
end

function process_array(data_array, foo)
    data_groups = []
    let answers = []
        for data in data_array
            if length(data) == 0 
                push!(data_groups, foo(answers))
                answers = []
            else
                push!(answers, data)
            end
        end
        push!(data_groups, foo(answers))
    end
    return data_groups
end


data_array = load_data("data/day6.txt")
result_array = process_array(data_array, parse_group_one)
println("Result is $(sum(result_array)), with rule 1")
result_array = process_array(data_array, parse_group_two)
println("Result is $(sum(result_array)), with rule 2")