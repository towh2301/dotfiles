-- ===============================
-- 🌿 Neovim Keymaps Configuration
-- ===============================

local opts = { noremap = true, silent = true }
local term_opts = { silent = true }
local keymap = vim.keymap

-- -----------------------------
-- Leader Key Configuration
-- -----------------------------
keymap.set("", "<Space>", "<Nop>", opts) -- disable default space key behavior
vim.g.mapleader = " " -- set <leader> to space

-- -----------------------------
-- General Keymaps
-- -----------------------------

keymap.set("i", "jk", "<ESC>", opts) -- exit insert mode quickly
keymap.set("n", "<leader>nh", ":nohl<CR>", opts) -- clear search highlights
keymap.set("n", "x", '"_x', opts) -- delete single char without copying

-- Move to beginning/end of line
keymap.set({ "n", "v" }, "<S-e>", "$", opts) -- go to end of line
keymap.set({ "n", "v" }, "<S-f>", "0", opts) -- go to beginning of line

-- -----------------------------
-- Window Management
-- -----------------------------
keymap.set("n", "sv", "<C-w>v", opts) -- split vertically
keymap.set("n", "sh", "<C-w>s", opts) -- split horizontally
keymap.set("n", "se", "<C-w>=", opts) -- equal size
keymap.set("n", "sc", ":close<CR>", opts) -- close current split

-- -----------------------------
-- Window Navigation
-- -----------------------------
keymap.set("n", "<leader>h", "<C-w>h", opts) -- move left
keymap.set("n", "<leader>j", "<C-w>j", opts) -- move down
keymap.set("n", "<leader>k", "<C-w>k", opts) -- move up
keymap.set("n", "<leader>l", "<C-w>l", opts) -- move right

-- -----------------------------
-- Window Resizing
-- -----------------------------
keymap.set("n", "<C-Up>", ":resize +2<CR>", opts)
keymap.set("n", "<C-Down>", ":resize -2<CR>", opts)
keymap.set("n", "<C-Left>", ":vertical resize +2<CR>", opts)
keymap.set("n", "<C-Right>", ":vertical resize -2<CR>", opts)

-- -----------------------------
-- Tab Management
-- -----------------------------
keymap.set("n", "to", ":tabnew<CR>", opts)
keymap.set("n", "tc", ":tabclose<CR>", opts)
keymap.set("n", "tn", ":tabn<CR>", opts)
keymap.set("n", "tp", ":tabp<CR>", opts)

-- -----------------------------
-- Visual Mode Enhancements
-- -----------------------------
keymap.set("v", "<", "<gv", opts)
keymap.set("v", ">", ">gv", opts)
keymap.set("v", "<A-j>", ":m .+1<CR>==", opts)
keymap.set("v", "<A-k>", ":m .-2<CR>==", opts)
keymap.set("v", "p", '"_dP', opts)

-- -----------------------------
-- Buffer Navigation
-- -----------------------------
keymap.set("n", "<S-l>", ":bnext<CR>", opts)
keymap.set("n", "<S-h>", ":bprevious<CR>", opts)

-- -----------------------------
-- Visual Block Mode
-- -----------------------------
keymap.set("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap.set("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap.set("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap.set("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- -----------------------------
-- Plugin Integrations
-- -----------------------------

-- Obsidian keymaps
vim.keymap.set("n", "<leader>on", "<cmd>ObsidianNew<cr>", { desc = "New Obsidian Note" })
vim.keymap.set("n", "<leader>os", "<cmd>ObsidianSearch<cr>", { desc = "Search Obsidian Notes" })
vim.keymap.set("n", "<leader>od", "<cmd>ObsidianToday<cr>", { desc = "Obsidian Daily Note" })

-- Maximizer (toggle split maximization)
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>", opts)

-- Neotree (file explorer)
keymap.set("n", "<leader>e", ":Neotree toggle<CR>", opts)
keymap.set("n", "<leader>o", ":Neotree focus<CR>", opts)

-- Markdown preview
keymap.set("n", "<leader>md", ":MarkdownPreview<cr>")
