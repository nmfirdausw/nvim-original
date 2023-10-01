return {

  -- {
  --   "projekt0n/caret.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     require('caret').setup({
  --       -- ...
  --     })
  --
  --     vim.cmd('colorscheme caret')
  --   end,
  -- },
  --   {
  --
  --   "neanias/everforest-nvim",
  --   version = false,
  --   lazy = false,
  --   priority = 1000, -- make sure to load this before all the other start plugins
  --   -- Optional; default configuration will be used if setup isn't called.
  --   config = function()
  --     require("everforest").setup({
  --       vim.cmd('colorscheme everforest')
  --     })
  --   end,
  -- },

  --   {
  --
  --   "savq/melange-nvim",
  --   version = false,
  --   lazy = false,
  --   priority = 1000, -- make sure to load this before all the other start plugins
  --   -- Optional; default configuration will be used if setup isn't called.
  --   config = function()
  --       vim.cmd('colorscheme melange')
  --   end,
  -- },


    {

    "sainnhe/gruvbox-material",
    version = false,
    lazy = false,
    priority = 1000, -- make sure to load this before all the other start plugins
    -- Optional; default configuration will be used if setup isn't called.
    config = function()
        vim.cmd("colorscheme gruvbox-material")
    end,
  }
  --

    -- {
    -- "rebelot/kanagawa.nvim",
    --     lazy = false,
    --     priority = 1000000,
    --     config = function()
    --         require("kanagawa").setup({
    --             transparent = true,
    --             theme = "dragon",
    --             background = {
    --                 dark = "dragon",
    --                 light = "dragon",
    --             },
    --         })
    --         vim.cmd("colorscheme kanagawa-dragon")
    --     end,
    -- },
}
