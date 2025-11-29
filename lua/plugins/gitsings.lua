return {
    "lewis6991/gitsigns.nvim",
    tag = "v1.0.2",
    enabled = true,
    config = function()
        require("gitsigns").setup({
            current_line_blame = true,
        })
    end
}
