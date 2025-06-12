local toggleterm = {
  'akinsho/toggleterm.nvim',
  version = "*",
  config = {
    size = 30,
  },
  keys = {
    { "<Leader>to", ":ToggleTerm<CR>", desc = "Toggle Terminal" },
  },
}

return toggleterm
