return {
    "tpope/vim-fugitive",
    enabled = true,
    config = function()
        vim.keymap.set("n", "<leader>g", vim.cmd.Git, { desc = 'Fugitive [G]it status' } )
    end
}


