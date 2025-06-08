local copilot = {
  'zbirenbaum/copilot.lua',
  dependencies = {
    'zbirenbaum/copilot-cmp',
  },
  config = function()
    require('copilot').setup({
      suggestion = {
        auto_trigger = true,
        keymap = {
          accept = '<C-l>',
        }
      },
      filetypes = {
        markdown = true,
        gitcommit = true,
        ['*'] = function()
          local fname = vim.fs.basename(vim.api.nvim_buf_get_name(0))
          local disable_patterns = { 'env', 'conf', 'local', 'private' }
          return vim.iter(disable_patterns):all(function(pattern)
            return not string.match(fname, pattern)
          end)
        end,
      },
    })
  end,
}

return copilot
