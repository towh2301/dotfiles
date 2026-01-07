return {
  "nvim-java/nvim-java",
  ft = "java",
  config = function()
    require("java").setup()
    -- Optional: configure LSP if needed (usually not required)
    require("lspconfig").jdtls.setup({})
  end,
}
