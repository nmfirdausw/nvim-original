return {
	"nvim-telescope/telescope.nvim",
	cmd = "Telescope",
	version = false,
	keys = {
		{ "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find Files" } },
		{ "<leader>fw", "<cmd>Telescope live_grep<cr>", { desc = "Find Word" } },
	},
	opts = {
		defaults = {
			borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
			sorting_strategy = "ascending",
			layout_strategy = "flex",
			prompt_prefix = " ",
			selection_caret = " ",
			layout_config = {
				prompt_position = "top",
				vertical = { mirror = true },
				flex = { flip_columns = 140 },
			},
		},
	},
}
