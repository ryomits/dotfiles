local config = function()
  vim.keymap.set('n', '<Leader>tt', '<Cmd>TestFile<CR>')
  vim.keymap.set('n', '<Leader>tn', '<Cmd>TestFile<CR>')
end

local test = {
  'vim-test/vim-test',
  event = 'BufRead',
  config = config,
}

return test
