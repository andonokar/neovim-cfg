local opt = vim.opt

-- make tab behave as 4 spaces
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

-- enable relative numbers
opt.nu = true
opt.relativenumber = true

-- disable info
opt.showmode = false

-- disable line wraps
opt.wrap = false

opt.hlsearch = false
opt.incsearch = true

opt.termguicolors = true

-- sticky scroll
opt.scrolloff = 8

opt.colorcolumn = "120"

opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true


-- sync os clipboard with neos
opt.clipboard = 'unnamedplus'

-- line wrapping
opt.wrap = false

