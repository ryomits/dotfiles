vim.cmd('syntax enable')
vim.cmd('filetype plugin indent on')
vim.g.mapleader = " "
vim.opt.number = false
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.hlsearch = true
vim.opt.cursorline = true
vim.opt.autowrite = true
vim.opt.autoindent = true
vim.opt.virtualedit = 'block'
vim.opt.laststatus = 3
vim.opt.showtabline = 1
vim.opt.helplang = 'ja'
vim.opt.ttimeoutlen = 10
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.grepprg = 'rg --vimgrep'
vim.opt.grepformat = '%f:%l:%c:%m'
vim.opt.mouse = {}
vim.opt.completeopt = 'menu,menuone,noselect'
vim.opt.swapfile = false
vim.opt.list = true
vim.opt.breakindent = true
vim.opt.scrolloff = 100
vim.opt.diffopt = 'vertical,internal'
vim.opt.clipboard:append({ vim.fn.has('mac') == 1 and 'unnamed' or 'unnamedplus' })

local ensure_undo_dir = function()
  local undo_path = vim.fn.expand('~/.config/nvim/undo')
  if vim.fn.isdirectory(undo_path) == 0 then
    vim.fn.mkdir(undo_path --[[@as string]], 'p')
  end
  vim.opt.undodir = undo_path
  vim.opt.undofile = true
end
ensure_undo_dir()
