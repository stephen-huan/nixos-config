-- stylua: ignore
return require("packer").startup({function(use)
    -- package manager
    use "wbthomason/packer.nvim"
    -- colorscheme, fork of habamax/vim-polar
    use {
        "stephen-huan/polar.nvim",
        config = function()
            -- set colorscheme
            vim.cmd.colorscheme "polar"
        end,
    }
    -- ranger integration
    use {
        "francoiscabrol/ranger.vim",
        requires = { "rbgrouleff/bclose.vim" },
        config = function()
            vim.g.ranger_replace_netrw = 1
            vim.g.ranger_map_keys = 0
            -- keybindings
            vim.keymap.set(
                "n",
                "<leader>r",
                "<cmd>RangerCurrentDirectoryNewTab<cr>"
            )
        end,
    }
    -- cython
    use "lambdalisue/vim-cython-syntax"
end,
config = {
    compile_path = require("packer.util").join_paths(
        vim.fn.stdpath "data", "site", "plugin", "packer_compiled.lua"
    ),
}})
