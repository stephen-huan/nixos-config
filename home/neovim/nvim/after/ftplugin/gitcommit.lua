local options = require "options"

options.set_options({
    -- limit to 72 character width lines
    colorcolumn = "73",
    formatprg = "inflow 72",
}, "local")

-- remap goyo to 72 characters
vim.keymap.set("n", "<leader>y", "<cmd>Goyo 73<cr>")
