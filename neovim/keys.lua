local global = vim.g
local wk = require('which-key')

global.mapleader = " "

wk.register({
  ['ev'] = { '<cmd>:vsplit $MYVIMRC<CR>', 'Open Vim Config' },
  ['sv'] = { '<cmd>:source $MYVIMRC<CR>', 'Reload Vim Config' },
}, { prefix = '<Leader>' })

wk.register({
  name = "Movement",

  ['<Leader><Leader>'] = { '<C-^>', 'Toggle Last File' },
  ['<C-j>'] = { '<C-w>j', '' },
  ['<C-k>'] = { '<C-w>k', '' },
  ['<C-h>'] = { '<C-w>h', '' },
  ['<C-l>'] = { '<C-w>l', '' },
})

wk.register({
  name = "Search",

  ['ff'] = { '<cmd>Telescope find_files<CR>', 'Search Files' },
  ['fl'] = { '<cmd>Telescope live_grep<CR>', 'File Grep' },
  ['fg'] = { '<cmd>Telescope oldfiles<CR>', 'Search Recent Files' },
  ['fb'] = { '<cmd>Telescope buffers<CR>', 'Search Buffers' },
  ['fc'] = { '<cmd>Telescope commands<CR>', ' Commands' },
  ['fh'] = { '<cmd>Telescope oldfiles<CR>', 'Search Tags' },
  ['fe'] = { '<cmd>Telescope file_browser<CR>', 'File Browser' },

  ['/'] = { '<cmd>:nohlsearch<CR>', 'Clear Search Highlights' },
}, { prefix = '<Leader>' })

wk.register({
  name = "Diagnostics",

  ['tr'] = { '<cmd>Trouble<CR>', 'Trouble Diagnostics' },
}, { prefix = '<Leader>' })

wk.register({
  name = "VimTree",

  x = { '<cmd>NvimTreeToggle<CR>', 'Toggle File Tree' },
}, { prefix = '<Leader>' })

