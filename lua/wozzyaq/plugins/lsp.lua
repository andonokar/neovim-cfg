return {
    {
        "VonHeikemen/lsp-zero.nvim",
        enabled = true,
        branch = "v3.x",
        dependencies = {
            -- lsp support
            {
                "williamboman/mason.nvim"
            },
            { "williamboman/mason-lspconfig.nvim" },
            { "neovim/nvim-lspconfig" },
            -- metals support
            { "scalameta/nvim-metals" },
            { "nvim-lua/plenary.nvim" },
            -- autocompletion
            { "hrsh7th/nvim-cmp" },
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-path" },
            { "hrsh7th/cmp-nvim-lsp" },
            { "L3MON4D3/LuaSnip", }
        },
        config = function()
            local lsp_zero = require('lsp-zero')
            lsp_zero.on_attach(function(client, bufnr)
                if client.name == 'ruff_lsp' then
                    client.server_capabilities.hoverProvider = false
                end
                local opts = { buffer = bufnr, remap = false }
                lsp_zero.default_keymaps({ buffer = bufnr })
                -- use telescope's go-to references
                local telescope = require('telescope.builtin')
                if client.name ~= 'metals' then
                    vim.keymap.set('n', 'gr', telescope.lsp_references, opts)
                    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
                    vim.keymap.set('n', 'gd', telescope.lsp_definitions, opts)
                    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
                    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
                    vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
                    vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
                    vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
                    vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
                    vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
                    vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>', opts)
                    vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>', opts)
                    vim.keymap.set('n', '<leader>q', '<cmd>lua vim.diagnostic.open_float(0, {scope = "line"})<cr>', opts)
                end
            end)

            require("mason").setup({})
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "pyright",
                    "gopls",
                    "clangd",
                },
                handlers = {
                    lsp_zero.default_setup,
                },
            })

            vim.lsp.config['gopls'] = {
                capabilities = lsp_zero.get_capabilities(),
                settings = {
                    gopls = {
                        analyses = {
                            unusedparams = true,
                        },
                        staticcheck = true,
                    },
                },
            }
            vim.lsp.enable('gopls')

            vim.lsp.config['clangd'] = {
                cmd = { 'clangd', '--background-index', '--clang-tidy', '--log=verbose' },
                init_options = {
                },
            }
            vim.lsp.enable('clangd')

            local cmp = require('cmp')
            cmp.setup({
                window = {
                    -- bordered seemingly work well with copilot when tabbing options
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                ---@diagnostic disable-next-line: undefined-field
                mapping = cmp.mapping.preset.insert({
                    ['<Tab>'] = cmp.mapping.select_next_item(),
                    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<CR>'] = cmp.mapping.confirm({ select = false }),
                })

            })

            -- Metals configuration
            ---@diagnostic disable-next-line: undefined-field
            local metals_config = require("metals").bare_config()
            metals_config.settings = {
                showImplicitArguments = true,
                showInferredType = true,
                showImplicitConversionsAndClasses = true,
                excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
            }
            -- Based on https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/quick-recipes.md#setup-with-nvim-metals
            -- seemingly, we need to share lsp_zero capabilities to metals config
            --metals_config.capabilities = lsp_zero.get_capabilities()
            --local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
            --vim.api.nvim_create_autocmd("FileType", {
            --    pattern = { "scala", "sbt", "java", "scala.worksheet.scala.worksheet.sc"},
            --    callback = function()
            --        require("metals").initialize_or_attach(metals_config)
            --    end,
            --    group = nvim_metals_group,
            --})

            vim.lsp.config['metals'] = {
                settings = metals_config.settings
            }
            vim.lsp.enable('metals')


            vim.lsp.config['lua_ls'] = {
                -- Command and arguments to start the server.
                cmd = { 'lua-language-server' },
                -- Filetypes to automatically attach to.
                filetypes = { 'lua' },
                -- Sets the "workspace" to the directory where any of these files is found.
                -- Files that share a root directory will reuse the LSP server connection.
                -- Nested lists indicate equal priority, see |vim.lsp.Config|.
                root_markers = { { '.luarc.json', '.luarc.jsonc' }, '.git' },
                -- Specific settings to send to the server. The schema is server-defined.
                -- Example: https://raw.githubusercontent.com/LuaLS/vscode-lua/master/setting/schema.json
                settings = {
                    Lua = {
                        runtime = {
                            version = 'LuaJIT',
                        },
                        diagnostics = {
                            globals = { 'vim' }
                        },
                        workspace = {
                            -- Make the server aware of Neovim runtime files
                            library = vim.api.nvim_get_runtime_file("", true),
                        },
                        telemetry = {
                            enable = false
                        }
                    }
                }
            }
            vim.lsp.enable('lua_ls')


            vim.lsp.config['pyright'] = {
                capabilities = lsp_zero.get_capabilities(),
                settings = {
                    pyright = {
                        -- use Ruff's organizer
                        disableOrganizeImports = true
                    },
                    python = {
                        analysis = {
                            ignore = { '*' }
                        },
                    },
                },
            }
            vim.lsp.config['lsp_ruff'] = {
                init_options = {
                    settings = {
                        args = {}
                    }
                }
            }
            vim.lsp.enable('pyright')
            vim.lsp.enable('lsp_ruff')

            vim.diagnostic.config({ virtual_text = true, })
        end

    },
}
