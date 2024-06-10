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
