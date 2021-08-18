local global = vim.g
local wk = require('which-key')

wk.register({
  name = "Terminal",

  ['<leader>`'] = 'Toggle Terminal',
})

global.floaterm_keymap_toggle = '<leader>`'

global.floaterm_autoclose = 1
global.floaterm_height = 0.3
global.floaterm_wintype = 'split'

