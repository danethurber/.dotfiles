package.path = "/Users/dane/.dotfiles/neovim/lua/?.lua;" .. package.path

local modules = {
  'plugins',
  'options',
  'mappings',
  'utils',
}

for i = 1, #modules, 1 do
  require(modules[i])
end

-- links:
--   • https://github.com/shaunsingh/vimrc-dotfiles/tree/main/.config/nvim
--   • https://github.com/ashton/dotfiles/blob/master/.config/nvim/lua/lsp/init.lua
