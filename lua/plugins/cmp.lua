return {
    "hrsh7th/nvim-cmp",
    enabled = true,
    dependencies = {
        { "hrsh7th/cmp-buffer" },
        { "hrsh7th/cmp-path" },
        { "hrsh7th/cmp-nvim-lsp" },
        { "L3MON4D3/LuaSnip", }
    },
    config = function()
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
            }),
            sources = {
                { name = 'nvim_lsp' },
                { name = 'buffer' },
                { name = 'path' },
                -- optional:
                { name = 'luasnip' },
            },

        })
    end
}
