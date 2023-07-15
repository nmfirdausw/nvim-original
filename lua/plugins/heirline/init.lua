return {
	"rebelot/heirline.nvim",
	lazy = false,
	config = function()
		 local conditions = require("heirline.conditions")
		 local utils = require("heirline.utils")
		 local icons = require("icons")

		 local colors = {
		 	statusline_bg = utils.get_highlight("StatusLine").bg,
		 	tabline_bg = utils.get_highlight("TabLineFill").bg,
		 	statusline_fg = utils.get_highlight("StatusLine").fg,
		 	default_fg = utils.get_highlight("@variable").fg,
		 	comments = utils.get_highlight("Comment").fg,
		 	statements = utils.get_highlight("Statement").fg,
		 	strings = utils.get_highlight("String").fg,
		 	functions = utils.get_highlight("Function").fg,
		 	specials = utils.get_highlight("Special").fg,
		 	types = utils.get_highlight("Type").fg,
		 	operators = utils.get_highlight("Operator").fg,
		 	identifiers = utils.get_highlight("NvimIdentifier").fg,
		 	numbers = utils.get_highlight("Number").fg,
		 	variables = utils.get_highlight("@variable.builtin").fg,
		 	git_add = utils.get_highlight("GitSignsAdd").fg,
		 	git_delete = utils.get_highlight("GitSignsDelete").fg,
		 	git_change = utils.get_highlight("GitSignsChange").fg,
		 	error = utils.get_highlight("DiagnosticError").fg,
		 	warning = utils.get_highlight("DiagnosticWarn").fg,
		 	info = utils.get_highlight("DiagnosticInfo").fg,
		 	hint = utils.get_highlight("DiagnosticHint").fg,
		 }

		 require("heirline").load_colors(colors)

		 require("heirline").setup({
		 	statusline = require("plugins.heirline.statusline"),
		 	tabline = require("plugins.heirline.tabline"),
		 	opts = {
		 		-- if the callback returns true, the winbar will be disabled for that window
		 		-- the args parameter corresponds to the table argument passed to autocommand callbacks. :h nvim_lua_create_autocmd()
		 		disable_winbar_cb = function(args)
		 			return conditions.buffer_matches({
		 				buftype = { "nofile", "prompt", "help", "quickfix" },
		 				filetype = { "^git.*", "fugitive", "Trouble", "dashboard" },
		 			}, args.buf)
		 		end,
		 	},
		 })
	end,
}
