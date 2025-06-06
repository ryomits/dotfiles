local config = function()
  require('mason-lspconfig').setup({
    automatic_installation = {
      exclude = {
        'gopls',
      }
    }
  })
end

local mason = {
  'williamboman/mason-lspconfig.nvim',
  dependencies = {
    {
      'williamboman/mason.nvim',
      config = function()
        require('mason').setup()
        require('mason-lspconfig').setup()
      end,
    },
  },
  config = config,
  event = { 'BufReadPre', 'BufNewFile', 'BufEnter', 'BufNew' },
}

return mason
