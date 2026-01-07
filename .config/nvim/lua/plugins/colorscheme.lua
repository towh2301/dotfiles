return {
  -- 1. Bamboo
  {
    "ribru17/bamboo.nvim",
    lazy = true,
    priority = 1000,
  },

  -- 2. Aether / Ethereal / Hackerman (Bjarneo's themes)
  { "bjarneo/aether.nvim", lazy = true, priority = 1000 },
  { "bjarneo/ethereal.nvim", lazy = true, priority = 1000 },
  { "bjarneo/hackerman.nvim", lazy = true, priority = 1000 },

  -- 3. Catppuccin (Highly recommended to configure flavor)
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
    priority = 1000,
    opts = {
      flavour = "mocha", -- latte, frappe, macchiato, mocha
      integrations = {
        mason = true,
        neotree = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
      },
    },
  },

  -- 4. Everforest
  {
    "sainnhe/everforest",
    lazy = true,
    priority = 1000,
    config = function()
      -- Optional: Set contrast (hard, medium, soft)
      vim.g.everforest_background = "medium"
    end,
  },

  -- 5. Flexoki
  { "kepano/flexoki-neovim", lazy = true, priority = 1000 },

  -- 6. Gruvbox
  { "ellisonleao/gruvbox.nvim", lazy = true, priority = 1000 },

  -- 7. Kanagawa
  { "rebelot/kanagawa.nvim", lazy = true, priority = 1000 },

  -- 8. Matte Black
  { "tahayvr/matteblack.nvim", lazy = true, priority = 1000 },

  -- 9. Monokai Pro (Needs setup call)
  {
    "loctvl842/monokai-pro.nvim",
    lazy = true,
    priority = 1000,
    opts = {
      filter = "pro", -- classic | octagon | pro | machine | ristretto | spectrum
    },
  },

  -- 10. Nord
  { "shaunsingh/nord.nvim", lazy = true, priority = 1000 },

  -- 11. Rose Pine
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = true,
    priority = 1000,
  },

  -- 12. Tokyo Night (Default LazyVim theme, added here for completeness)
  {
    "folke/tokyonight.nvim",
    lazy = true,
    priority = 1000,
    opts = { style = "storm" },
  },

  -- 13. Moonfly
  {
    "bluz71/vim-moonfly-colors",
    name = "moonfly",
    lazy = false,
    priority = 1000,
  },

  -- 14. Nightfly
  {
    "bluz71/vim-nightfly-colors",
    name = "nightfly", -- this lets you do colors = "nightfly" later
    lazy = false, -- load immediately (colorscheme)
    priority = 1000, -- highest priority for colorschemes
    opts = {}, -- opts is ignored by this plugin → use config instead
    config = function()
      vim.g.nightflyTransparent = true -- this is the official way
      -- optional extras you might like:
      vim.g.nightflyNormalFloat = true -- make floats transparent too
      vim.g.nightflyWinSeparator = 2 -- thinner separators (0 = none, 1 = default, 2 = thin)

      vim.cmd.colorscheme("nightfly")
    end,
  },

  -- Set colorscheme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "nightfly",
    },
  },
}
