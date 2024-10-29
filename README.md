# Display text on raspberry-pi RGB matrix

This Lua project can display text on RGB matrix in two modes: letter by letter or using sliding window:

```lua
local Display = require("display")

display = Display:new()
display:show("ab", "#F5052D")
--- Use sliding window
display:show("abc", "#F5052D", true)
```

Execute the following command on your Raspberry PI:
```shell
lua main.lua
```