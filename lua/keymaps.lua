local set = vim.keymap.set

set("v", "<", "<gv", { desc = "Indent line" })
set("v", ">", ">gv", { desc = "Unindent line" })

set(
	"v",
	"<leader>/",
	"<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>",
	{ desc = "Comment" }
)
set("n", "<leader>/", function()
	require("Comment.api").toggle.linewise.count(vim.v.count > 0 and vim.v.count or 1)
end, { desc = "Comment Line" })

set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

set("n", "J", "mzJ`z", { desc = "Append up bottom line" })

set("n", "<C-d>", "<C-d>zz", { desc = "Jump half page up" })
set("n", "<C-u>", "<C-u>zz", { desc = "Jump half page down" })

set("n", "n", "nzzzv", { desc = "Next" })
set("n", "N", "Nzzzv", { desc = "Previous" })

set("x", "<leader>p", '"_dP', { desc = "Paste from clipboard" })

set("n", "|", "<cmd>vsplit<cr>", { desc = "Vertical Split" })
set("n", "\\", "<cmd>split<cr>", { desc = "Horizontal Split" })

set("n", "<leader>tt", "<cmd>ToggleTerm direction=float<cr>", { desc = "Open Terminal" })

set("n", "<leader>w", "<cmd>w<cr>", { desc = "Save" })
set("n", "<leader>q", "<cmd>confirm q<cr>", { desc = "Quit" })

set("n", "L", "<cmd>bnext<cr>", { desc = "Next buffer" })
set("n", "H", "<cmd>bprev<cr>", { desc = "Previous buffer" })

set("n", "<leader>gg", "<cmd>GoBlade<cr>", { desc = "Laravel Go To" })
