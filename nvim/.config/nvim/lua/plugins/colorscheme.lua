return {
	{
		"EdenEast/nightfox.nvim",
		lazy = true,
		priority = 1000,
		config = function()
			require("nightfox").setup({
				options = {
					transparent = true,
				},
			})
		end,
	},
	-- lua/plugins/rose-pine.lua
	{
		"rose-pine/neovim",
		name = "rose-pine",
		config = function()
			require("rose-pine").setup({
				styles = {
					transparency = true,
					italic = false,
					bold = false,
				},
			})
		end,
	},
	{ "bluz71/vim-nightfly-colors", name = "nightfly", lazy = false, priority = 1000 },
	-- {
	-- 	"folke/tokyonight.nvim",
	-- 	lazy = true,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		-- vim.g.tokyonight_style = "night"
	-- 		-- vim.g.tokyonight_italic_functions = false
	-- 		-- vim.g.tokyonight_italic_variables = false
	-- 		-- vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer" }
	-- 		-- vim.g.tokyonight_colors = { hint = "orange", error = "#ff0000" }
	-- 		-- vim.cmd("colorscheme tokyonight")
	--      require()
	-- 	end,
	-- },
}
