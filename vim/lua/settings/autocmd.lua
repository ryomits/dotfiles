local auto_mkdir = function(dir)
  if vim.fn.isdirectory(dir) == 0 then
    vim.fn.mkdir(dir, 'p')
  end
end
vim.filetype.add({
  extension = {
    graphqxl = 'graphql',
  }
})
local file_indents = {
  {
    pattern = 'go',
    callback = function()
      vim.bo.tabstop = 4
      vim.bo.shiftwidth = 4
    end,
  },
  {
    pattern = 'rust',
    callback = function()
      vim.bo.tabstop = 4
      vim.bo.softtabstop = 4
      vim.bo.shiftwidth = 4
      vim.bo.expandtab = true
    end,
  },
  {
    pattern = {
      'javascript',
      'typescriptreact',
      'typescript',
      'vim',
      'lua',
      'yaml',
      'json',
      'jsonc',
      'sh',
      'zsh',
      'markdown',
      'php',
      'graphql',
    },
    callback = function()
      vim.bo.tabstop = 2
      vim.bo.softtabstop = 2
      vim.bo.shiftwidth = 2
      vim.bo.expandtab = true
      vim.bo.smartindent = true
      vim.bo.autoindent = true
    end,
  },
}
local indent_group = vim.api.nvim_create_augroup('fileTypeIndent', { clear = true })
for _, indent in ipairs(file_indents) do
  vim.api.nvim_create_autocmd('FileType', {
    pattern = indent.pattern,
    callback = indent.callback,
    group = indent_group,
  })
end

vim.api.nvim_create_autocmd('QuickFixCmdPost', {
  pattern = '*grep*',
  command = 'cwindow',
  group = vim.api.nvim_create_augroup('grepWindow', { clear = true }),
})

vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  callback = function()
    vim.cmd('startinsert')
    vim.cmd('setlocal scrolloff=0 listchars= nonumber norelativenumber')
  end,
  group = vim.api.nvim_create_augroup("neovimTerminal", { clear = true }),
})

vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*',
  callback = function()
    auto_mkdir(vim.fn.expand('<afile>:p:h'))
  end,
  group = vim.api.nvim_create_augroup('autoMkdir', { clear = true })
})
