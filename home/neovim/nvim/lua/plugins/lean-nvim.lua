local on_attach = require("config.lsp").on_attach
require("lean").setup {
    lsp = { on_attach = on_attach },
    abbreviations = { enable = true },
    mappings = true,
    infoview = { autoopen = true },
    goal_markers = {
        -- gets in the way of writing proofs
        unsolved = "",
        -- "" disables goals entirely
        accomplished = " ",
        -- leanprover/verso (bisected 41b85d429fcdb33349115edc063078dd98ee7c0b)
        -- see src/verso/Verso/Code/Highlighted.lean
        goals_accomplished = string.lower "All goals completed! 🐙",
        no_goals = string.lower "No goals.",
    },
}
