# advent of code 2020 day 2

function load_data(path:: String):: AbstractArray
    println(path)
    file = open(path)
    data_array = readlines(file)
    close(file)
    return data_array
end

function split_first(qstring:: String, qchar:: String)
    split_qstring = split(qstring, qchar)
    first_match = split_qstring[1]
    rest = join(split_qstring[2: length(split_qstring)])
    return first_match, rest
end

function check_pw_policy1(pw, qchar, low_bound, up_bound)
    low_bound, up_bound = parse(Int, low_bound), parse(Int, up_bound)
    num_match = length(findall(qchar, pw))
    if low_bound <= num_match <= up_bound
        return 1
    else
        return 0
    end
    
end

function check_pw_policy2(pw, qchar, low_bound, up_bound)
    low_bound, up_bound = parse(Int, low_bound), parse(Int, up_bound)
    char1, char2 = pw[low_bound:low_bound], pw[up_bound:up_bound]
    if (char1 == qchar) ⊻ (char2 == qchar)
        return 1
    else
        return 0
    end
    
end

data_array = load_data("./data/day2.txt")
use_policy = 3

let num_valid_pw = 0
    if use_policy == 1
        check_pw = check_pw_policy1
    elseif use_policy ==  2
        check_pw = check_pw_policy2
    else
        println("Policy: $use_policy Not implemented, defaulting to policy 1")
        global use_policy = 1
        check_pw = check_pw_policy1
        
    end

    for rule_pw in data_array
        low_bound, rule_pw = split_first(rule_pw, "-")
        up_bound, rule_pw = split_first(rule_pw, " ")
        char, pw = split_first(rule_pw, ":")
        num_valid_pw += check_pw(pw, char, low_bound, up_bound)
    end
    println("number of valid pw: $num_valid_pw, using policy $use_policy")
end