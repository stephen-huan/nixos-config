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
        "--keep-intermediates", -- faster compile times
        "--keep-logs",
        "--synctex",
        "-Z shell-escape",
        -- "-Z deterministic-mode", -- breaks synctex
    },
}
