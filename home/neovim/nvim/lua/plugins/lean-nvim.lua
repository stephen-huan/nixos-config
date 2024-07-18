local on_attach = require("config.lsp").on_attach
require("lean").setup {
    lsp = { on_attach = on_attach },
    abbreviations = { enable = true },
    mappings = true,
    infoview = { autoopen = true },
}
