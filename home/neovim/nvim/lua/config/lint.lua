local lint = require "lint"
local packages = require("config.lsp").packages

-- register linters for each filetype
lint.linters_by_ft = {}
local languages = {}
for language, types in pairs(packages) do
    if types.linter then
        lint.linters_by_ft[language] = {}
        for _, linter in pairs(types.linter) do
            table.insert(lint.linters_by_ft[language], linter)
        end
        table.insert(languages, language)
    end
end

-- autocmd for activating the linter
vim.api.nvim_create_autocmd({ "FileType" }, {
    group = "vimrc",
    pattern = languages,
    callback = function(args)
        local events = { "BufEnter", "BufWritePost", "InsertLeave" }
        vim.api.nvim_create_autocmd(events, {
            group = vim.api.nvim_create_augroup(
                string.format("lint<buffer=%d>", args.buf),
                { clear = true }
            ),
            buffer = args.buf,
            callback = function()
                lint.try_lint()
            end,
        })
    end,
})

vim.diagnostic.config { virtual_text = true, virtual_lines = false }
-- keybindings: https://github.com/neovim/nvim-lspconfig
vim.keymap.set("n", "<leader>l", vim.diagnostic.setloclist)
vim.keymap.set("n", "<leader>d", function()
    local scope = { bufnr = 0 }
    vim.diagnostic.enable(not vim.diagnostic.is_enabled(scope), scope)
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled(scope), scope)
end)

-- adjust linter configuration

-- add neovim environment
lint.linters.selene.args = {
    "--display-style",
    "json",
    "--config",
    vim.fn.stdpath "config" .. "/lsp/selene/selene.toml",
}
