require("full-border"):setup({
    -- Available values: ui.Border.PLAIN, ui.Border.ROUNDED
    type = ui.Border.ROUNDED,
})
Status:children_add(function()
    local h = cx.active.current.hovered
    if h == nil or ya.target_family() ~= "unix" then
        return ui.Line({})
    end

    return ui.Line({
        ui.Span(ya.user_name(h.cha.uid) or tostring(h.cha.uid)):fg("magenta"),
        ui.Span(":"),
        ui.Span(ya.group_name(h.cha.gid) or tostring(h.cha.gid)):fg("magenta"),
        ui.Span(" "),
    })
end, 500, Status.RIGHT)

-- ~/.config/yazi/init.lua
th.git = th.git or {}
th.git.modified_sign = "M"
th.git.added_sign = "A"
th.git.untracked_sign = "U"
th.git.deleted_sign = "D"
th.git.ignored_sign = "I"
th.git.updated_sign = "u"
require("git"):setup()
