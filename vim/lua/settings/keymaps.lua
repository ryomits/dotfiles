vim.keymap.set('c', '<C-b>', '<Left>', {})
vim.keymap.set('c', '<C-f>', '<Right>', {})
vim.keymap.set('c', '<C-a>', '<Home>', {})
vim.keymap.set('c', '<Up>', '<C-p>')
vim.keymap.set('c', '<Down>', '<C-n>')
vim.keymap.set('c', '<C-n>', function()
  return fn.pumvisible() == 1 and '<C-n>' or '<Down>'
end, { expr = true })
vim.keymap.set('c', '<C-p>', function()
  return fn.pumvisible() == 1 and '<C-p>' or '<Up>'
end, { expr = true })
