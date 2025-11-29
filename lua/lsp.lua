-- FIXME: need to figure out how to properly attach capabilities and mappings LSP + telescope 
local lsp_zero = require('lsp-zero')
lsp_zero.on_attach(function(client, bufnr)
    if client.name == 'ruff_lsp' then
        client.server_capabilities.hoverProvider = false
    end
    local opts = { buffer = bufnr, remap = false }
    lsp_zero.default_keymaps({ buffer = bufnr })
    -- use telescope's go-to references
    local telescope = require('telescope.builtin')
        vim.keymap.set('n', 'gr', telescope.lsp_references, opts)
        vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
        vim.keymap.set('n', 'gd', telescope.lsp_definitions, opts)
        vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
        vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
        vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
        vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
        vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
        vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
        vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
        vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>', opts)
        vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>', opts)
        vim.keymap.set('n', '<leader>q', '<cmd>lua vim.diagnostic.open_float(0, {scope = "line"})<cr>', opts)
end)

-- local capabilities = vim.lsp.protocol.make_client_capabilities()
local capabilities = lsp_zero.get_capabilities()
capabilities = vim.tbl_deep_extend('force', capabilities, {
    offsetEncoding = { 'utf-16' },
    general = {
      positionEncodings = { 'utf-16' },
    },
  })
vim.lsp.config('*', {
    capabilities = capabilities
})

vim.diagnostic.config({ virtual_text = true, })
