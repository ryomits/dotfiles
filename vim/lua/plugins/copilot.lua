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
    })
  end,
}

return copilot
