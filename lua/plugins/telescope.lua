return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  cmd = "Telescope",
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" }},
    {"<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" }},
    {"<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" }},
    {"<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" }},
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  config = function(_, opts)
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
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
        path_display = { "truncate " },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
            ["<C-j>"] = actions.move_selection_next, -- move to next result
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          },
        },
      },
    })

    telescope.load_extension("fzf")
  end,
}
