-- keybindings
for _, mode in pairs { "n", "i", "x", "o" } do
    vim.keymap.set(mode, "<c-p>", "<plug>(fzf-maps-" .. mode .. ")")
end
-- complete path
vim.keymap.set("i", "<c-x><c-f>", "<plug>(fzf-complete-path)")
-- lines from any buffer
vim.keymap.set("i", "<c-x><c-l>", "<plug>(fzf-complete-line)")
-- leader shortcuts
for key, cmd in pairs {
    o = "Files", -- files with fzf
    a = "Ag", -- ag searcher
    L = "BLines", -- lines in current buffer
    W = "Windows", -- windows
    H = "Helptags", -- help
} do
    vim.keymap.set("n", "<leader>" .. key, "<cmd>" .. cmd .. "<cr>")
end
