return {
    "folke/todo-comments.nvim",
    enabled = true,
    dependencies = {
        "nvim-lua/plenary.nvim"
    },
    config = function()
        require("todo-comments").setup({})
    end
}
