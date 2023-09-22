return {
  "williamboman/mason.nvim",
  cmd = "Mason",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")

    mason.setup({
      ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
      }
    })

    mason_lspconfig.setup({
      ensure_installed = {
        "lua_ls",
        "html",
        "tailwindcss",
        "emmet_ls",
        "cssls",
        "tsserver",
        "intelephense",
        "psalm",
      },
      automatic_installation = true,
    })
  end,
}
