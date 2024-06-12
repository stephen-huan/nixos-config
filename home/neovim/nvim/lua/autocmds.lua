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
            true
            and args.match ~= "checkhealth"
            and args.match ~= "cmp_menu"
            and args.match ~= "conf"
            and args.match ~= "cython"
            and args.match ~= "fzf"
            and args.match ~= "julia"
            and args.match ~= "man"
            and args.match ~= "pyrex"
            and args.match ~= "qf"
            and args.match ~= "robots"
            and args.match ~= "startify"
            and args.match ~= "tex"
            and args.match ~= "text"
            and args.match ~= "undotree"
        then
            -- still disables syntax highlighting
            -- overwritten by actual treesitter
            vim.b[args.buf].ts_highlight = false
        end
    end,
})
