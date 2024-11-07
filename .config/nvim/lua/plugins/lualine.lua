local function lsp_signature_status()
    local signature = require("lsp_signature").status_line()
    if signature and signature.label ~= "" then
        return signature.label .. "  " .. signature.hint
    end
    return ""
end

return {
    "nvim-lualine/lualine.nvim",
    dependencies = "ray-x/lsp_signature.nvim",
    config = function()
        require("lualine").setup({
            sections = {
                lualine_c = { lsp_signature_status },
            },
        })
    end,
}
