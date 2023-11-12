vim.g.tcomment_mapleader1 = "<c-.>"
-- <c-_> is ctrl + /
vim.keymap.set("", "<c-_>", ":TComment<cr>")
vim.keymap.set("", "<leader>/", ":TCommentBlock<cr>")
