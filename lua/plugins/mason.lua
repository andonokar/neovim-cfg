return {
    "williamboman/mason.nvim",
    enabled = true,
    dependencies = {
        { "williamboman/mason-lspconfig.nvim" },
    },
    config = function()
        require("mason").setup({})
        require("mason-lspconfig").setup({
            ensure_installed = {
                "pyright",
                "clangd",
                "bashls"
            },
        })
    end
}
