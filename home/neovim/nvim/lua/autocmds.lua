vim.api.nvim_create_augroup("vimrc", { clear = true })

-- vimtex compile
vim.api.nvim_create_autocmd("FileType", {
    group = "vimrc",
    pattern = "tex",
    callback = function(args)
        -- compile and view on every BufWrite
        vim.api.nvim_create_autocmd("BufWritePost", {
            group = vim.api.nvim_create_augroup(
                string.format("latex<buffer=%d>", args.buf),
                { clear = true }
            ),
            buffer = args.buf,
            callback = function()
                vim.cmd "silent VimtexCompileSS"
                vim.cmd "VimtexView"
            end,
        })
    end,
})
-- enable spellcheck for text files
vim.api.nvim_create_autocmd("FileType", {
    group = "vimrc",
    pattern = { "gitcommit", "mail", "markdown", "tex", "text" },
    callback = function()
        vim.opt_local.spell = true
        vim.opt_local.spelllang = "en_us"
    end,
})
-- terminal settings
vim.api.nvim_create_autocmd("TermOpen", {
    group = "vimrc",
    callback = function()
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        vim.opt_local.signcolumn = "no"
    end,
})
-- HACK: filetype-specific highlighting, based on b:ts_highlight
-- true: treesitter syntax highlighting enabled
-- undefined: default (lexical) highlighting enabled
-- false: both disabled (no highlighting)
vim.api.nvim_create_autocmd("FileType", {
    group = "vimrc",
    pattern = "*",
    callback = function(args)
        if
            args.match ~= "tex"
            and args.match ~= "julia"
            and args.match ~= "pyrex"
            and args.match ~= "cython"
            and args.match ~= "startify"
            and args.match ~= "checkhealth"
        then
            -- still disables syntax highlighting
            -- overwritten by actual treesitter
            vim.b[args.buf].ts_highlight = false
        end
    end,
})
-- warning when syntax highlighting falls through
vim.api.nvim_create_autocmd({ "BufWinEnter", "WinNew", "BufFilePost" }, {
    group = "vimrc",
    pattern = "*",
    callback = function(args)
        if
            vim.b[args.buf].ts_highlight ~= nil
            and not vim.b[args.buf].ts_highlight
        then
            vim.cmd(
                'echohl WarningMsg | unsilent echom "'
                    .. vim.bo[args.buf].filetype
                    .. ' syntax highlighting disabled!" | echohl None'
            )
        end
    end,
})
