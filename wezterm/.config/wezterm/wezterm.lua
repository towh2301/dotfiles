-- +----------------------------+
-- | WezTerm Configuration file |
-- +----------------------------+

local wezterm = require("wezterm")
local pad = 6
local line_height = 1.2

local font_normal = {
	family = "FiraCode Nerd Font",
	weight = "Regular",
	italic = false,
}

local font_italic = {
	family = "FiraCode Nerd Font",
	weight = "DemiBold",
	italic = true,
}

local function load_font(font)
	return wezterm.font(font.family, {
		weight = font.weight,
		italic = font.italic,
	})
end

return {
	-- Window, layout
	window_padding = {
		left = pad,
		right = pad,
		top = pad,
		bottom = pad,
	},
	window_frame = {
		active_titlebar_bg = "#3c3836",
		inactive_titlebar_bg = "#3c3836",
	},
	window_background_opacity = 0.95,
	hide_tab_bar_if_only_one_tab = true,
	enable_tab_bar = false,
	enable_wayland = true, -- It will crash if enabled = true when using scaling wayland
	initial_cols = 100,
	initial_rows = 40,

	-- Fonts
	font = load_font(font_normal),
	font_size = 13,
	font_rules = {
		{
			italic = true,
			font = load_font(font_italic),
		},
	},
	line_height = line_height,

	-- Colors
	color_scheme = "night_owl",
	color_schemes = {
		gruvbox = {
			foreground = "#ebdbb2",
			background = "#282828",
			cursor_bg = "#928374",
			cursor_border = "#ebdbb2",
			cursor_fg = "#282828",
			selection_bg = "#ebdbb2",
			selection_fg = "#3c3836",

			ansi = {
				"#282828", -- black
				"#cc241d", -- red
				"#98971a", -- green
				"#d79921", -- yellow
				"#458588", -- blue
				"#b16286", -- purple
				"#689d6a", -- aqua
				"#ebdbb2", -- white
			},

			brights = {
				"#928374", -- black
				"#fb4934", -- red
				"#b8bb26", -- green
				"#fabd2f", -- yellow
				"#83a598", -- blue
				"#d3869b", -- purple
				"#8ec07c", -- aqua
				"#fbf1c7", -- white
			},
		},
		night_owl = {
			foreground = "#d6deeb",
			background = "#011627",
			cursor_bg = "#7e57c2",
			cursor_border = "#d6deeb",
			cursor_fg = "#011627",
			selection_bg = "#5f7e97",
			selection_fg = "#080c12",

			ansi = {
				"#011627", -- black
				"#ef5350", -- red
				"#22da6e", -- green
				"#c5e478", -- yellow
				"#82aaff", -- blue
				"#c792ea", -- purple
				"#21c7a8", -- aqua
				"#ffffff", -- white
			},

			brights = {
				"#575656", -- black
				"#ff869a", -- red
				"#9effa1", -- green
				"#ffffa5", -- yellow
				"#7fdbca", -- blue
				"#f78c6c", -- purple
				"#a1efe4", -- aqua
				"#ffffff", -- white
			},
		},
	},

	-- Keybinds
	keys = {
		{
			key = "h",
			mods = "CTRL | SHIFT",
			-- Previous tab
			action = wezterm.action({ ActivateTabRelative = -1 }),
		},
		{
			key = "l",
			mods = "CTRL | SHIFT",
			-- Next tab
			action = wezterm.action({ ActivateTabRelative = 1 }),
		},
		{
			key = "j",
			mods = "CTRL | SHIFT",
			-- Scroll down
			action = wezterm.action({ ScrollByLine = 1 }),
		},
		{
			key = "k",
			mods = "CTRL | SHIFT",
			-- Scroll up
			action = wezterm.action({ ScrollByLine = -1 }),
		},

		-- close tab
		{
			key = "w",
			mods = "CTRL",
			action = wezterm.action({ CloseCurrentTab = { confirm = true } }),
		},
	},
}
