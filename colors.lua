local colors = {}

function colors.color_to_bin(rgb)
    if rgb:len() ~= 6 then
        error("color " .. rgb .. " is not a 6-digit hex color")
    end

    local r = tonumber(rgb:sub(1, 2), 16)
    local g = tonumber(rgb:sub(3, 4), 16)
    local b = tonumber(rgb:sub(5, 6), 16)

    r = (r >> 3) & 0x1F
    g = (g >> 2) & 0x3F
    b = (b >> 3) & 0x1F
    local comb = (r << 11) + (g << 5) + b

    return string.pack("H", comb)
end

function lines(str)
    local lines = {}
    for line in str:gmatch("[^\r\n]+") do
        table.insert(lines, line)
    end
    return lines
end

function colors.letter_to_pixels(letter, color)
    data = {}
    ix = 1

    for _, line in ipairs(lines(letter)) do
        for j = 1, #line do
            if line:sub(j, j) == " " then
                data[ix] = colors.color_to_bin("000000")
            else
                data[ix] = color
            end
            ix = ix + 1
        end
    end

    return data
end

return colors