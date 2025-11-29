return {
    "numToStr/Comment.nvim",
    enabled = true,
    config = function()
        -- "gc" and "bc" to comment out
        -- upd: "bc" seem not to work for some reason
        require("Comment").setup()
    end
}
