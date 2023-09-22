local icons = require("icons")

return {
	"nvim-neo-tree/neo-tree.nvim",
	cmd = "Neotree",
	keys = {
		{ "<leader>e", "<cmd>Neotree reveal<cr>", desc = "Focus File Explorer" },
		{ "<leader>te", "<cmd>Neotree toggle<cr>", desc = "Toggle File Explorer" },
	},
  dependencies = {
    { "MunifTanjim/nui.nvim" },
    { "nvim-tree/nvim-web-devicons" },
  },
	init = function()
		vim.g.neo_tree_remove_legacy_commands = true
	end,
	opts = {
		popup_border_style = "single",
		close_if_last_window = true,
		enable_diagnostics = true,
		default_component_configs = {
      indent = {
        indent_size = 2,
        padding = 0, -- extra padding on left hand side
        -- indent guides
        with_markers = true,
        indent_marker = "│",
        last_indent_marker = "└",
        highlight = "Type",
        -- expander config, needed for nesting files
        with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
        expander_collapsed = "",
        expander_expanded = "",
        expander_highlight = "NeoTreeExpander",
      },
			icon = {
				folder_closed = icons.ui.FolderClosed,
				folder_open = icons.ui.FolderOpen,
				folder_empty = icons.ui.FolderEmpty,
				default = icons.ui.DefaultFile,
			},
			modified = { symbol = icons.ui.FileModified },
			git_status = {
				symbols = {
					added = icons.git.Added,
					deleted = icons.git.Deleted,
					modified = icons.git.Modified,
					renamed = icons.git.Renamed,
					untracked = icons.git.Untracked,
					ignored = icons.git.Ignored,
					unstaged = icons.git.Unstaged,
					staged = icons.git.Staged,
					conflict = icons.git.Conflict,
				},
			},
		},
    commands = {
      parent_or_close = function(state)
        local node = state.tree:get_node()
        if (node.type == "directory" or node:has_children()) and node:is_expanded() then
          state.commands.toggle_node(state)
        else
          require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
        end
      end,
      child_or_open = function(state)
        local node = state.tree:get_node()
        if node.type == "directory" or node:has_children() then
          if not node:is_expanded() then -- if unexpanded, expand
            state.commands.toggle_node(state)
          else -- if expanded and has children, seleect the next child
            require("neo-tree.ui.renderer").focus_node(state, node:get_child_ids()[1])
          end
        else -- if not a directory just open it
          state.commands.open(state)
        end
      end,
      copy_selector = function(state)
        local node = state.tree:get_node()
        local filepath = node:get_id()
        local filename = node.name
        local modify = vim.fn.fnamemodify

        local results = {
          e = { val = modify(filename, ":e"), msg = "Extension only" },
          f = { val = filename, msg = "Filename" },
          F = { val = modify(filename, ":r"), msg = "Filename w/o extension" },
          h = { val = modify(filepath, ":~"), msg = "Path relative to Home" },
          p = { val = modify(filepath, ":."), msg = "Path relative to CWD" },
          P = { val = filepath, msg = "Absolute path" },
        }

        local messages = {
          { "\nChoose to copy to clipboard:\n", "Normal" },
        }
        for i, result in pairs(results) do
          if result.val and result.val ~= "" then
            vim.list_extend(messages, {
              { ("%s."):format(i), "Identifier" },
              { (" %s: "):format(result.msg) },
              { result.val, "String" },
              { "\n" },
            })
          end
        end
        vim.api.nvim_echo(messages, false, {})
        local result = results[vim.fn.getcharstr()]
        if result and result.val and result.val ~= "" then
          vim.notify("Copied: " .. result.val)
          vim.fn.setreg("+", result.val)
        end
      end,
    },
    window = {
      width = 30,
      mappings = {
        ["<space>"] = false,
        ["[b"] = "prev_source",
        ["]b"] = "next_source",
        o = "open",
        h = "parent_or_close",
        l = "child_or_open",
        Y = "copy_selector",
      },
    },
    filesystem = {
      follow_current_file = {
        enabled = true
      },
      hijack_netrw_behavior = "open_current",
      use_libuv_file_watcher = true,
    },
    event_handlers = {
      {
        event = "neo_tree_buffer_enter",
        handler = function(_) vim.opt_local.signcolumn = "auto" end,
      },
			{
				event = "neo_tree_buffer_enter",
				handler = function(_)
					vim.opt_local.signcolumn = "auto"
				end,
			},
			{
				event = "file_opened",
				handler = function(file_path)
					require("neo-tree").close_all()
				end,
			},
    },
  },
}
