-- don't use plain TeX
vim.g.tex_flavor = "latex"
-- set PDF viewer
vim.g.vimtex_view_method = "sioyek"
-- automatically close quickfix menu
vim.g.vimtex_quickfix_autoclose_after_keystrokes = 3
-- compilers
vim.g.vimtex_compiler_method = "tectonic"
vim.g.vimtex_compiler_tectonic = {
    options = {
        "--keep-logs",
        "--synctex",
        "-Z shell-escape",
        -- breaks synctex
        -- "-Z deterministic-mode",
    },
}
vim.g.vimtex_compiler_latexmk = {
    executable = "latexmk",
    options = {
        "-verbose",
        "-file-line-error",
        "-synctex=1",
        "-interaction=nonstopmode",
        "-shell-escape",
    },
}
