local on_attach = require("config.lsp").on_attach
require("lean").setup {
    abbreviations = { builtin = true },
    lsp = { on_attach = on_attach },
    -- lsp3 = { on_attach = on_attach },
    mappings = true,
}
