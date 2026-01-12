return {
    settings = {
        pyright = {
            -- use Ruff's organizer
            disableOrganizeImports = true
        },
        python = {
            analysis = {
            autoSearchPaths = true,
            useLibraryCodeForTypes = true,
            diagnosticMode = "workspace",
            typeCheckingMode = "basic"
            },
        },
    },
}
