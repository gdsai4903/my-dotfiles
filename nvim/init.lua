if vim.g.vscode then
  vim.opt.cmdheight = 1 -- Set command height for VSCode Neovim
  return
end

require 'core.options' -- Load general options
require 'core.keymaps' -- Load general keymaps
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
require('lazy').setup {
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
  require 'plugins.lsp',
  require 'plugins.autocompletion',
  require 'plugins.comment',
  require 'plugins.live-server',
  require 'plugins.autotag',
  require 'plugins.lazygit',
  require 'plugins.indent-blankline',
  require 'plugins.snacks',
}

-- Automatically detect and use Conda Python for Pyright
local conda_env = os.getenv 'CONDA_PREFIX'
if conda_env then
  local lspconfig = require 'lspconfig'
  if lspconfig then
    lspconfig.pyright.setup {
      settings = {
        python = {
          pythonPath = conda_env .. '/bin/python',
        },
      },
    }
    print('Using Conda environment: ' .. conda_env)
  else
    print 'Warning: lspconfig not found!'
  end
else
  print 'No Conda environment detected!'
end

-- Modeline for Vim settings
-- vim: ts=2 sts=2 sw=2 et
