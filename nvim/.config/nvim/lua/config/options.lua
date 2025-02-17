local opt = vim.opt -- for conciseness

-- line numbers
opt.number = true
opt.relativenumber = true
-- tabs & indentation
opt.tabstop = 2 -- 2 space for tabs
opt.shiftwidth = 2 -- 2 space for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one
opt.smarttab = true -- enhance tab
opt.smartindent = true -- smart indent
opt.softtabstop = 2 -- 2 space for tab
opt.shiftround = true -- round indent to multiple of shiftwidth
opt.joinspaces = false -- don't insert two spaces after punctuation on join

-- line wrapping
opt.wrap = false -- disable line wrapping

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive
opt.hlsearch = true -- highlight all matches on previous search pattern

-- cursor line
opt.cursorline = true -- highlight the current cursor line
opt.signcolumn = "yes"

-- appearance
-- turn on termguicolors for nightfly colorscheme to work
-- (have to use iterm2(Mac only) or any other true color terminal)
opt.termguicolors = true
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes" -- show sign column so that text doesn't shift

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position
opt.completeopt = { "menuone", "noselect" } -- mostly just for cmp

-- clipboard & file options
opt.clipboard = "unnamedplus"
opt.undofile = true -- enable persistent undo
opt.fileencoding = "utf-8" -- the encoding written to a file
opt.swapfile = false -- creates a swapfile
vim.encoding = "utf-8"

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split vertical window to the bottom

-- string options
opt.iskeyword:append("-") -- consider string-string as whole word

-- time options
opt.timeoutlen = 1000 -- time to wait for a mapped sequence to complete (in milliseconds)
opt.updatetime = 300 -- faster completion (4000ms default)

-- backup
opt.backup = false -- create backup file
opt.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited

-- scroll setup
opt.scrolloff = 8 -- is one of my fav
opt.sidescrolloff = 8

-- others
opt.mouse = "a" -- allow the mouse to be used in neovim
opt.pumheight = 10 -- pop up menu height
vim.opt.showmode = false -- we don't need to see things like -- INSERT -- anymore

opt.shortmess:append("c")

-- for theme
vim.g.nightflyTransparent = true

-- under curl options
vim.cmd("set whichwrap+=<,>,[,],h,l")
vim.cmd([[set iskeyword+=-]])
