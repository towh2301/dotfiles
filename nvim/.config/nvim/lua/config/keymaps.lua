-- set local keybinds
local opts = { noremap = true, silent = true }
local term_opts = { silent = true }
local keymap = vim.keymap -- for conciseness

-- set leader key to space
keymap.set("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
-- vim.g.maplocalleader = " "

------------------
-- General Keymaps
-------------------

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>", opts)
-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", opts)

-- delete single character without copying into register
keymap.set("n", "x", '"_x')

-- inline options
keymap.set("n", "<S-e>", "<S-w>$", opts) -- move cursor to end of line
keymap.set("n", "<S-f>", "0", opts) -- move cursor to begin of line
keymap.set("v", "<S-e>", "<S-w>$", opts) -- move cursor to end of line - VISUAL MODE
keymap.set("v", "<S-f>", "0", opts) -- move cursor to begin of line - VISUAL MODE

-- window management
keymap.set("n", "sv", "<C-w>v") -- split window vertically
keymap.set("n", "sh", "<C-w>s") -- split window horizontally
keymap.set("n", "se", "<C-w>=") -- make split windows equal width & height
keymap.set("n", "sc", ":close<CR>") -- close current split window

-- Better window navigation
keymap.set("n", "<leader>h", "<C-w>h", opts) -- move cursor to right windows
keymap.set("n", "<leader>j", "<C-w>j", opts) -- move cursor to below windows
keymap.set("n", "<leader>k", "<C-w>k", opts) -- move cursor to up windows
keymap.set("n", "<leader>l", "<C-w>l", opts) -- move cursor to left windows

-- resize with arrows
keymap.set("n", "<C-Up>", ":resize +2<CR>", opts) -- resize horizontal
keymap.set("n", "<C-Down>", ":resize -2<CR>", opts)
keymap.set("n", "<C-Right>", ":vertical resize -2<CR>", opts) -- resize vertical
keymap.set("n", "<C-Left>", ":vertical resize +2<CR>", opts)

-- pressing ENTER key
-- keymap.set("n", "<leader>pe", ":Lex 30<cr>", opts) -- literally pressing the ENTER key

-- tab management
keymap.set("n", "to", ":tabnew<CR>", opts) -- open new tab
keymap.set("n", "tc", ":tabclose<CR>", opts) -- close current tab
keymap.set("n", "tn", ":tabn<CR>", opts) -- go to next tab
keymap.set("n", "tp", ":tabp<CR>", opts) -- go to previous tab

------------
-- VISUAL --
------------

-- Stay in indent mode
keymap.set("v", "<", "<gv", opts)
keymap.set("v", ">", ">gv", opts)

-- Move text up and down
keymap.set("v", "<A-j>", ":m .+1<CR>==", opts)
keymap.set("v", "<A-k>", ":m .-2<CR>==", opts)
keymap.set("v", "p", '"_dP', opts) -- prevents copying what was pasted -

-- Navigate buffers
keymap.set("n", "<S-l>", ":bnext<CR>", opts)
keymap.set("n", "<S-h>", ":bprevious<CR>", opts)

-- Visual Block --
-- Move text up and down
keymap.set("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap.set("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap.set("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap.set("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- vim-maximizer
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>", opts) -- toggle split window maximization

-- Neotree
keymap.set("n", "<leader>e", ":Neotree toggle<CR>", opts) -- toggle file explorer
keymap.set("n", "<leader>o", ":Neotree focus<CR>", opts) -- focus file explorer
