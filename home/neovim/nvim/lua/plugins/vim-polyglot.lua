-- highlight python
vim.g.python_highlight_all = 1

-- disable autofold
vim.g.vim_markdown_folding_disabled = 1
-- ~~strikethrough~~
vim.g.vim_markdown_strikethrough = 1
-- LaTeX
vim.g.vim_markdown_math = 1
-- keybindings
vim.keymap.set("", "]h", "<plug>Markdown_MoveToCurHeader")
