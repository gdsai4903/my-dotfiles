vim.api.nvim_create_user_command('LspDump', function()
  local lines = vim.split(vim.inspect(vim.lsp.get_active_clients()), '\n')
  vim.cmd 'new'
  vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
end, {})

vim.api.nvim_create_user_command('LspDumpFile', function()
  local output = vim.inspect(vim.lsp.get_active_clients())
  local path = '/tmp/lsp_dump.txt'
  vim.fn.writefile(vim.split(output, '\n'), path)
  print('LSP client info written to ' .. path)
end, {})
