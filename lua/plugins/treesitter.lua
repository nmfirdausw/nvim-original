return {
  { 
    "nvim-treesitter/nvim-treesitter",
    version = false,
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "jwalton512/vim-blade",
      { 
        "HiPhish/rainbow-delimiters.nvim",
        branch = "use-children"
      },
    },
    config = function () 
      local configs = require("nvim-treesitter.configs")
      local rainbow_delimiters = require 'rainbow-delimiters'
      configs.setup({
        ensure_installed = {
          "bash",
          "html",
          "javascript",
          "jsdoc",
          "json",
          "lua",
          "luadoc",
          "luap",
          "markdown",
          "markdown_inline",
          "query",
          "regex",
          "tsx",
          "typescript",
          "vim",
          "vimdoc",
          "yaml",
          "php",
          "css"
        },
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },  
      })
      
      -- Rainbow bracket
      vim.g.rainbow_delimiters = {
        strategy = {
          [''] = rainbow_delimiters.strategy['global'],
          vim = rainbow_delimiters.strategy['local'],
        },
        query = {
          [''] = 'rainbow-delimiters',
          lua = 'rainbow-blocks',
        },
        highlight = {
          'RainbowDelimiterRed',
          'RainbowDelimiterYellow',
          'RainbowDelimiterBlue',
          'RainbowDelimiterOrange',
          'RainbowDelimiterGreen',
          'RainbowDelimiterViolet',
          'RainbowDelimiterCyan',
        },
      }
    end
  },
}
