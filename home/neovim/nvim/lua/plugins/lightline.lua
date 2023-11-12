vim.g.lightline = {
    -- set lightline colorscheme
    colorscheme = "polar",
    -- remove 'fileformat' and 'fileencoding' from the default bar
    active = {
        right = {
            { "lineinfo" },
            { "percent" },
            { "filetype" },
        },
    },
}
