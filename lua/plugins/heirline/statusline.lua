local conditions = require("heirline.conditions")
local utils = require("heirline.utils")
local icons = require("icons")

local mode_colors = {
	n = "statusline_fg",
	i = "operators",
	v = "specials",
	V = "specials",
	["\22"] = "specials",
	c = "warning",
	s = "statements",
	S = "statements", ["\19"] = "statements",
	R = "warning",
	r = "orange",
	["!"] = "variables",
	t = "variables",
}

local Space = {
	provider = " ",
	hl = { bg = "statusline_bg" },
}

local Align = { provider = "%=" }

local function get_file_name(file)
	return file:match("^.+/(.+)$")
end

local FileNameBlock = {
	-- let's first set up some attributes needed by this component and it's children
	init = function(self)
		self.filename = vim.api.nvim_buf_get_name(0)
	end,
}
-- We can now define some children separately and add them later

local FileIcon = {
	init = function(self)
		local filename = self.filename
		local extension = vim.fn.fnamemodify(filename, ":e")
		self.icon, self.icon_color =
			require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
	end,
	provider = function(self)
		return self.icon and (self.icon .. " ")
	end,
	hl = function(self)
		return { fg = self.icon_color }
	end,
}

local FileName = {
	init = function(self)
		self.lfilename = vim.fn.fnamemodify(self.filename, ":.")
		if self.lfilename == "" then
			self.lfilename = "[No Name]"
		end
		self.mode = vim.fn.mode(1)
		if not self.once then
			vim.api.nvim_create_autocmd("ModeChanged", {
				pattern = "*:*o",
				command = "redrawstatus",
			})
			self.once = true
		end
	end,
	static = {
		mode_colors = mode_colors,
	},

	flexible = 2,

	{
		provider = function(self)
			return self.lfilename
	
		end,
	},
	{
		provider = function(self)
			return vim.fn.pathshorten(self.lfilename)
		end,
	},

	hl = function(self)
		local mode = self.mode:sub(1, 1)
		return { fg = self.mode_colors[mode], bg = "statusline_bg" }
	end,
}

local FileFlags = {
	{
		condition = function()
			return vim.bo.modified
		end,
		provider = icons.ui.FileModified .. " ",
		hl = { fg = "git_change", bg = "statusline_bg" },
	},
	{
		condition = function()
			return not vim.bo.modifiable or vim.bo.readonly
		end,
		provider = icons.ui.FileReadOnly .. " ",
		hl = { fg = "git_delete", bg = "statusline_bg" },
	},
}

local FileNameModifer = {
	hl = function()
		if vim.bo.modified then
			return { force = true }
		end
	end,
}

FileNameBlock = utils.insert(
	FileNameBlock,
	FileIcon,
	utils.insert(FileNameModifer, FileName),
	FileFlags,
	{ provider = "%<" } -- this means that the statusline is cut here when there's not enough space
)

local ScrollBar = {
	init = function(self)
		self.mode = vim.fn.mode(1) -- :h mode()
		if not self.once then
			vim.api.nvim_create_autocmd("ModeChanged", {
				pattern = "*:*o",
				command = "redrawstatus",
			})
			self.once = true
		end
	end,
	static = {
		-- sbar = { "█", "▇", "▆", "▅", "▄", "▃", "▂", "▁", " " },
		sbar = { " ", "▁", "▂", "▃", "▄", "▆", "▆", "▇", "█" },
		mode_colors = mode_colors,
	},
	provider = function(self)
		local curr_line = vim.api.nvim_win_get_cursor(0)[1]
		local lines = vim.api.nvim_buf_line_count(0)
		local i = math.floor((curr_line - 1) / lines * #self.sbar) + 1
		return string.rep(self.sbar[i], 2)
	end,
	hl = function(self)
		local mode = self.mode:sub(1, 1)
		return { fg = self.mode_colors[mode], bg = "statusline_bg" }
	end,
}

local ActiveLSP = {
	init = function(self)
		self.mode = vim.fn.mode(1) -- :h mode()
		if not self.once then
			vim.api.nvim_create_autocmd("ModeChanged", {
				pattern = "*:*o",
				command = "redrawstatus",
			})
			self.once = true
		end
	end,
	static = {
		mode_colors = mode_colors,
	},
	condition = conditions.lsp_attached,
	update = { "LspAttach", "LspDetach", "ModeChanged" },
	{
		provider = function()
			local names = {}
			for i, server in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
				table.insert(names, server.name)
			end
			return icons.ui.ActiveLSP .. " " .. table.concat(names, " ")
		end,

		hl = function(self)
			local mode = self.mode:sub(1, 1)
			return { fg = self.mode_colors[mode], bg = "statusline_bg" }
		end,
	},
	{
		provider = " ",
		hl = { bg = "statusline_bg" },
	},
}

local Diagnostics = {
	condition = conditions.has_diagnostics,
	init = function(self)
		self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
		self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
		self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
		self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
	end,
	update = { "DiagnosticChanged", "BufEnter" },
	{
		provider = function(self)
			return self.errors > 0 and (icons.diagnostics.Error .. self.errors .. " ")
		end,
		hl = { bg = "statusline_bg", fg = "error" },
	},
	{
		provider = function(self)
			return self.warnings > 0 and (icons.diagnostics.Warn .. self.warnings .. " ")
		end,
		hl = { bg = "statusline_bg", fg = "warning" },
	},
	{
		provider = function(self)
			return self.info > 0 and (icons.diagnostics.Info .. self.info .. " ")
		end,
		hl = { bg = "statusline_bg", fg = "info" },
	},
	{
		provider = function(self)
			return self.hints > 0 and (icons.diagnostics.Hint .. self.hints .. " ")
		end,
		hl = { bg = "statusline_bg", fg = "hint" },
	},
	hl = { bg = "statusline_bg" },
}

local GitBranch = {
	condition = conditions.is_git_repo,

	init = function(self)
		self.status_dict = vim.b.gitsigns_status_dict
		self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
	end,
	{
		condition = function(self)
			return self.has_changes
		end,
		provider = function(self)
			return " " .. self.status_dict.head .. " "
		end,
		hl = { bold = true, fg = "git_change", bg = "statusline_bg" },
	},
	{
		condition = function(self)
			return not self.has_changes
		end,
		provider = function(self)
			return " " .. self.status_dict.head .. "  "
		end,
		hl = { bold = true, fg = "default_fg", bg = "statusline_bg" },
	},
}

local GitStatus = {
	condition = conditions.is_git_repo,
	init = function(self)
		self.status_dict = vim.b.gitsigns_status_dict
		self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
	end,
	{
		provider = function(self)
			local count = self.status_dict.added or 0
			return count > 0 and (icons.git.Added .. count .. " ")
		end,
		hl = { bg = "statusline_bg", fg = "git_add" },
	},
	{
		provider = function(self)
			local count = self.status_dict.removed or 0
			return count > 0 and (icons.git.Deleted .. count .. " ")
		end,
		hl = { bg = "statusline_bg", fg = "git_delete" },
	},
	{
		provider = function(self)
			local count = self.status_dict.changed or 0
			return count > 0 and (icons.git.Modified .. count .. " ")
		end,
		hl = { bg = "statusline_bg", fg = "git_change" },
	},
}

local FileType = {
	provider = function()
		return string.upper(vim.bo.filetype)
	end,
	hl = { fg = utils.get_highlight("Type").fg, bold = true },
}

local TerminalName = {
	-- we could add a condition to check that buftype == 'terminal'
	-- or we could do that later (see #conditional-statuslines below)
	provider = function()
		local tname, _ = vim.api.nvim_buf_get_name(0):gsub(".*:", "")
		return " " .. tname
	end,
	hl = { fg = "warning", bold = true },
}

local HelpFileName = {
	condition = function()
		return vim.bo.filetype == "help"
	end,
	provider = function()
		local filename = vim.api.nvim_buf_get_name(0)
		return vim.fn.fnamemodify(filename, ":t")
	end,
	hl = { fg = "default_fg" },
}

local SearchCount = {
	condition = function()
		return vim.v.hlsearch ~= 0 and vim.o.cmdheight == 0
	end,
	init = function(self)
		local ok, search = pcall(vim.fn.searchcount)
		if ok and search.total then
			self.search = search
		end
	end,
	provider = function(self)
		local search = self.search
		return icons.ui.Search .. " " .. string.format("%d/%d", search.current, math.min(search.total, search.maxcount))
	end,
}

local MacroRec = {
	condition = function()
		return vim.fn.reg_recording() ~= "" and vim.o.cmdheight == 0
	end,
	provider = icons.ui.MacroRecording .. " ",
	hl = { fg = "git_delete", bold = true },
	utils.surround({ "@", "" }, nil, {
		provider = function()
			return vim.fn.reg_recording()
		end,
		hl = { fg = "git_delete", bold = true },
	}),
	update = {
		"RecordingEnter",
		"RecordingLeave",
	},
}

local TerminalStatusline = {
	condition = function()
		return conditions.buffer_matches({ buftype = { "terminal" } })
	end,

	hl = { bg = "statusline_bg" },

	-- Quickly add a condition to the ViMode to only show it when buffer is active!
	FileType,
	Space,
	TerminalName,
	Align,
}

local DefaultStatusline = {

	GitBranch,
	Space,
	FileNameBlock,
	Space,
	GitStatus,
	Align,
	MacroRec,
	SearchCount,
	Align,
	Diagnostics,
	Space,
	ActiveLSP,
	Space,
	ScrollBar,
}

local SpecialStatusline = {
	condition = function()
		return conditions.buffer_matches({
			buftype = { "nofile", "prompt", "help", "quickfix" },
			filetype = { "^git.*", "fugitive" },
		})
	end,

	FileType,
	Space,
	HelpFileName,
	Align,
}

local InactiveStatusline = {
	condition = conditions.is_not_active,
	FileType,
	Space,
	FileName,
	Align,
}

local StatusLines = {

	hl = function()
		if conditions.is_active() then
			return "StatusLine"
		else
			return "StatusLineNC"
		end
	end,

	fallthrough = false,
	SpecialStatusline,
	TerminalStatusline,
	InactiveStatusline,
	DefaultStatusline,
}

return StatusLines
