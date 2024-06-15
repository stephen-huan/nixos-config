-- open on right side
vim.g.undotree_WindowLayout = 3
-- keybindings
-- HACK: https://github.com/mbbill/undotree/issues/129#issuecomment-1113252887
vim.keymap.set("n", "<leader>u", function()
    vim.cmd "UndotreeShow"
    if vim.fn.getreg "%" == "undotree_2" then
        vim.cmd "wincmd w"
        vim.cmd "wincmd w"
        vim.cmd "wincmd p"
    else
        vim.cmd "UndotreeFocus"
    end
end)
