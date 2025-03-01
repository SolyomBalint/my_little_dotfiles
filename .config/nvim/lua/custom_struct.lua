local setColours = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
end

setColours("KanagawaDelimiterLightGrey", { default = true, fg = "#9CABCA", ctermfg = "LightGrey" }) -- Light Grey
setColours("KanagawaDelimiterDeepPurple", { default = true, fg = "#957FB8", ctermfg = "Magenta" })  -- Spring Violet
setColours("KanagawaDelimiterBrightCyan", { default = true, fg = "#6A9589", ctermfg = "Cyan" })     -- Light Blue
setColours("KanagawaDelimiterTeal", { default = true, fg = "#7AA89F", ctermfg = "Cyan" })           -- Teal
setColours("KanagawaDelimiterYellow", { default = true, fg = "#DCD7BA", ctermfg = "Yellow" })       -- Yellow
setColours("KanagawaDelimiterRed", { default = true, fg = "#E46876", ctermfg = "Red" })             -- Red
setColours("KanagawaDelimiterOrange", { default = true, fg = "#FF9E3B", ctermfg = "Yellow" })       -- Yellow
