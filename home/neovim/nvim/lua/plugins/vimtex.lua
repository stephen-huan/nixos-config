-- don't use plain TeX
vim.g.tex_flavor = "latex"
-- set PDF viewer
vim.g.vimtex_view_method = "sioyek"
-- vim.g.vimtex_view_sioyek_exe = "sioyek"
-- automatically close quickfix menu
vim.g.vimtex_quickfix_autoclose_after_keystrokes = 3
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
