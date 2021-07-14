-- https://github.com/kabouzeid/nvim-lspinstall/wiki

local lsp_config = require "lspconfig"
local lsp_install = require "lspinstall"
local wk = require('which-key')

wk.register({
  name = "Language",

  ['gD'] = 'Go To Declaration',
  ['gd'] = 'Go To Definition',
  ['K'] = 'Hover Documentation',
  ['gi'] = 'List Implementations',
  ['<C-k>'] = 'Signature Help',
  ['<space>wa'] = 'Add Workspace Folder',
  ['<space>wr'] = 'Remove Workspace Folder',
  ['<space>wl'] = 'List Workspace Folders',
  ['<space>D'] = 'Type Definition',
  ['<space>rn'] = 'Rename References',
  ['gr'] = 'List References',
  ['<space>e'] = 'Show Line Diagnositics',
  ['[d'] = 'Go To Prev Diagnositic',
  [']d'] = 'Go To Next Diagnositic',
  ['<space>q'] = 'Show Diagnostics List',
})

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  elseif client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
    augroup lsp_document_highlight
    autocmd! * <buffer>
    autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
    autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
    augroup END
    ]], false)
  end
end

local lua_settings = {
  Lua = {
    runtime = {
      version = 'LuaJIT',
      path = vim.split(package.path, ';'),
    },
    diagnostics = {
      globals = { 'use', 'vim' },
    },
    workspace = {
      -- Make the server aware of Neovim runtime files
      library = {
        [vim.fn.expand('$VIMRUNTIME/lua')] = true,
        [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
      },
    },
  }
}

local function make_config()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  return {
    capabilities = capabilities,
    on_attach = on_attach,
  }
end

local function setup_servers()
  lsp_install.setup()

  local servers = lsp_install.installed_servers()

  for _, server in pairs(servers) do
    local config = make_config()

    if server == "lua" then
      config.settings = lua_settings
    end

    lsp_config[server].setup(config)
  end
end



lsp_install.post_install_hook = function ()
  setup_servers() -- reload installed servers
  vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
end

setup_servers()
