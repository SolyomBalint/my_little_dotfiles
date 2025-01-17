local App = require("astal.gtk3.app")
local Bar = require("widgets.bar")

App:start {
    main = function()
        Bar(0)
        Bar(1) -- instantiate for each monitor
    end,
}
