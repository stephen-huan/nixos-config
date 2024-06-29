-- HACK: relies on b:ts_highlight
vim.api.nvim_create_autocmd("FileType", {
    desc = "warning when syntax highlighting falls through",
    group = "vimrc",
    pattern = "*",
    callback = function(args)
        if
            vim.b[args.buf].ts_highlight ~= nil
            and not vim.b[args.buf].ts_highlight
        then
            vim.cmd(
                'echohl WarningMsg | unsilent echom "'
                    .. args.match
                    .. ' syntax highlighting disabled!" | echohl None'
            )
        end
    end,
})
