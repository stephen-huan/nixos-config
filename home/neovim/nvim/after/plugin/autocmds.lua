vim.api.nvim_create_autocmd("FileType", {
    desc = "filetype-specific highlighting",
    group = "vimrc",
    pattern = "*",
    callback = function(args)
        local lang = vim.treesitter.language.get_lang(args.match)
        if
            lang ~= nil
            and lang ~= "latex"
            and lang ~= "tex"
            and vim.treesitter.language.add(lang)
        then
            vim.treesitter.start(args.buf, lang)
        elseif
            true
            and args.match ~= "cfg"
            and args.match ~= "checkhealth"
            and args.match ~= "cmp_docs"
            and args.match ~= "cmp_menu"
            and args.match ~= "conf"
            and args.match ~= "cython"
            and args.match ~= "desktop"
            and args.match ~= "fstab"
            and args.match ~= "fstar"
            and args.match ~= "fzf"
            and args.match ~= "git" -- .git/{FETCH_HEAD,HEAD,ORIG_HEAD}
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
            and args.match ~= "ranger"
            and args.match ~= "resolv"
            and args.match ~= "services"
            and args.match ~= "startify"
            and args.match ~= "systemd"
            and args.match ~= "tex"
            and args.match ~= "text"
            and args.match ~= "undotree"
            and args.match ~= "xf86conf"
            and args.match ~= "xmath"
        then
            -- disable syntax highlighting
            vim.bo[args.buf].syntax = ""
            vim.cmd(
                'echohl WarningMsg | unsilent echom "'
                    .. args.match
                    .. ' syntax highlighting disabled!" | echohl None'
            )
        end
    end,
})
