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
opt.list = true
opt.breakindent = true
opt.scrolloff = 50

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
    pattern = { 'javascript', 'typescriptreact', 'typescript', 'vim', 'lua', 'sh', 'zsh', 'markdown',
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

local auto_mkdir = function(dir)
  if fn.isdirectory(dir) == 0 then
    fn.mkdir(dir, 'p')
  end
end

api.nvim_create_autocmd('BufWritePre', {
  pattern = '*',
  callback = function()
    auto_mkdir(fn.expand('<afile>:p:h'))
  end,
  group = api.nvim_create_augroup('autoMkdir', { clear = true })
})

api.nvim_create_autocmd('QuickFixCmdPost', {
  pattern = '*grep*',
  command = 'cwindow',
  group = api.nvim_create_augroup('grepWindow', { clear = true }),
})

api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  callback = function()
    cmd('startinsert')
    cmd('setlocal scrolloff=0 listchars= nonumber norelativenumber')
  end,
  group = api.nvim_create_augroup("neovimTerminal", { clear = true }),
})

vim.keymap.set('n', '<Leader>t', ':new | terminal<CR>', { silent = true })
local lualine_config = function()
  require('lualine').setup({
    sections = {
      lualine_c = { 'filename', "lsp_progress" },
    }
  })
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
  opt.termguicolors = true
  cmd([[
    colorscheme Nightfox
    hi VertSplit guifg=#535353
    hi Visual ctermfg=159 ctermbg=23 guifg=#b3c3cc guibg=#384851
  ]])
end

vim.keymap.set('c', '<C-b>', '<Left>', {})
vim.keymap.set('c', '<C-f>', '<Right>', {})
vim.keymap.set('c', '<C-a>', '<Home>', {})
vim.keymap.set('c', '<Up>', '<C-p>')
vim.keymap.set('c', '<Down>', '<C-n>')
vim.keymap.set('c', '<C-n>', function()
  return fn.pumvisible() == 1 and '<C-n>' or '<Down>'
end, { expr = true })
vim.keymap.set('c', '<C-p>', function()
  return fn.pumvisible() == 1 and '<C-p>' or '<Up>'
end, { expr = true })

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
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline({
    }),
    sources = {
      { name = 'buffer' }
    }
  })
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline({
      ['<Down>'] = { c = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }) },
      ['<Up>'] = { c = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }) },
    }),
    sources = cmp.config.sources(
      {
        { name = 'path' }
      },
      {
        { name = 'cmdline' }
      })
  })
end

local lsp_on_attach = function(client, bufnr)
  client.server_capabilities.semanticTokensProvider = nil
  api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  local bufopts = { silent = true, buffer = bufnr }
  vim.keymap.set('n', '<Leader>i', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-\\>', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, bufopts)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, bufopts)
  vim.keymap.set('n', '<C-g><C-d>', vim.diagnostic.open_float, bufopts)
  if client.name == 'denols' then
    vim.keymap.set('<C-]>', vim.lsp.buf.definition, bufopts)
  else
    opt.tagfunc = 'v:lua.vim.lsp.tagfunc'
  end
  vim.keymap.set('n', '<Leader>cl', vim.lsp.codelens.run, bufopts)

  local organize_import = function()
  end
  local actions = vim.tbl_get(client.server_capabilities, 'codeActionProvider', "codeActionKinds")
  if actions ~= nil and vim.tbl_contains(actions, "source.organizeImports") then
    organize_import = function()
      vim.lsp.buf.code_action({ context = { only = { "source.organizeImports" } }, apply = true })
    end
  end
  vim.keymap.set('n', 'mi', organize_import)
end

local lsp_config = function()
  require('mason-lspconfig').setup({
    automatic_installation = true
  })

  local lspconfig = require("lspconfig")

  local lss = {
    'gopls',
    'golangci_lint_ls',
    'eslint',
    'graphql',
    'bashls',
    'vimls',
    'lua_ls',
    'intelephense',
    'tsserver',
    'denols',
  }

  local node_root_dir = lspconfig.util.root_pattern('package.json')
  local is_node_repo = node_root_dir(fn.getcwd()) ~= nil

  for _, ls in pairs(lss) do
    (function()
      local opts = {}

      if ls == 'denols' then
        if is_node_repo then
          return
        end
        opts = {
          cmd = { 'deno', 'lsp' },
          root_dir = lspconfig.util.root_pattern('deps.ts', 'deno.json', 'import_map.json', '.git'),
          init_options = {
            lint = true,
            unstable = true,
            suggest = {
              imports = {
                hosts = {
                  ["https://deno.land"] = true,
                  ["https://cdn.nest.land"] = true,
                  ["https://crux.land"] = true,
                },
              },
            },
          },
        }
      elseif ls == 'tsserver' then
        if not is_node_repo then
          return
        end

        opts = {
          root_dir = lspconfig.util.root_pattern('package.json', 'node_modules'),
        }
      elseif ls == 'lua_ls' then
        opts = {
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
        }
      elseif ls == 'intelephense' then
        opt = {
          settings = {
            intelephense = {
              environment = {
                phpVersion = "8.1.0",
              }
            }
          }
        }
      end

      opts['on_attach'] = lsp_on_attach

      lspconfig[ls].setup(opts)
    end)()
  end
end

local gitsigns_config = function()
  require('gitsigns').setup({
    current_line_blame = true,
    on_attach = function()
      local gs = package.loaded.gitsigns
      vim.keymap.set('n', '<leader>hS', gs.stage_buffer)
      vim.keymap.set('n', '<leader>hu', gs.undo_stage_hunk)
      vim.keymap.set('n', '<leader>hR', gs.reset_buffer)
      vim.keymap.set('n', '<leader>hp', gs.preview_hunk)
      vim.keymap.set('n', '<leader>hb', function() gs.blame_line { full = true } end)
      vim.keymap.set('n', '<leader>tb', gs.toggle_current_line_blame)
      vim.keymap.set('n', '<leader>hd', gs.diffthis)
      vim.keymap.set('n', '<leader>hD', function() gs.diffthis('~') end)
      vim.keymap.set('n', '<leader>td', gs.toggle_deleted)
    end
  })
end

local telescope_config = function()
  require("telescope").load_extension("ui-select")
  require('telescope').setup {
    extensions = {
      ['ui-select'] = {
        require('telescope.themes').get_dropdown {}
      }
    }
  }
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
    dependencies = {
      { 'kyazdani42/nvim-web-devicons' },
      { 'arkav/lualine-lsp-progress' }
    },
    config = lualine_config,
  },
  { 'vim-denops/denops.vim' },
  {
    'lambdalisue/fern-hijack.vim',
    dependencies = {
      'lambdalisue/fern.vim',
      cmd = 'Fern',
      config = fern_config,
      keys = {
        { '<Leader>f', ':Fern . -drawer<CR>', { silent = true } }
      }
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
      { 'hrsh7th/cmp-cmdline' },
      { 'hrsh7th/vim-vsnip-integ' }
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
    build = ":MasonUpdate",
  },
  { 'editorconfig/editorconfig-vim' },
  {
    'mattn/vim-goimports',
    ft = 'go',
  },
  {
    'mattn/vim-sonictemplate',
    config = function()
      g.sonictemplate_vim_template_dir = fn.expand('~/.vim/template')
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
  },
  {
    'tpope/vim-fugitive',
    keys = {
      { 'gb', ':Git blame<CR>', { silent = true } },
      { 'gl', ':Git log<CR>',   { silent = true } },
    },
    config = function()
     api.nvim_create_autocmd('FileType', {
        pattern = 'git',
        callback = function()
          opt.number = false
        end,
      })
    end
  },
  {
    'windwp/nvim-autopairs',
    event = { 'InsertEnter' },
    config = function() require("nvim-autopairs").setup({ map_c_h = true }) end,
  },
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope-ui-select.nvim' },
    },
    init = function()
      local function builtin(name)
        return function(option)
          return function()
            return require('telescope.builtin')[name](option or {})
          end
        end
      end

      vim.keymap.set('n', '<C-p>', builtin 'find_files' {})
      vim.keymap.set('n', 'mr', builtin 'live_grep' {})
      vim.keymap.set('n', 'md', builtin 'diagnostics' {})
      vim.keymap.set('n', 'mf', builtin 'current_buffer_fuzzy_find' {})
      vim.keymap.set('n', 'mh', builtin 'help_tags' { lang = 'ja' })
      vim.keymap.set('n', 'mo', builtin 'oldfiles' {})
      vim.keymap.set('n', 'gs', builtin 'git_status' {})
    end,
    config = telescope_config,
  },
  { 'thinca/vim-prettyprint' },
  {
    "github/copilot.vim",
    lazy = false,
    config = function()
      vim.g.copilot_filetypes = {
        gitcommit = true,
        markfown = true,
        text = true,
      }
    end,
  },
})
