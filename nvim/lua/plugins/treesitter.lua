return {
    "nvim-treesitter/nvim-treesitter",
    config = function()
        require("nvim-treesitter.configs").setup{
            ensure_installed = {"cpp", "c", "lua"},
            sync_install = false,
            auto_install = true,
            highlight = {  -- Fixed the typo here
                enable = true,
            },
        }
    end,
}

