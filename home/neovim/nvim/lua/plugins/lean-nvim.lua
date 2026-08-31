local on_attach = require("config.lsp").on_attach
vim.lsp.config("leanls", { on_attach = on_attach })
vim.g.lean_config = {
    abbreviations = { enable = true },
    mappings = true,
    infoview = {
        autoopen = true,
        -- leanprover/verso (bisected 41b85d429fcdb33349115edc063078dd98ee7c0b)
        -- see src/verso/Verso/Code/Highlighted.lean
        messages = {
            goals = {
                accomplished = string.lower "All goals completed! 🐙",
                none = string.lower "No goals.",
            },
        },
    },
    goal_markers = {
        -- gets in the way of writing proofs
        unsolved = "",
        -- "" disables goals entirely
        accomplished = " ",
    },
}
