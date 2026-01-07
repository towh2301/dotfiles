return {
  "saghen/blink.cmp",
  lazy = false,
  version = "*",
  build = "cargo build --release",

  dependencies = {
    "rafamadriz/friendly-snippets",

    -- add blink.compat to dependencies
    {
      "saghen/blink.compat",
      optional = true,
      opts = {},
      version = not vim.g.lazyvim_blink_main and "*",
    },
  },

  opts = {
    keymap = {
      -- We still use 'super-tab' as a foundation but we will customize it
      preset = "super-tab",

      -- 1. ENTER to Accept
      ["<CR>"] = { "accept", "fallback" },

      ["<Tab>"] = { "snippet_forward", "fallback" },
      ["<S-Tab>"] = { "snippet_backward", "fallback" },

      -- Keep your other mappings
      ["<C-space>"] = { "show", "fallback" },
      ["<C-e>"] = { "hide", "fallback" },
      ["<C-u>"] = { "scroll_documentation_up", "fallback" },
      ["<C-d>"] = { "scroll_documentation_down", "fallback" },
    },

    -- Ensure snippets are handled by the right engine
    snippets = {
      preset = "luasnip",
    },

    appearance = {
      nerd_font_variant = "mono",
    },

    completion = {
      accept = {
        auto_brackets = { enabled = true },
      },
      menu = {
        draw = {
          treesitter = { "lsp" },
        },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 100,
      },
      ghost_text = { enabled = true },
    },

    -- Phần này là đúng và ưu tiên LSP + path cao nhất
    sources = {
      compat = {},
      default = { "lsp", "path", "snippets", "buffer" },
    },

    fuzzy = {
      implementation = "prefer_rust_with_warning",
    },

    cmdline = {
      enabled = true,
      keymap = {
        preset = "cmdline",
        -- Optional: prevent arrows from selecting menu items in cmdline
        ["<Right>"] = false,
        ["<Left>"] = false,
      },
    },
  },

  config = function(_, opts)
    -- This links Blink to LazyVim's snippet expansion logic
    if LazyVim.cmp and LazyVim.cmp.expand then
      opts.snippets = opts.snippets or {}
      opts.snippets.expand = function(snippet)
        LazyVim.cmp.expand(snippet)
      end
    end

    -- Clean up the compat error
    if opts.sources then
      ---@diagnostic disable-next-line: inject-field
      opts.sources.compat = nil
    end

    require("blink.cmp").setup(opts)

    require("render-markdown").setup({
      completions = { lsp = { enabled = true } },
    })
  end,
}
