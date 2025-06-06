local config = function()
  vim.keymap.set('n', 'gop', '<Plug>(openbrowser-open)')
end

local open_browser = {
  'tyru/open-browser-github.vim',
  dependencies = {
    {
      'tyru/open-browser.vim',
      config = config,
    },
  }
}

return open_browser
