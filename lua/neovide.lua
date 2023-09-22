if vim.g.neovide then
	vim.o.guifont = "JetBrainsMono Nerd Font Mono:h17"
	vim.g.neovide_padding_top = 30
	vim.g.neovide_padding_bottom = 30
	vim.g.neovide_padding_right = 30
	vim.g.neovide_padding_left = 30
	vim.g.neovide_refresh_rate = 165
	vim.g.neovide_input_macos_alt_is_meta = true
	vim.g.neovide_cursor_vfx_mode = "pixiedust"
	vim.g.neovide_cursor_antialiasing = false
else
  vim.opt.cursorcolumn = true
  vim.opt.cursorline = true
end
