-- For Rust
return {
  {
    "mrcjkb/rustaceanvim",
    version = "^6",
    lazy = false,
    config = function()
      -- Configure rustaceanvim
      vim.g.rustaceanvim = {
        tools = {
          hover_actions = {
            auto_insert = true,
          },
          code_action_group = true,
        },
        server = {
          default_settings = {
            ["rust-analyzer"] = {
              diagnostics = {
                disable = { "unlinked-file" },
              },
              checkOnSave = {
                command = "clippy",
              },
              inlayHints = {
                enable = true,
                showParameterNames = true,
                parameterHintsPrefix = "→ ",
                chainingHints = { enable = true },
                chainingHintsSeparator = " → ",
                typeHints = { enable = false },
                typeHintsSeparator = " = ",
                lifetimeElisionHints = { enable = true, useParameterNames = true },
                closureReturnTypeHints = { enable = "always" },
              },
              imports = {
                granularity = {
                  group = "module",
                },
                prefix = "self",
              },
              cargo = {
                buildScripts = {
                  enable = true,
                },
              },
              procMacro = {
                enable = true,
              },
            },
          },
        },
      }
    end,
  },

  {
    "rust-lang/rust.vim",
    ft = "rust",
    init = function()
      vim.g.rustfmt_autosave = 1
      -- Use latest edition
      vim.g.rust_recommended_style = 1
    end,
  },

  -- Extra Rust tools
  {
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    config = true,
  },
}
