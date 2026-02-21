-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.opt.textwidth = 80

vim.g.clipboard = {
  name = 'OSC 52',
  copy = {
    ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
    -- ['*'] = require('vim.ui.clipboard.osc52').copy('*'),   -- opcional, primary selection
  },
  paste = {
    ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
    -- ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
  },
}
