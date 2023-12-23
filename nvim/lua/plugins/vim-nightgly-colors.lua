return {
    "bluz71/vim-nightfly-colors",
    config = function()
        vim.cmd [[colorscheme nightfly]]
        vim.cmd("hi normal guibg=NONE")
    end,
}
