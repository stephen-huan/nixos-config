-- HACK: warning when syntax highlighting falls through
vim.api.nvim_create_autocmd("FileType", {
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
