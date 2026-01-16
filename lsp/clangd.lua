return {
    cmd = { 'clangd', '--background-index', '--clang-tidy', '--log=verbose', '--experimental-modules-support'},
    init_options = {
    },
    filetypes = {'c', 'cpp', 'ixx', 'h', 'hpp'},
}
