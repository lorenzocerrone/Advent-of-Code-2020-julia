# advent of code 2020 day 4

function load_data(path:: String):: AbstractArray
    file = open(path)
    data_array = readlines(file)
    close(file)
    return data_array
end

function process_passport(instance, mandatory_fields, rules=nothing)

    for key in mandatory_fields
        _instance = join(instance)
        if findfirst(key, _instance) === nothing
            return 0
        end
    end

    if rules !== nothing
        for value in instance
            _key, _value = String(value[1:4]), String(value[5:end])
            if ~rules[_key](_value)
                return 0
            end
        end
    end
    return 1
end

function process_all(data_array, fields, exception_field, rules=nothing)
    mandatory_fields = []
    for _field in fields
        if ~(_field in exception_field)
            push!(mandatory_fields, _field)
        end
    end

    passport_array, passport = [], []
    let data, passport = []
        for data in data_array
            if length(data) == 0 
                push!(passport_array, passport)
                passport = []
            else
                append!(passport, split(data, " "))
            end
        end
        push!(passport_array, passport)
    end

    numb_valid = 0
    for passport in passport_array
        numb_valid += process_passport(passport, mandatory_fields, rules)
    end

    return numb_valid
end


data_array = load_data("data/day4.txt")

fields = ["ecl:", "pid:", "eyr:", "hcl:", "byr:", "iyr:", "cid:", "hgt:"]

rules = Dict([("ecl:", x -> x in ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]),
              ("pid:", x -> (length(x) === 9) & (match(r"[0-9]+", x).match == x)),
              ("eyr:", x -> (length(x) === 4) && (2020 <= parse(Int, x) <= 2030)),
              ("hcl:", x -> (x[1] === '#') && (match(r"[a-f0-9]+", x[2:end]).match == x[2:end])),
              ("byr:", x -> (length(x) === 4) && (1920 <= parse(Int, x) <= 2002)),
              ("hgt:", x -> ((x[length(x)[1] - 1:end] === "in") && (59 <= parse(Int, x[1:length(x)[1]-2]) <= 76)) | ((x[length(x)[1] - 1:end] === "cm") && (150 <= parse(Int, x[1:length(x)[1]-2]) <= 193))),
              ("cid:", x -> true),
              ("iyr:", x -> (length(x) === 4) && (2010 <= parse(Int, x) <= 2020)),
              ])

exception_field = ["cid:"]

numb_valid = process_all(data_array, fields, exception_field, nothing)
println("number of valid passport with no rules: $numb_valid")

numb_valid = process_all(data_array, fields, exception_field, rules)
println("number of valid passport with strict rules: $numb_valid")
