return {
    "NvChad/nvterm",
    config = function()
        require("nvterm").setup()
        local terminal = require("nvterm.terminal")
        vim.keymap.set({'n', 't'}, "<A-h>",function () terminal.toggle('horizontal') end, { noremap = true, silent = true } )
        vim.keymap.set({'n', 't'}, "<A-v>",function () terminal.toggle('vertical') end, { noremap = true, silent = true } )
    end,
}
