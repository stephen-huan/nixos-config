-- keybindings
vim.keymap.set({ "n", "x", "o" }, "s", "<plug>(leap-forward)")
vim.keymap.set({ "n", "x", "o" }, "S", "<plug>(leap-backward)")
vim.keymap.set("n", "gs", "<plug>(leap-from-window)")
vim.keymap.set({ "x", "o" }, "x", "<plug>(leap-forward-till)")
vim.keymap.set({ "x", "o" }, "X", "<plug>(leap-backward-till)")
