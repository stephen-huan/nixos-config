require("gitsigns").setup {
    current_line_blame_opts = {
        delay = 100,
    },
    -- buffer local keybindings
    on_attach = function(bufnr)
        local gitsigns = package.loaded.gitsigns

        local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
        end

        map("n", "[c", gitsigns.prev_hunk)
        map("n", "]c", gitsigns.next_hunk)
        map("n", "ghp", gitsigns.preview_hunk)
        map("n", "ghb", gitsigns.toggle_current_line_blame)
        map("n", "ghd", gitsigns.toggle_deleted)
        map("n", "ghu", gitsigns.undo_stage_hunk)
        map("n", "ghs", gitsigns.stage_hunk)
        map("n", "ghS", gitsigns.stage_buffer)
        map("n", "ghr", gitsigns.reset_hunk)
        map("n", "ghR", gitsigns.reset_buffer)
    end,
}
