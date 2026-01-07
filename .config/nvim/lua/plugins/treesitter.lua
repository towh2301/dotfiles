return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        -- Base
        "bash",
        "vim",
        -- "lua",
        "luadoc",
        "regex",
        "markdown",
        "markdown_inline",
        "diff",
        "gitignore",
        "query",

        -- Web Development (React, JS, TS, HTML, CSS)
        "javascript",
        "typescript",
        "tsx", -- Essential for React
        "html",
        "css",
        "scss",
        "json",
        "jsonc",

        -- Backend / Fullstack
        "python",
        "java",
        "c",
        "cpp",
        "sql",
        "dockerfile",

        -- Rust
        "rust",

        -- Config Files
        "yaml",
        "toml",
      },

      config = function(_, opts)
        local TS = require("nvim-treesitter")
        TS.setup(opts)

        -- MDX
        vim.filetype.add({
          extension = {
            mdx = "mdx",
          },
        })
        vim.treesitter.language.register("markdown", "mdx")
      end,
    },

    {
      "windwp/nvim-ts-autotag",
      dependencies = { "nvim-treesitter/nvim-treesitter" },
      ft = {
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "html",
        "vue",
      },

      opts = {
        enable = true,
      },
    },
  },
}
