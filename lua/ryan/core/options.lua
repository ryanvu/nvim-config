vim.cmd("let g:netrw_liststyle = 3")
local prefix = vim.env.XDG_CONFIG_HOME or vim.fn.expand("~/.config")
local opt = vim.opt

opt.relativenumber = true
opt.number = true

opt.expandtab = true
opt.shiftwidth = 2
opt.smartindent = true
opt.tabstop = 2
opt.softtabstop = 2

opt.wrap = false

opt.ignorecase = true
opt.smartcase = true

opt.cursorline = true

opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

opt.backspace = "indent,eol,start"

opt.clipboard:append("unnamedplus")

opt.splitright = true
opt.splitbelow = true

opt.showmode = false
opt.undodir = { prefix .. "/nvim/.undo//" }
opt.undofile = true

opt.pumblend = 0

