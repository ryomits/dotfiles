local config = function()
  require("telescope").load_extension("ui-select")
  require('telescope').setup {
		defaults = {
      vimgrep_arguments = {
        'rg',
        '--color=never',
        '--no-heading',
        '--with-filename',
        '--line-number',
        '--column',
        '--smart-case',
        '--hidden',
        '--glob',
        '!.git/'
      },
    },
    extensions = {
      ['ui-select'] = {
        require('telescope.themes').get_dropdown({})
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

    vim.keymap.set('n', '<C-p>', builtin('find_files')({ find_command = { 'rg', '--hidden', '--glob', '!.git/', '--files' } }))
    vim.keymap.set('n', 'mr', builtin 'live_grep' {})
    vim.keymap.set('n', 'md', builtin 'diagnostics' {})
    vim.keymap.set('n', 'mf', builtin 'current_buffer_fuzzy_find' {})
    vim.keymap.set('n', 'mh', builtin 'help_tags' { lang = 'ja' })
    vim.keymap.set('n', 'mo', builtin 'oldfiles' {})
    vim.keymap.set('n', 'mc', builtin 'commands' {})
    vim.keymap.set('n', ',l', builtin 'buffers' {})
  end,
  config = config,
}

return telescope
