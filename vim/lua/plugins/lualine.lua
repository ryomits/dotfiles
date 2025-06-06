local lualine_config = function()
  local theme = require('lualine.themes.nightfox')
  require('lualine').setup({
    options = {
      theme = theme,
    },
    sections = {
      lualine_c = { 'filename', "lsp_progress" },
    }
  })
end
local lualine = {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    { 'kyazdani42/nvim-web-devicons' },
    { 'arkav/lualine-lsp-progress' }
  },
  config = lualine_config,
}

return lualine
