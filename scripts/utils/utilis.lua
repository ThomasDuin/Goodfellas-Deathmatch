function split(s, delimiter)
    local result = {};
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match);
    end
    return result
end

local allowedChars = {
    "_", "[", "]",
    "0", "1", "2", "3", "4", "5", "6", "7", "8", "9",
    "a", "A",
    "b", "B",
    "c", "C",
    "d", "D",
    "e", "E",
    "f", "F",
    "g", "G",
    "h", "H",
    "i", "I",
    "j", "J",
    "k", "K",
    "l", "L",
    "m", "M",
    "n", "N",
    "o", "O",
    "p", "P",
    "q", "Q",
    "r", "R",
    "s", "S",
    "t", "T",
    "u", "U",
    "v", "V",
    "w", "W",
    "x", "X",
    "y", "Y",
    "z", "Z",
}

function allowedString(str)
    for i = 1, #str do
        local c = str:sub(i,i)

        local isAllowed = false
        for j = 1, #allowedChars do
            if c == allowedChars[j] then
                isAllowed = true
                break
            end
        end
        
        if isAllowed == false then
            return false
        end
    end
    return true
end

function getDistanceBetweenVectors(x1, y1, z1, x2, y2, z2)
	return math.sqrt((x1 - x2) ^ 2 + (y1 - y2) ^ 2 + (z1 - z2) ^ 2)
end

function stringifyArrayFrom(index, array)
    local text = ""
    for i = index, #array do
        text = text .. " " .. array[i]
    end
    return text
end