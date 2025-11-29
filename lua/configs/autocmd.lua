local api = vim.api

api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking',
    group = api.nvim_create_augroup('highlight-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})
