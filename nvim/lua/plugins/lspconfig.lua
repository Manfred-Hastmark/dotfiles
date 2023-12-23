return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp"
    },
    config = function()
        local lspconfig = require("lspconfig")
        local capabilities = require("cmp_nvim_lsp").default_capabilities()

        lspconfig.clangd.setup{
            capabilities = capabilities,
        }

        -- Format on save for C/C++
        vim.api.nvim_create_augroup('AutoFormatting', {})
        vim.api.nvim_create_autocmd({'TextChanged', 'InsertLeave'}, {
            pattern = {"*.cpp", "*.cc", "*.c", "*.hpp", "*.hh", "*.h"},
            group = 'AutoFormatting',
            callback = function()
                vim.lsp.buf.format({ async = false })
                vim.cmd("write")
            end,
        })
    end,
}
