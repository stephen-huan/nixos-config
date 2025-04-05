vim.api.nvim_create_augroup("vimrc", { clear = true })

vim.api.nvim_create_autocmd("TermOpen", {
    desc = "terminal settings",
    group = "vimrc",
    callback = function()
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        vim.opt_local.signcolumn = "no"
    end,
})
vim.api.nvim_create_autocmd("FileType", {
    desc = "enable spellcheck for text files",
    group = "vimrc",
    pattern = { "gitcommit", "mail", "markdown", "tex", "text" },
    callback = function()
        vim.opt_local.spell = true
        vim.opt_local.spelllang = "en_us"
    end,
})
-- https://github.com/neovim/neovim/pull/28176#issuecomment-2051944146
vim.api.nvim_create_autocmd("FileType", {
    desc = "force commentstring to include spaces",
    group = "vimrc",
    callback = function(args)
        vim.bo[args.buf].commentstring = vim.bo[args.buf].commentstring
            :gsub("(%S)%%s", "%1 %%s")
            :gsub("%%s(%S)", "%%s %1")
    end,
})
vim.api.nvim_create_autocmd("FileType", {
    desc = "texpresso compile",
    group = "vimrc",
    pattern = "tex",
    callback = function(args)
        -- start server on first BufWrite
        vim.api.nvim_create_autocmd("BufWritePost", {
            group = vim.api.nvim_create_augroup(
                string.format("latex<buffer=%d>", args.buf),
                { clear = true }
            ),
            buffer = args.buf,
            callback = function()
                if not vim.b.latex_started then
                    vim.cmd "TeXpresso %"
                    vim.b.latex_started = true
                end
                -- vim.cmd "VimtexView"
            end,
        })
    end,
})
-- HACK: relies on b:ts_highlight
-- true: treesitter syntax highlighting enabled
-- undefined: default (lexical) highlighting enabled
-- false: both disabled (no highlighting)
vim.api.nvim_create_autocmd("FileType", {
    desc = "filetype-specific highlighting",
    group = "vimrc",
    pattern = "*",
    callback = function(args)
        if
            true
            and args.match ~= "cfg"
            and args.match ~= "checkhealth"
            and args.match ~= "cmp_docs"
            and args.match ~= "cmp_menu"
            and args.match ~= "conf"
            and args.match ~= "cython"
            and args.match ~= "desktop"
            and args.match ~= "fzf"
            and args.match ~= "gitsendemail"
            and args.match ~= "i3config"
            and args.match ~= "julia"
            and args.match ~= "juliadoc"
            and args.match ~= "latex"
            and args.match ~= "lean"
            and args.match ~= "leaninfo"
            and args.match ~= "leanstderr"
            and args.match ~= "lspinfo"
            and args.match ~= "mail"
            and args.match ~= "man"
            and args.match ~= "nroff"
            and args.match ~= "pyrex"
            and args.match ~= "qf"
            and args.match ~= "resolv"
            and args.match ~= "startify"
            and args.match ~= "systemd"
            and args.match ~= "tex"
            and args.match ~= "text"
            and args.match ~= "undotree"
            and args.match ~= "xmath"
        then
            -- still disables syntax highlighting
            -- overwritten by actual treesitter
            vim.b[args.buf].ts_highlight = false
        end
    end,
})
-- https://github.com/Julian/lean.nvim/issues/43#issuecomment-1850633100
vim.api.nvim_create_autocmd("QuitPre", {
    group = "vimrc",
    pattern = { "*.lean" },
    callback = function()
        local infoview = require("lean.infoview").get_current_infoview()
        if infoview then
            local tab_wins = vim.api.nvim_tabpage_list_wins(0)
            local lean_wins = vim.tbl_filter(function(w)
                local buf = vim.api.nvim_win_get_buf(w)
                local buf_ft =
                    vim.api.nvim_get_option_value("filetype", { buf = buf })
                return buf_ft == "lean"
            end, tab_wins)
            if #lean_wins <= 1 then
                infoview:close()
            end
        end
    end,
})
-- from leanprover/verso (bisected to 41b85d429fcdb33349115edc063078dd98ee7c0b)
-- see src/verso/Verso/Code/Highlighted.lean for the current message
vim.api.nvim_create_autocmd("LspAttach", {
    group = "vimrc",
    pattern = { "*.lean" },
    callback = function()
        vim.g.lean_no_goals_message = string.lower("All goals completed! 🐙")
    end,
})
