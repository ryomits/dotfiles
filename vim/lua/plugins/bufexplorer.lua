local bufexplorer = {
  'jlanzarotta/bufexplorer',
  init = function() vim.g.bufExplorerDisableDefaultKeyMapping = 1 end,
  keys = {
    { ',l', ':BufExplorer<CR>', { silent = true } },
  },
}

return bufexplorer
