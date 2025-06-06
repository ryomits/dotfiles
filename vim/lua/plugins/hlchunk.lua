local hlchunk = {
  'shellRaining/hlchunk.nvim',
  event = { 'UIEnter' },
  config = function()
    require('hlchunk').setup({
			indent = {
				enable = true,
			}
    })
  end
}

return hlchunk
