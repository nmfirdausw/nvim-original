return {
	{
		"lukas-reineke/indent-blankline.nvim",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			char = "▏",
			-- char = "│",
			filetype_exclude = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason" },
			show_trailing_blankline_indent = false,
			show_current_context = false,
		},
	},
	{
		"echasnovski/mini.indentscope",
		version = false,
		event = "BufReadPre",
		opts = {
			draw = {
				delay = 1,
			},
			symbol = "▏",
			-- symbol = "│",
			options = { try_as_border = true },
		},
		config = function(_, opts)
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason" },
				callback = function()
					vim.b.miniindentscope_disable = true
				end
			})
			require("mini.indentscope").setup(opts)
			vim.api.nvim_set_hl(0, 'MiniIndentScopeSymbol', { fg = "#ea9d34" })
		end,
	},
	{
		"NMAC427/guess-indent.nvim",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("guess-indent").setup()
			vim.cmd.lua({ args = { "require('guess-indent').set_from_buffer('auto_cmd')" }, mods = { silent = true } })
		end,
	},
}
