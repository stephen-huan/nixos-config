-- custom header
vim.g.startify_custom_header = ""
-- update sessions
vim.g.startify_session_persistence = 0
-- keybindings
vim.keymap.set(
    "n",
    "<leader>s",
    "<cmd>execute 'SSave!' . fnamemodify(v:this_session, ':t')<cr>"
)
