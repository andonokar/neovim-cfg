local function on_attach(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    if client.name == 'ruff_lsp' then
        client.server_capabilities.hoverProvider = false
    end
    local opts = { buffer = args.buf, remap = false }
    -- use telescope's go-to references
    local telescope = require('telescope.builtin')
    vim.keymap.set('n', 'gr', telescope.lsp_references, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gd', telescope.lsp_definitions, opts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', 'go', vim.lsp.buf.type_definition, opts)

    vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'x' }, 'gq', function() vim.lsp.buf.format({ async = true }) end, opts)
    vim.keymap.set('n', '<F4>', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
    vim.keymap.set('n', '<leader>q', function() vim.diagnostic.open_float({ scope = "line" }) end, opts)
end

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('my.lsp', {}),
    callback = on_attach
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend('force', capabilities, {
    offsetEncoding = { 'utf-16' },
    general = {
        positionEncodings = { 'utf-16' },
    },
})
vim.lsp.config('*', {
    capabilities = capabilities
})

local metals_config = require("metals").bare_config()
metals_config.capabilities = capabilities

local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "scala", "java", "sbt", "sc" },
    callback = function()
        require("metals").initialize_or_attach(metals_config)
    end,
    group = nvim_metals_group,
})
vim.lsp.enable({ 'lua_ls', 'pyright', 'lsp_ruff', 'metals', 'gopls', 'bashls' })

vim.diagnostic.config({ virtual_text = true, })
