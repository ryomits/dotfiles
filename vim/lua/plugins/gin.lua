local config = function()
  vim.keymap.set('n', 'gs', '<Cmd>GinStatus<CR>')
  vim.keymap.set('n', 'gl', '<Cmd>GinLog -p<CR>')
  vim.keymap.set('n', 'gh', '<Cmd>GinBrowse<CR>')
end

local gina = {
  'lambdalisue/gin.vim',
  config = config,
}

return gina

