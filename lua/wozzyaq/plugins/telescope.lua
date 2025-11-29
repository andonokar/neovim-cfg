return {
    "nvim-telescope/telescope.nvim",
    enabled = true,
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    tag = "0.1.8",
    config = function()
        local builtin = require('telescope.builtin')

        vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
        vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = 'Telescope git files' })
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
        vim.keymap.set('n', '<leader>ps', function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") });
        end, { desc = 'Telescope grep string' })
        vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

        vim.keymap.set('n', '<leader>/', function()
            builtin.current_buffer_fuzzy_find(
                require('telescope.themes').get_dropdown {
                    winblend = 10,
                    previewer = false,
                }
            )
        end, { desc = '[/] Fuzzily search in current buffer'})

        vim.keymap.set('n', '<leader>sn', function()
            builtin.find_files {
                cwd = vim.fn.stdpath 'config'
            }
        end, { desc = '[S]earch [N]eovim files'})

        local telescope = require("telescope")
        -- requires metals installed
        vim.keymap.set('n', '<leader>mc', telescope.extensions.metals.commands, { desc = 'Telescope Metals Menu' })
    end

}
