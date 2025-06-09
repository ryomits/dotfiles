local whitespace = {
  'ntpeters/vim-better-whitespace',
  event = { 'BufReadPost' },
  config = function()
    vim.g.better_whitespace_enabled = 0
    vim.g.strip_whitespace_on_save = 1
    vim.g.strip_only_modified_lines = 0
    vim.g.strip_whitespace_confirm = 0
  end,
}

return whitespace
