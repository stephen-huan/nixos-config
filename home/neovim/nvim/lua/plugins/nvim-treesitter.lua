require("nvim-treesitter.configs").setup {
    ignore_install = "all",
    highlight = {
        enable = true,
        disable = { "latex", "julia" },
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "<cr>",
            scope_incremental = "<cr>",
            node_incremental = "<tab>",
            node_decremental = "<s-tab>",
        },
    },
    indent = {
        enable = true,
        disable = { "julia", "nix" },
    },
    matchup = {
        enable = true,
        -- intermittent freezes
        disable = { "julia" },
    },
}
