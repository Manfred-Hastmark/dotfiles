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
            cmd = {"clangd"},
            args = {
                "--all-tokens",
                "--index-file",
                "--clang-tidy",
                "--pretty"
            },
        }

        lspconfig.pyright.setup{
            capabilities = capabilities,
        }

        lspconfig.cmake.setup{}

        lspconfig.angularls.setup{filetypes = {"*.tsx"}}
        -- Format on save for C/C++
        vim.api.nvim_create_augroup('AutoFormatting', {})
        vim.api.nvim_create_autocmd({'TextChanged', 'InsertLeave'}, {
            pattern = {"*.cpp", "*.cc", "*.c", "*.hpp", "*.hh", "*.h", "*.tpp", "*CMake*"},
            group = 'AutoFormatting',
            callback = function()
                vim.lsp.buf.format({ async = false })
                vim.cmd("write")
            end,
        })
        vim.api.nvim_create_autocmd({'TextChanged', 'InsertLeave'}, {
            pattern = {'*.ini'},
            group = 'AutoFormatting',
            callback = function()
                vim.cmd("write")
            end,
        })

        vim.lsp.set_log_level("off")
    end,
}
