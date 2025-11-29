return {
    "nvim-lualine/lualine.nvim",
    enabled = true,
    config = function()
        require('lualine').setup({
            options = {
                icons_enabled = true,
            }
        })
    end
}
