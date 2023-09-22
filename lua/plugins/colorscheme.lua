return {
  "projekt0n/caret.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require('caret').setup({
      -- ...
    })

    vim.cmd('colorscheme caret')
  end,
}
