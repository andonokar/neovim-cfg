return {
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
