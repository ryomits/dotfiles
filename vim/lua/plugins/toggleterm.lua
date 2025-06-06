local toggleterm = {
  'akinsho/toggleterm.nvim',
  version = "*",
  config = {
    size = 30,
  },
  keys = {
    { "<Leader>t", ":ToggleTerm<CR>", desc = "Toggle Terminal" },
  },
}

return toggleterm
