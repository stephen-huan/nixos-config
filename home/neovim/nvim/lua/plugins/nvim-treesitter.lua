require("nvim-treesitter.configs").setup {
    ignore_install = "all",
    highlight = {
        enable = true,
        disable = { "latex", "gitcommit", "julia" },
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "<CR>",
            scope_incremental = "<CR>",
            node_incremental = "<TAB>",
            node_decremental = "<S-TAB>",
        },
    },
    indent = {
        enable = true,
        disable = { "python" },
    },
    matchup = {
        enable = true,
    },
}
