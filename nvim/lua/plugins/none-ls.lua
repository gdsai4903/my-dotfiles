return {
  'nvimtools/none-ls.nvim',
  dependencies = {
    'nvimtools/none-ls-extras.nvim',
    'jayp0521/mason-null-ls.nvim', -- ensure dependencies are installed
  },
  config = function()
    local null_ls = require 'null-ls'
    local formatting = null_ls.builtins.formatting
    local diagnostics = null_ls.builtins.diagnostics

    -- Setup mason-null-ls to install required tools
    require('mason-null-ls').setup {
      ensure_installed = {
        'prettier',
        'stylua',
        'eslint_d',
        'shfmt',
        'checkmake',
        'ruff',
      },
      automatic_installation = true,
    }

    -- Define formatting and diagnostic sources
    local sources = {
      -- Diagnostics
      diagnostics.checkmake,

      require('none-ls.diagnostics.ruff').with {
        extra_args = { 'I', '--ignore', 'E501' },
      },

      -- Formatters
      formatting.prettier.with {
        extra_args = { '--tab-width', '4', '--use-tabs', 'false' },
        filetypes = { 'json', 'css', 'javascript', 'typescript', 'yaml', 'markdown', 'html' },
      },
      formatting.stylua,
      formatting.shfmt.with { args = { '-i', '4' } },

      -- Ruff with E501 disabled
      require('none-ls.formatting.ruff').with {
        extra_args = { '--extend-select', 'I', '--ignore', 'E501' },
      },
      require 'none-ls.formatting.ruff_format',
    }

    -- Autoformat on save
    local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
    null_ls.setup {
      sources = sources,
      on_attach = function(client, bufnr)
        if client.supports_method 'textDocument/formatting' then
          vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
          vim.api.nvim_create_autocmd('BufWritePre', {
            group = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format { async = false, timeout_ms = 5000 }
            end,
          })
        end
      end,
    }
  end,
}
