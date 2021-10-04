local lspstatus = require('lsp-status')

return function (client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { noremap = true, silent = true }

  lspstatus.on_attach(client)

  buf_set_keymap('n', '<C-k>', '<cmd>Lspsaga signature_help<CR>', opts)
  buf_set_keymap('n', '<leader>D', '<Cmd>Lspsaga preview_definition<CR>', opts)
  buf_set_keymap('n', '<leader>ca', '<Cmd>Lspsaga code_action<CR>', opts)
  buf_set_keymap('n', '<leader>e', '<cmd>Lspsaga show_line_diagnostics<CR>', opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>Lspsaga rename<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>Lspsaga hover_doc<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>Lspsaga diagnostic_jump_next<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>Lspsaga diagnostic_jump_prev<CR>', opts)
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gs', '<Cmd>Lspsaga signature_help<CR>', opts)

  if client.resolved_capabilities.document_formatting then
    vim.cmd [[autocmd! BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 1000)]]
  end

  if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  elseif client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end

  print('LSP started...')
end
