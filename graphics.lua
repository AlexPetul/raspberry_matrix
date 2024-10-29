local graphics = {}

function graphics.find_device(name)
    local nodes = io.popen("ls -1 /sys/class/graphics"):lines()
    for node in nodes do
        if string.sub(node, 1, 2) == "fb" then
            local fd = io.open("/sys/class/graphics/" .. node .. "/name")
            local content = fd:read()
            fd:close()

            if content == name then
                return "/dev/" .. node
            end
        end
    end
end

return graphics