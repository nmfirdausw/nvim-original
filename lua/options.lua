vim.opt.viewoptions:remove "curdir"
vim.opt.shortmess:append { s = true, I = true }
vim.opt.backspace:append { "nostop" }
vim.opt.diffopt:append "linematch:60"

local options = {
	opt = {
    breakindent = true,
	clipboard = "unnamedplus",
    completeopt = { "menu", "menuone", "noselect" },
    confirm = true,
    copyindent = true,
    cursorcolumn = true,
    cursorline = true,
	expandtab = true,
    fileencoding = "utf-8",
    fillchars= { eob = " " },
    foldenable = true,
    foldlevel = 99,
    foldlevelstart = 99,
    foldcolumn = "1",
    history = 100,
    ignorecase = true,
    infercase = true,
    laststatus = 3,
    linebreak = true,
    mouse = "a",
    number = true,
    numberwidth = 1,
    preserveindent = true,
    pumheight = 10,
    relativenumber = true,
    scrolloff = 8,
	shiftwidth = 2,
    sidescrolloff = 8,
    signcolumn = "number",
    smartcase = true,
    smartindent = true,
    splitbelow = true,
    splitright = true,
	tabstop = 2,
    termguicolors = true,
    undofile = true,
    updatetime = 300,
    virtualedit = "block",
    wrap = false,
    writebackup = false,
    swapfile = false,
	},
  g = {
    mapleader = " ",
    maplocalleader = ",",
  }
}

for scope, table in pairs(options) do
	for setting, value in pairs(table) do
		vim[scope][setting] = value
	end
end
