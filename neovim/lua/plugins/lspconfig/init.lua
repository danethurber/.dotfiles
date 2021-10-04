local present1, lspconfig = pcall(require, "lspconfig")
local present2, lspinstall = pcall(require, "lspinstall")

if not (present1 or present2) then
  return
end

local languages = require('plugins.lspconfig.format')
local on_attach = require('plugins.lspconfig.on-attach')

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local function setup_servers()
  lspinstall.setup()
  -- local servers = lspinstall.installed_servers()

  -- local required = { "lua", "typescript" }
  -- for _, server in pairs(required) do
  --   if not vim.tbl_contains(servers, server) then
  --     lspinstall.install_server(server)
  --   end
  -- end

  -- lspinstall.setup()

  local installed = lspinstall.installed_servers()
  for _, lang in pairs(installed) do
    local config = {
      on_attach = on_attach,
      capabilities = capabilities,
      root_dir = lspconfig.util.root_pattern({ '.git/', '.' })
    }

    if lang == "efm" then
      config.filetypes = {
        "javascript",
        "javascript.jsx",
        "javascriptreact",
        "lua",
        "typescript",
        "typescript.tsx",
        "typescriptreact",
      }

      config.init_options = {
        codeAction = true,
        documentFormatting = true,
        document_formatting = true
      }

      config.on_attach = function(client, bufnr)
        client.resolved_capabilities.document_formatting = true
        on_attach(client, bufnr)
      end

      config.settings = {
        languages = languages,
        log_level = 1,
        log_file = '~/efm.log'
      }
    end

    if lang == "lua" then
      config.settings = {
        Lua = {
          diagnostics = {
            enable = true,
            globals = { "use", "vim" }
          },
          telemetry = { enable = false },
          workspace = {
            library = {
              [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true
            },
            maxPreload = 100000,
            preloadFileSize = 10000
          },
        }
      }
    end

    if lang == "typescript" then
      config.on_attach = function(client, bufnr)
        client.resolved_capabilities.document_formatting = false

        if client.config.flags then
          client.config.flags.allow_incremental_sync = true
        end

        on_attach(client, bufnr)
      end
    end

    lspconfig[lang].setup(config)
  end
end

setup_servers()

lspinstall.post_install_hook = function()
  setup_servers() -- reload installed servers
  vim.cmd("bufdo e") -- triggers FileType autocmd that starts the server
end

local function set_sign(type, icon)
  local sign = string.format("LspDiagnosticsSign%s", type)
  local texthl = string.format("LspDiagnosticsDefault%s", type)
  vim.fn.sign_define(sign, { text = icon, texthl = texthl })
end

set_sign("Hint", "")
set_sign("Information", "")
set_sign("Warning", "")
set_sign("Error", "ﰸ")

vim.lsp.handlers["textDocument/publishDiagnostics"] =
  vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics,
  {
    signs = true,
    underline = true,
    update_in_insert = false,
    virtual_text = false,
  }
)

vim.lsp.handlers["textDocument/hover"] =
  vim.lsp.with(vim.lsp.handlers.hover,
  { border = "single" }
)

vim.lsp.handlers["textDocument/signatureHelp"] =
  vim.lsp.with(
  vim.lsp.handlers.signature_help,
  { border = "single" }
)

-- suppress error messages from lang servers
vim.notify = function(msg, log_level)
  if msg:match("exit code") then
    return
  end

  if log_level == vim.log.levels.ERROR then
    vim.api.nvim_err_writeln(msg)
  else
    vim.api.nvim_echo({{msg}}, true, {})
  end
end
