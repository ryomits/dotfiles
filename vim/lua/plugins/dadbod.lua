local config = function()
  vim.api.nvim_create_autocmd("FileType", {
    pattern = {
      'mysql',
      'sql',
    },
    callback = function()
      vim.cmd([[setlocal omnifunc=vim_dadbod_completion#CompleteSQL]])
    end,
    group = vim.api.nvim_create_augroup("dadbod-ui", { clear = true }),
  })

  vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'dbout' },
    callback = function()
      vim.opt.foldenable = false
    end,
  })
end

return {
  'kristijanhusak/vim-dadbod-ui',
  dependencies = {
    { 'tpope/vim-dadbod', lazy = true },
  },
  cmd = {
    'DBUI',
    'DBUIToggle',
    'DBUIAddConnection',
    'DBUIFindBuffer',
  },
  init = function()
    vim.g.db_ui_use_nerd_font = 1
  end,
  config = config,
}
