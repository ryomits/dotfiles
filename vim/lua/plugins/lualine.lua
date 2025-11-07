local lualine_config = function()
  local theme = require('lualine.themes.nightfox')
  require('lualine').setup({
    options = {
      theme = theme,
    },
    sections = {
      lualine_x = { "ccusage" },
    },
  })
end
local lualine = {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    { 'kyazdani42/nvim-web-devicons' },
  },
  config = lualine_config,
}

return lualine
