return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = true,
	opts = {
    numhl = true,
    signcolumn = false,
  }
}
