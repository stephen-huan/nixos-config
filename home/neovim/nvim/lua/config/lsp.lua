local lspconfig = require "lspconfig"
-- add additional capabilities supported by nvim-cmp
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- installed packages
local packages = {
    c = {
        -- https://clangd.llvm.org/
        lsp = { "clangd" },
        -- https://clang.llvm.org/docs/ClangFormat.html
        formatter = { "clangformat" },
    },
    cpp = {
        lsp = { "clangd" },
        formatter = { "clangformat" },
    },
    css = {
        -- https://github.com/microsoft/vscode-css-languageservice
        lsp = { "cssls" },
        -- https://github.com/prettier/prettier
        formatter = { "prettier" },
    },
    fish = {
        linter = { "fish" },
    },
    html = {
        -- https://github.com/microsoft/vscode-html-languageservice
        lsp = { "html" },
        formatter = { "prettier" },
    },
    json = {
        -- https://github.com/zaach/jsonlint
        linter = { "jsonlint" },
        formatter = { "prettier" },
    },
    julia = {
        -- https://github.com/julia-vscode/LanguageServer.jl
        lsp = { "julials" },
    },
    latex = {
        -- https://github.com/latex-lsp/texlab
        lsp = { "texlab" },
    },
    lua = {
        -- https://github.com/LuaLS/lua-language-server
        lsp = { "lua_ls" },
        linter = {
            -- https://github.com/mpeterv/luacheck
            -- "luacheck"
            -- https://github.com/Kampfkarren/selene
            "selene",
        },
        -- https://github.com/JohnnyMorganz/StyLua
        formatter = { "stylua" },
    },
    markdown = {
        formatter = { "prettier" },
    },
    nix = {
        -- https://github.com/oxalica/nil
        lsp = { "nil_ls" },
        -- https://github.com/nerdypepper/statix
        linter = { "statix" },
        -- https://github.com/nix-community/nixpkgs-fmt
        formatter = { "nixpkgs_fmt" },
    },
    python = {
        lsp = {
            -- https://github.com/microsoft/pyright
            "pyright",
            -- https://github.com/facebook/pyre-check
            -- "pyre",
            -- https://github.com/pappasam/jedi-language-server
            -- "jedi_language_server",
        },
        linter = {
            -- https://github.com/charliermarsh/ruff
            "ruff",
            -- https://github.com/python/mypy
            -- "mypy",
        },
        formatter = {
            -- https://github.com/PyCQA/isort
            "isort",
            -- https://github.com/psf/black
            "black",
        },
    },
    sh = {
        -- https://github.com/bash-lsp/bash-language-server
        lsp = { "bashls" },
        -- https://github.com/koalaman/shellcheck
        linter = { "shellcheck" },
        -- https://github.com/mvdan/sh
        formatter = { "shfmt" },
    },
    toml = {
        -- https://github.com/tamasfe/taplo
        lsp = { "taplo" },
    },
    yaml = {
        -- https://github.com/redhat-developer/yaml-language-server
        lsp = { "yamlls" },
        formatter = { "prettier" },
    },
}

-- use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(_, bufnr)
    -- show hover information in popup window
    --[[
    vim.api.nvim_create_autocmd("CursorHold", {
        group = vim.api.nvim_create_augroup(
            string.format("lsp<buffer=%d>", bufnr), { clear = true }
        ),
        buffer = bufnr,
        callback = function()
            vim.lsp.buf.hover()
        end
    })
    --]]
    -- enable completion triggered by <c-x><c-o>
    vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
    -- extra keybindings: https://github.com/neovim/nvim-lspconfig
    local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
    end

    map("n", "gD", vim.lsp.buf.declaration)
    map("n", "gd", vim.lsp.buf.definition)
    map("n", "gi", vim.lsp.buf.implementation)
    map("n", "<c-k>", vim.lsp.buf.signature_help)
    map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder)
    map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder)
    map("n", "<leader>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end)
    map("n", "<leader>D", vim.lsp.buf.type_definition)
    map("n", "<leader>rn", vim.lsp.buf.rename)
    map("n", "<leader>ca", vim.lsp.buf.code_action)
    map("n", "gr", vim.lsp.buf.references)
    map({ "n", "v" }, "<leader>f", function()
        vim.lsp.buf.format { async = true }
    end)
end

-- enable lsp with the additional completion capabilities offered by nvim-cmp
for _, language in pairs(packages) do
    if language.lsp then
        for _, lsp in pairs(language.lsp) do
            lspconfig[lsp].setup {
                on_attach = on_attach,
                capabilities = capabilities,
            }
        end
    end
end

local on_attach_semantic = function(client, bufnr)
    -- stylua: ignore
    local tokens = (
        client.server_capabilities.semanticTokensProvider.legend.tokenTypes
    )
    for index, token in pairs(tokens) do
        -- fixes TODO, covered by most nvim-treesitter's @comment query anyways
        if token == "comment" then
            tokens[index] = nil
        end
    end
    on_attach(client, bufnr)
end

-- adjust lsp configuration: https://github.com/neovim/nvim-lspconfig/
lspconfig.lua_ls.setup {
    on_attach = on_attach_semantic,
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
            },
            diagnostics = {
                -- get the language server to recognize the `vim` global
                globals = { "vim" },
            },
            workspace = {
                -- make the server aware of neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
                -- https://github.com/neovim/nvim-lspconfig/issues/1700
                checkThirdParty = false,
            },
            telemetry = {
                -- do not send telemetry data
                enable = false,
            },
        },
    },
}

-- https://github.com/oxalica/nil/blob/main/docs/configuration.md
require("lspconfig").nil_ls.setup {
    on_attach = on_attach_semantic,
    capabilities = capabilities,
    settings = {
        ["nil"] = {
            formatting = {
                command = { "nixpkgs-fmt" },
            },
        },
    },
}

return {
    packages = packages,
    on_attach = on_attach,
}
