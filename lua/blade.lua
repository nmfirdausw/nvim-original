-- Blade file treesitter
local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.blade = {
  install_info = {
    url = "https://github.com/EmranMR/tree-sitter-blade",
    files = {"src/parser.c"},
    branch = "main",
  },
  filetype = "blade"
}

local bladeGrp vim.api.nvim_create_augroup("BladeFiltypeRelated", { clear = true })
vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"} , {
  pattern = "*.blade.php",
  group = bladeGrp,
  callback = function()
    vim.opt.filetype = "php"
  end,
})

