-- start in new window
vim.g.fzf_layout = {
    window = {
        width = 0.9,
        height = 0.6,
        border = "rounded",
    },
}
-- directory jumping with z
vim.keymap.set("n", "<leader>g", function()
    vim.fn["fzf#run"](vim.fn["fzf#wrap"] {
        source = "fish -c '_z'",
        sink = "cd",
        options = {
            "--preview",
            "_preview_path {}",
            "--tiebreak=index",
        },
    })
end)
