if vim.g.vscode then
  vim.opt.cmdheight = 1 -- Set command height for VSCode Neovim
  return
end

require 'core.options' -- Load general options
require 'core.keymaps' -- Load general keymaps
require 'core.commands' -- Load general keymaps
require 'core.snippets' -- Custom code snippets

-- Set up the Lazy plugin manager
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Load plugins via Lazy
require('lazy').setup({
  require 'plugins.lsp',
  require 'plugins.mini',
  require 'plugins.neotree',
  require 'plugins.bufferline',
  require 'plugins.dadbod',
  require 'plugins.smear-cursor',
  require 'plugins.refactoring',
  require 'plugins.gitsigns',
  require 'plugins.misc',
  require 'plugins.none-ls',
  require 'plugins.colortheme',
  require 'plugins.lualine',
  require 'plugins.markdown-preview',
  require 'plugins.treesitter',
  require 'plugins.telescope',
  require 'plugins.autocompletion',
  require 'plugins.comment',
  require 'plugins.live-server',
  require 'plugins.autotag',
  require 'plugins.lazygit',
  require 'plugins.indent-blankline',
  require 'plugins.snacks',
}, {
  ui = {
    border = 'rounded', -- or "single", "double", etc.
    icons = {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      source = '📄',
      start = '🚀',
      task = '📌',
    },
  },
})

-- Modeline for Vim settings
-- vim: ts=2 sts=2 sw=2 et
