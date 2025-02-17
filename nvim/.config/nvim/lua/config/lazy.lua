local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)
vim.g.maplocalleader = " "
require("lazy").setup({
	spec = {

		-- add LazyVim and import its plugins
		{
			"LazyVim/LazyVim",
			import = "lazyvim.plugins",
			opts = {
				colorscheme = "nightfox",
				news = {
					lazyvim = true,
					neovim = true,
				},
			},
		},

		{ import = "lazyvim.plugins.extras.dap.core" },

		-- import AI plugins
		{ import = "lazyvim.plugins.extras.ai.copilot" },
		{ import = "lazyvim.plugins.extras.ai.copilot-chat" },

		-- import language plugins
		{ import = "lazyvim.plugins.extras.lang.tailwind" },
		{ import = "lazyvim.plugins.extras.lang.typescript" },
		{ import = "lazyvim.plugins.extras.lang.json" },

		-- import prettier plugins
		{ import = "lazyvim.plugins.extras.linting.eslint" },
		{ import = "lazyvim.plugins.extras.formatting.prettier" },

		-- import/override with your plugins
		{ import = "plugins" },
	},
	defaults = {
		-- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
		-- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
		lazy = false,
		-- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
		-- have outdated releases, which may break your Neovim install.
		version = false, -- always use the latest git commit
		-- version = "*", -- try installing the latest stable version for plugins that support semver
	},
	install = { colorscheme = { "tokyonight", "habamax" } },
	checker = {
		enabled = true, -- check for plugin updates periodically
		notify = false, -- notify on update
	}, -- automatically check for plugin updates
	performance = {
		rtp = {
			-- disable some rtp plugins
			disabled_plugins = {
				"gzip",
				-- "matchit",
				-- "matchparen",
				-- "netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})

-- add the terminal configuration
function _G.set_terminal_keymaps()
	-- for conciseness
	local opt = { noremap = true }
	local api = vim.api

	-- setup keymap
	api.nvim_buf_set_keymap(0, "t", "<esc>", [[ <C-\><C-n> ]], opt)
	api.nvim_buf_set_keymap(0, "t", "jk", [[ <C-\><C-n> ]], opt)
	api.nvim_buf_set_keymap(0, "t", "<C-h>", [[ <C-\><C-n><C-W>h ]], opt)
	api.nvim_buf_set_keymap(0, "t", "<C-j>", [[ <C-\><C-n><C-W>j ]], opt)
	api.nvim_buf_set_keymap(0, "t", "<C-k>", [[ <C-\><C-n><C-W>k ]], opt)
	api.nvim_buf_set_keymap(0, "t", "<C-h>", [[ <C-\><C-n><C-W>h ]], opt)
	api.nvim_buf_set_keymap(0, "t", "<C-l>", [[ <C-\><C-n><C-W>l ]], opt)
end

vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
