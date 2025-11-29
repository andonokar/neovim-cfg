return {
    "lukas-reineke/indent-blankline.nvim",
    enabled = true,
    config = function()
        require('ibl').setup({
            scope = { enabled = true },
        })
    end,
}
