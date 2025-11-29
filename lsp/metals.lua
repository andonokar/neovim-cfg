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

return {
    settings = metals_config.settings
}
