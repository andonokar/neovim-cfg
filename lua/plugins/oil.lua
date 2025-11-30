return {
    'stevearc/oil.nvim',
    enabled = true,
    opts = {},
    dependencies = { { "nvim-mini/mini.icons", opts = {} } },
    lazy = false,
    config = function ()
        require('oil').setup({})
        vim.keymap.set("n", "<leader>pv", "<CMD>Oil<CR>")
    end
}
