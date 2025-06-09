local fugitive = {
  'tpope/vim-fugitive',
   keys = {
     { 'gb', ':Git blame<CR>', { silent = true } },
   },
   config = function()
    vim.api.nvim_create_autocmd('FileType', {
       pattern = 'git',
       callback = function()
         opt.number = false
       end,
     })
   end
}

return fugitive
