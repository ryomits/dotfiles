local ensure_installed = {
  'lua',
  'rust',
  'typescript',
  'tsx',
  'go',
  'gomod',
  'sql',
  'toml',
  'yaml',
  'html',
  'javascript',
  'graphql',
  'markdown',
  'markdown_inline',
}

local config = function()
  local ts = require('nvim-treesitter')
  ts.install(ensure_installed)

  vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('treesitter_highlight', {}),
    callback = function(ev)
      -- yamlはハイライトが崩れるため無効化（旧設定のdisable = { 'yaml' }を踏襲）
      if ev.match == 'yaml' then
        return
      end
      local lang = vim.treesitter.language.get_lang(ev.match)
      if not lang then
        return
      end
      if vim.tbl_contains(ts.get_installed(), lang) then
        vim.treesitter.start(ev.buf, lang)
      elseif vim.tbl_contains(ts.get_available(), lang) then
        ts.install(lang):await(function()
          if vim.api.nvim_buf_is_valid(ev.buf) then
            pcall(vim.treesitter.start, ev.buf, lang)
          end
        end)
      end
    end,
  })
end

local treesitter = {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  lazy = false,
  build = ':TSUpdate',
  config = config,
}

return treesitter
