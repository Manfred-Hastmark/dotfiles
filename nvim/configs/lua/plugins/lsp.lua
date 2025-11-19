return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        vim.lsp.config.lua_ls = {
            capabilities = capabilities,
        }
        vim.lsp.config.bashls = {
            capabilities = capabilities,
        }
        vim.lsp.config.clangd = {
            capabilities = capabilities,
        }

        vim.lsp.config.rust_analyzer = {
            capabilities = capabilities,
        }
        vim.lsp.enable('lua_ls')
        vim.lsp.enable('bashls')
        vim.lsp.enable('clangd')
        vim.lsp.enable('rust_analyzer')

        vim.api.nvim_create_autocmd({ "TextChanged", "InsertLeave" }, {
            callback = function()
                vim.lsp.buf.format({ async = false })
            end,
        })
    end,
}
