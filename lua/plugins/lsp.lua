return {
    {
        "VonHeikemen/lsp-zero.nvim",
        enabled = true,
        branch = "v3.x",
        dependencies = {
            -- lsp support
            {
                "williamboman/mason.nvim"
            },
            { "williamboman/mason-lspconfig.nvim" },
            { "neovim/nvim-lspconfig" },
            -- metals support
            { "scalameta/nvim-metals" },
            { "nvim-lua/plenary.nvim" },
            -- autocompletion
            { "hrsh7th/nvim-cmp" },
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-path" },
            { "hrsh7th/cmp-nvim-lsp" },
            { "L3MON4D3/LuaSnip", }
        },
        config = function()
            -- TODO: figure out do we still need mason? or 0.11+ can install LSP servers automatically?
            require("mason").setup({})
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "pyright",
                    "gopls",
                    "clangd",
                },
            })
            local cmp = require('cmp')
            cmp.setup({
                window = {
                    -- bordered seemingly work well with copilot when tabbing options
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                ---@diagnostic disable-next-line: undefined-field
                mapping = cmp.mapping.preset.insert({
                    ['<Tab>'] = cmp.mapping.select_next_item(),
                    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<CR>'] = cmp.mapping.confirm({ select = false }),
                })

            })
        end
    },
}
