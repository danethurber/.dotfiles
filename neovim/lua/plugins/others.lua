local configs = {}

configs.blankline = function()
  vim.g.indentLine_enabled = 1
  vim.g.indent_blankline_char = "▏"

  vim.g.indent_blankline_filetype_exclude = { "help", "terminal", "dashboard" }
  vim.g.indent_blankline_buftype_exclude = { "terminal" }

  vim.g.indent_blankline_show_trailing_blankline_indent = false
  vim.g.indent_blankline_show_first_indent_level = false
end


configs.lspkind = function()
  local present, lspkind = pcall(require, "lspkind")

  if present then
    lspkind.init()
  end
end

configs.lsputils = function()
  local present, _ = pcall(require, "lsputils")

  if present then
    vim.lsp.handlers['textDocument/codeAction'] = require'lsputil.codeAction'.code_action_handler
    vim.lsp.handlers['textDocument/references'] = require'lsputil.locations'.references_handler
    vim.lsp.handlers['textDocument/definition'] = require'lsputil.locations'.definition_handler
    vim.lsp.handlers['textDocument/declaration'] = require'lsputil.locations'.declaration_handler
    vim.lsp.handlers['textDocument/typeDefinition'] = require'lsputil.locations'.typeDefinition_handler
    vim.lsp.handlers['textDocument/implementation'] = require'lsputil.locations'.implementation_handler
    vim.lsp.handlers['textDocument/documentSymbol'] = require'lsputil.symbols'.document_handler
    vim.lsp.handlers['workspace/symbol'] = require'lsputil.symbols'.workspace_handler
  end
end

configs.lspstatus = function()
  local present, status = pcall(require, "lsp-status")

  if present then

    status.register_progress()
  end
end

configs.lualine = function()
  local present, lualine = pcall(require, "lualine")

  if present then
    local diagnostics = {
      'diagnostics',
      sources = { 'nvim_lsp' },
      symbols = { error = ' ', warn = ' ', info = ' ' },
    }

    local git_diff = {
      'diff',
      symbols = { added = ' ', modified = '柳 ', removed = ' ' },
      color_added = "#9ece6a",
      color_modified = "#ff9e64",
      color_red = "#f7768e",
    }

    local lsp = {
      function()
        local msg = '年'
        local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
        local clients = vim.lsp.get_active_clients()

        if next(clients) == nil then return msg end

        for _, client in ipairs(clients) do
          local filetypes = client.config.filetypes
          if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
            return client.name .. ' 力'
          end
        end

        return msg
      end, seperator = 'nil'
    }

    lualine.setup {
      options = {
        component_separators = { '', '' },
        disabled_filetypes = { 'dashboard', 'NvimTree' },
        icons_enabled = true,
        section_separators = { '', '' },
        theme = 'nord',
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch' },
        lualine_c = { 'filename' },
        lualine_x = { lsp },
        lualine_y = { diagnostics, git_diff },
        lualine_z = { }
      }
    }
  end
end

configs.trouble = function()
  local present, trouble = pcall(require, "trouble")

  if present then
    trouble.setup()
  end
end

return configs
