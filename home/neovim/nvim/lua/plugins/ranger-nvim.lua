local ranger_nvim = require "ranger-nvim"
ranger_nvim.setup {
    replace_netrw = true,
    keybinds = {
        ["L"] = ranger_nvim.OPEN_MODE.tabedit,
        ["<right>"] = ranger_nvim.OPEN_MODE.tabedit,
    },
    ui = {
        border = "rounded",
        height = 0.6,
        width = 0.9,
    },
}
-- keybindings
vim.keymap.set("n", "<leader>r", function()
    require("ranger-nvim").open(true)
end)
