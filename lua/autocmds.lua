vim.api.nvim_create_autocmd(
  { "BufRead", "BufNewFile" },
  { pattern = { "*.blade.php" }, command = [[set filetype=html]] }
)

vim.api.nvim_create_autocmd(
  { "BufRead", "BufNewFile" },
  { pattern = { "*.blade.php" }, command = [[TSEnable autotag]] }
)

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local buffer = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if (client.name ~= nil and client.name == "tailwindcss") then
      vim.cmd [[TailwindColorsAttach]]
    end
  end,
})
