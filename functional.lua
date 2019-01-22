function generate(n)
    local output = {}
    for i = 1, n do
        output[i] = i
    end
    return output
end

function copy(list)
    local output = {}
    for i, v in ipairs(list) do
        output[i] = v
    end
    return output
end

function map(f, list)
    local output = {}
    for i, v in ipairs(list) do
        output[i] = f(v)
    end
    return output
end

function filter(f, list)
    local output = {}
    for _, v in ipairs(list) do
        if f(v) then
            output[#output + 1] = v
        end
    end
    return output
end

function parition(f, list)
    local left, right = {}, {}
    for _, v in ipairs(list) do
        if f(v) then
            left[#left + 1] = v
        else
            right[#right + 1] = v
        end
    end
    return left, right
end

function contains(list, value)
    for _, v in ipairs(list) do
        if v == value then
            return true
        end
    end
    return false
end

function conjunction(alpha, beta)
    local output = {}
    for _, a in ipairs(alpha) do
        if contains(beta, a) then
            output[#output + 1] = a
        end
    end
    return output
end

function disjunction(alpha, beta)
    local output = copy(alpha)
    for _, b in ipairs(beta) do
        if not contains(output, b) then
            output[#output + 1] = b
        end
    end
    return output
end

function negation(alpha, beta)
    local output = {}
    for _, a in ipairs(alpha) do
        if not contains(beta, a) then
            output[#output + 1] = a
        end
    end
    return output
end

function unique(list)
    local output = {}
    for _, v in ipairs(list) do
        if not contains(output, v) then
            output[#output + 1] = v
        end
    end
    return output
end

function reduce(f, list, acc)
    for _, v in ipairs(list) do
        acc = f(acc, v)
    end
    return acc
end

function printlist(list)
    for i = 1, #list-1 do
        io.write(list[i] .. ", ")
    end
    print(list[#list])
end

local list = generate(20)
printlist(list)

local twice = function (x) return x * 2 end
local newlist = map(twice, list)
printlist(newlist)

local even = function(x) return x % 2 == 0 end
local evenlist = filter(even, list)
printlist(evenlist)

local _, oddlist = parition(even, list)
printlist(oddlist)

local add = function(a, b) return a + b end
local sum = reduce(add, list, 0)
print(sum)

local multiply = function(a, b) return a * b end
local product = reduce(multiply, list, 1)
print(product)

local list_and_newlist = conjunction(list, newlist)
printlist(list_and_newlist)

local list_or_newlist = disjunction(list, newlist)
printlist(list_or_newlist)

local list_not_newlist = negation(list, newlist)
printlist(list_not_newlist)
