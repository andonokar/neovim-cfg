local o = vim.o

-- make tab behave as 4 spaces
o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.expandtab = true

-- enable relative numbers
o.nu = true
o.relativenumber = true

-- disable info
o.showmode = false

-- disable line wraps
o.wrap = false

o.hlsearch = false
o.incsearch = true

-- show effects of commands as you type
o.inccommand = 'split'

o.termguicolors = true

-- sticky scroll
o.scrolloff = 8

o.colorcolumn = "120"

o.swapfile = false
o.backup = false
o.undodir = os.getenv("HOME") .. "/.vim/undodir"
o.undofile = true


-- sync os clipboard with neos
o.clipboard = 'unnamedplus'

-- line wrapping
o.wrap = false

o.winborder = 'rounded'

-- highlight current line number
o.cursorline = true
o.cursorlineopt = 'number'

-- so diagnostics don't jump
o.signcolumn = 'yes'
