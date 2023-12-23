return {
    "ibhagwan/fzf-lua",
    dependencies = {
        "nvim-tree/nvim-web-devicons"
    },
    config = function()
        require("fzf-lua").setup({})
    end,
    keys = {
		{ "<leader>ff", ":FzfLua files<CR>", desc = "Fzf" },
		{ "<leader>fg", ":FzfLua live_grep<CR>", desc = "Fzf" },
    }
}
