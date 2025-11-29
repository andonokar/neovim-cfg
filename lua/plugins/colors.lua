return {
    -- vscode.nvim configuration
    {
        "Mofiqul/vscode.nvim",
        enabled = true,
        config = function()
            require('vscode').setup({
                transparent = true,
                italic_comments = true,
                color_overrides = {
                    vscLineNumber = '#FFFFFF',
                }
            })
        end
    },
    {
        "EdenEast/nightfox.nvim",
        enabled = true,
        config = function()
            -- No additional setup needed unless you have specific settings for nightfox
        end
    },
    {
        "projekt0n/github-nvim-theme",
        enabled = true,
        config = function()
            require('github-theme').setup({
            })
        end
    },

}

