return {
	{
		"rebelot/kanagawa.nvim",
		lazy = false,
		priority = 1000000,
		config = function()
			require("kanagawa").setup({
				transparent = true,
				theme = "dragon",
				colors = {
					palette = {},
					theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
				},
				background = {
					dark = "dragon",
					light = "dragon",
				},
			})
			vim.cmd("colorscheme kanagawa-dragon")
		end,
	},
}
