return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        vim.lsp.config.cmake = {
            capabilities = capabilities,
        }
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
        vim.lsp.config.html = {
            capabilities = capabilities,
        }
        vim.lsp.config.cssls = {
            capabilities = capabilities,
        }
        vim.lsp.config.ts_ls = {
            capabilities = capabilities,
            filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
        }
        vim.lsp.config.eslint = {
            capabilities = capabilities,
        }
        vim.lsp.config.tailwindcss = {
            capabilities = capabilities,
        }
        vim.lsp.config.pyright = {
            capabilities = capabilities,
        }
        vim.lsp.config.ruff = {
            capabilities = capabilities,
        }

        vim.lsp.enable('cmake')
        vim.lsp.enable('lua_ls')
        vim.lsp.enable('bashls')
        vim.lsp.enable('clangd')
        vim.lsp.enable('rust_analyzer')
        vim.lsp.enable('html')
        vim.lsp.enable('cssls')
        vim.lsp.enable('ts_ls')
        vim.lsp.enable('eslint')
        vim.lsp.enable('tailwindcss')
        vim.lsp.enable('pyright')
        vim.lsp.enable('ruff')

        vim.diagnostic.config({
            severity_sort = true,
        })

        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(args)
                local client = vim.lsp.get_client_by_id(args.data.client_id)
                if client and client.supports_method("textDocument/formatting") then
                    vim.api.nvim_create_autocmd({ "TextChanged", "InsertLeave" }, {
                        buffer = args.buf,
                        callback = function()
                            vim.lsp.buf.format({ async = false, bufnr = args.buf })
                        end,
                    })
                end
            end,
        })

        vim.api.nvim_create_autocmd({ "TextChanged", "InsertLeave" }, {
            pattern = { "*.c", "*.cpp", "*.cc", "*.cxx", "*.h", "*.hpp", "*.rs" },
            callback = function()
                vim.cmd("silent! write")
            end,
        })
    end,
}
