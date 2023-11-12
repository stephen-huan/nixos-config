local luasnip = require "luasnip"
-- https://github.com/L3MON4D3/LuaSnip/issues/525
luasnip.setup {
    region_check_events = { "CursorHold", "InsertLeave" },
    delete_check_events = { "TextChanged", "InsertLeave" },
}
-- load snippets
require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_snipmate").lazy_load()
-- keybindings
vim.keymap.set("i", "<s-cr>", function()
    if luasnip.expand_or_jumpable() then
        return "<plug>luasnip-expand-or-jump"
    else
        return "<s-cr>"
    end
end, { expr = true, silent = true })
