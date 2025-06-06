local fern = {
  'lambdalisue/fern-hijack.vim',
  dependencies = {
    'lambdalisue/fern.vim',
    cmd = 'Fern',
    config = function()
      vim.g['fern#renderer'] = 'nerdfont'
      vim.g['fern#window_selector_use_popup'] = true
      vim.g['fern#default_hidden'] = 1
      vim.g['fern#default_exclude'] = '.git$'

      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'fern',
        callback = function()
          vim.keymap.set('n', '<C-x>', '<Plug>(fern-action-open:split)', { silent = true, buffer = true })
          vim.keymap.set('n', '<C-v>', '<Plug>(fern-action-open:vsplit)', { silent = true, buffer = true })
          vim.keymap.set('n', '<C-t>', '<Plug>(fern-action-tcd)', { silent = true, buffer = true })
        end,
        group = vim.api.nvim_create_augroup('fernInit', { clear = true }),
      })
      vim.api.nvim_create_user_command('Ex', ':Fern %:h', {})
    end,
    keys = {
      { '<Leader>f', ':Fern . -drawer<CR>', { silent = true } }
    }
  },
}

return fern
