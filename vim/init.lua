local g = vim.g
local opt = vim.opt
local cmd = vim.cmd
local fn = vim.fn
local api = vim.api

local disable_plugins = {
  "loaded_gzip",
  "loaded_shada_plugin",
  "loadedzip",
  "loaded_spellfile_plugin",
  "loaded_tutor_mode_plugin",
  "loaded_gzip",
  "loaded_tar",
  "loaded_tarPlugin",
  "loaded_zip",
  "loaded_zipPlugin",
  "loaded_rrhelper",
  "loaded_2html_plugin",
  "loaded_vimball",
  "loaded_vimballPlugin",
  "loaded_getscript",
  "loaded_getscriptPlugin",
  "loaded_logipat",
  "loaded_matchparen",
  "loaded_man",
  "loaded_netrw",
  "loaded_netrwPlugin",
  "loaded_netrwSettings",
  "loaded_netrwFileHandlers",
  "loaded_logiPat",
  "did_install_default_menus",
  "did_install_syntax_menu",
  "skip_loading_mswin",
}

for _, name in pairs(disable_plugins) do
  vim.g[name] = true
end

cmd('syntax enable')
cmd('filetype plugin indent on')

g.mapleader = " "
opt.number = true
opt.encoding = 'utf-8'
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.smartindent = true
opt.hlsearch = true
opt.cursorline = true
opt.autowrite = true
opt.autoindent = true
opt.number = true
opt.virtualedit = 'block'
opt.laststatus = 3
opt.showtabline = 1
opt.helplang = 'ja'
opt.ttimeoutlen = 10
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.grepprg = 'rg --vimgrep'
opt.grepformat = '%f:%l:%c:%m'
opt.mouse = {}
opt.completeopt = 'menu,menuone,noselect'
opt.swapfile = false

local file_indents = {
  {
    pattern = 'go',
    command = 'setlocal tabstop=4 shiftwidth=4'
  },
  {
    pattern = 'rust',
    command = 'setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab'
  },
  {
    pattern = { 'javascript', 'typescriptreact', 'typescript', 'vim', 'lua', 'yaml', 'json', 'sh', 'zsh', 'markdown',
      'php' },
    command = 'setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab smartindent autoindent'
  },
}
for _, indent in pairs(file_indents) do
  api.nvim_create_autocmd('FileType', {
    pattern = indent.pattern,
    command = indent.command,
    group = api.nvim_create_augroup('fileTypeIndent', { clear = true })
  })
end

api.nvim_create_autocmd('QuickFixCmdPost', {
  pattern = '*grep*',
  command = 'cwindow',
  group = api.nvim_create_augroup('grepWindow', { clear = true }),
})

api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  callback = function()
    cmd('startinsert')
    cmd('setlocal scrolloff=0')
    opt.number = false
  end,
  group = api.nvim_create_augroup("neovimTerminal", { clear = true }),
})

local lualine_config = function()
  require('lualine').setup({})
end


local fern_config = function()
  g['fern#renderer'] = 'nerdfont'
  g['fern#window_selector_use_popup'] = true
  g['fern#default_hidden'] = 1
  g['fern#default_exclude'] = '.git$'

  api.nvim_create_autocmd('FileType', {
    pattern = 'fern',
    callback = function()
      vim.keymap.set('n', '<C-x>', '<Plug>(fern-action-open:split)', { silent = true, buffer = true })
      vim.keymap.set('n', '<C-v>', '<Plug>(fern-action-open:vsplit)', { silent = true, buffer = true })
      vim.keymap.set('n', '<C-t>', '<Plug>(fern-action-tcd)', { silent = true, buffer = true })
    end,
    group = api.nvim_create_augroup('fernInit', { clear = true }),
  })
  api.nvim_create_user_command('Ex', ':Fern %:h', {})
end

local nightfox_config = function()
  opt.termguicolors = false
  cmd([[
    colorscheme Nordfox
    hi VertSplit guifg=#535353
    hi Visual ctermfg=159 ctermbg=23 guifg=#b3c3cc guibg=#384851
  ]])
end

local nvim_cmp_config = function()
  local cmp = require('cmp')
  cmp.setup({
    window = {
    },
    preselect = cmp.PreselectMode.None,
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-x><C-o>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = {
      { name = 'nvim_lsp' },
      { name = 'vsnip' },
      {
        name = 'buffer',
        option = {
          get_bufnrs = function()
            local bufs = {}
            for _, win in ipairs(api.nvim_list_wins()) do
              bufs[api.nvim_win_get_buf(win)] = true
            end
            return vim.tbl_keys(bufs)
          end
        }
      },
      { name = 'path' },
    },
    snippet = {
      expand = function(args)
        fn['vsnip#anonymous'](args.body)
      end
    },
  })
end

local lsp_on_attach = function(client, bufnr)
  client.server_capabilities.semanticTokensProvider = nil
  -- api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  local bufopts = { silent = true, buffer = bufnr }
  vim.keymap.set('n', '<Leader>i', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-\\>', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, bufopts)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, bufopts)
  vim.keymap.set('n', '<C-g><C-d>', vim.diagnostic.open_float, bufopts)
  opt.tagfunc = 'v:lua.vim.lsp.tagfunc'

  local organize_import = function()
  end
  local actions = vim.tbl_get(client.server_capabilities, 'codeActionProvider', "codeActionKinds")
  if actions ~= nil and vim.tbl_contains(actions, "source.organizeImports") then
    organize_import = function()
      vim.lsp.buf.code_action({ context = { only = { "source.organizeImports" } }, apply = true })
    end
  end
  vim.keymap.set('n', 'mi', organize_import)

  local augroup = api.nvim_create_augroup("LspFormatting", { clear = false })
  if client.supports_method("textDocument/formatting") then
    vim.keymap.set('n', ']f', vim.lsp.buf.format, { buffer = bufnr })

    api.nvim_create_autocmd("BufWritePre", {
      callback = function()
        organize_import()
        vim.lsp.buf.format()
      end,
      group = augroup,
      buffer = bufnr,
    })
  end
end

local lsp_config = function()
  require('mason-lspconfig').setup({
    automatic_installation = true
  })

  local lspconfig = require("lspconfig")

  -- mason-lspconfig will auto install LS when config included in lspconfig
  local lss = {
    'gopls',
    'golangci_lint_ls',
    'eslint',
    'graphql',
    'bashls',
    'yamlls',
    'jsonls',
    'vimls',
    'tsserver',
    'denols',
  }
  for _, ls in pairs(lss) do
    lspconfig[ls].setup({ on_attach = lsp_on_attach })
  end

  lspconfig['lua_ls'].setup({
    on_attach = lsp_on_attach,
    settings = {
      Lua = {
        runtime = {
          version = 'LuaJIT'
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = { "vim" },
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = api.nvim_get_runtime_file("", true),
        },
      },
    },
  })

  lspconfig['intelephense'].setup({
    on_attach = lsp_on_attach,
    settings = {
      intelephense = {
        environment = {
          phpVersion = "8.1.0",
        }
      }
    }
  })
end

local gitsigns_config = function()
  require('gitsigns').setup({
    current_line_blame = true,
  })
end

local lazy_path = fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazy_path) then
  fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazy_path,
  })
end
opt.rtp:prepend(lazy_path)

require("lazy").setup({
  {
    'nvim-lualine/lualine.nvim',
    dependencies = 'kyazdani42/nvim-web-devicons',
    config = lualine_config,
  },
  { 'vim-denops/denops.vim' },
  {
    'lambdalisue/fern-hijack.vim',
    dependencies = {
      'lambdalisue/fern.vim',
      cmd = 'Fern',
      config = fern_config,
    },
  },
  { 'vim-jp/vimdoc-ja' },
  {
    'EdenEast/nightfox.nvim',
    lazy = false,
    config = nightfox_config,
  },
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'hrsh7th/cmp-vsnip' },
      { 'hrsh7th/vim-vsnip' },
    },
    config = nvim_cmp_config,
  },
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = {
      { 'neovim/nvim-lspconfig' },
      {
        'williamboman/mason.nvim',
        config = function() require("mason").setup() end,
      },
    },
    config = lsp_config,
    event = { 'BufReadPre', 'BufNewFile' },
  },
  { 'editorconfig/editorconfig-vim' },
  {
    'mattn/vim-goimports',
    ft = 'go',
  },
  {
    'mattn/vim-sonictemplate',
    event = { 'InsertEnter' },
    config = function()
      g.sonictemplate_vim_template_dir = fn.expand('~/.vim/sonictemplate')
    end,
  },
  {
    'jlanzarotta/bufexplorer',
    init = function() vim.g.bufExplorerDisableDefaultKeyMapping = 1 end,
    keys = {
      { ',l', ':BufExplorer<CR>', { silent = true } },
    },
  },
  {
    'lambdalisue/guise.vim',
  },
  {
    'lewis6991/gitsigns.nvim',
    event = 'BufRead',
    config = gitsigns_config,
    dependencies = {
      {
        'tpope/vim-fugitive',
        keys = {
          { 'gb', ':Git blame<CR>',  { silent = true } },
          { 'gl', ':Git log<CR>',    { silent = true } },
          { 'gs', ':Git status<CR>', { silent = true } },
        },
        config = function()
          api.nvim_create_autocmd('FileType', {
            pattern = 'git',
            callback = function()
              opt.number = false
            end,
          })
        end
      }
    },
  },
  {
    'windwp/nvim-autopairs',
    event = { 'InsertEnter' },
    config = function() require("nvim-autopairs").setup({ map_c_h = true }) end,
  },
})
