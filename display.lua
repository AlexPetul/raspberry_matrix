require("tablelib")
local graphics = require("graphics")
local colors = require("colors")
local alphabet = require("alphabet")

Display = {}

function Display:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function Display:show(text, color, slide)
    local fb = graphics.find_device("RPi-Sense FB")
    local fd = io.open(fb, "w")

    text_color = colors.color_to_bin(string.sub(color, 2, color:len()))

    if slide == true then
        local panorama = {}
        for i = 1, #text do
            local letter = text:sub(i, i)
            local pixels = alphabet[string.upper(letter)]
            local res = colors.letter_to_pixels(pixels, text_color)
            for _, pix in ipairs(res) do
                table.insert(panorama, pix)
            end
        end
        
        local first = 1
        local iterations = (text:len() - 1) * 8 + 1
        for iter = 1, iterations do
            local window = {}
            if iter == 1 then
                window = table.slice(panorama, 1, 64)
            elseif iter == iterations then
                window = table.slice(panorama, (text:len() - 1) * 64 + 1)
            else
                local old_first = first
                local multiplier = math.floor(old_first / 64) * 64
                local line = 1
                
                while line <= 8 do
                    local j = (8 * line) + multiplier
                    local counter = 0
                    local last_i = first
                    for i = first, j do
                        counter = counter + 1
                        table.insert(window, panorama[i])
                        last_i = i
                    end
                    if iter == 16 then
                        print(first, j)
                    end
                    for ix = 1, 8 - counter do
                        table.insert(window, panorama[last_i + 57])
                        last_i = last_i + 1
                    end
                    first = first + 8
                    line = line + 1
                end
                first = old_first
            end
            
            if math.fmod(first, 8) == 0 then
                first = first + 56
            end
            
            first = first + 1
            
            for j, clr in ipairs(window) do
                fd:seek("set", 2 * (j - 1))
                fd:write(clr)
            end
            os.execute("sleep 0.4")
            
        end

    else
        for i = 1, #text do
            local letter = text:sub(i, i)
            local pixels = alphabet[string.upper(letter)]
            local res = colors.letter_to_pixels(pixels, text_color)
            for j, clr in ipairs(res) do
                fd:seek("set", 2 * (j - 1))
                fd:write(clr)
            end
            os.execute("sleep 2")
            self:clear()
        end
    end

    fd:close()
end

function Display:clear()
    local fb = graphics.find_device("RPi-Sense FB")
    local fd = io.open(fb, "w")

    for i = 1, 64 do
        fd:seek("set", 2 * (i - 1))
        fd:write(colors.color_to_bin("000000"))
    end

    fd:close()
end

return Display