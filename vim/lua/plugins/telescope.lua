local telescope_config = function()
  require("telescope").load_extension("ui-select")
  require('telescope').setup {
    extensions = {
      ['ui-select'] = {
        require('telescope.themes').get_dropdown {}
      }
    }
  }
end

local telescope = {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-telescope/telescope-ui-select.nvim' },
  },
  init = function()
    local function builtin(name)
      return function(option)
        return function()
          return require('telescope.builtin')[name](option or {})
        end
      end
    end

    vim.keymap.set('n', '<C-p>', builtin 'find_files' {})
    vim.keymap.set('n', 'mr', builtin 'live_grep' {})
    vim.keymap.set('n', 'md', builtin 'diagnostics' {})
    vim.keymap.set('n', 'mf', builtin 'current_buffer_fuzzy_find' {})
    vim.keymap.set('n', 'mh', builtin 'help_tags' { lang = 'ja' })
    vim.keymap.set('n', 'mo', builtin 'oldfiles' {})
    vim.keymap.set('n', 'gs', builtin 'git_status' {})
  end,
  config = telescope_config,
}

return telescope
