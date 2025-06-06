local on_attach = function(client, bufnr)
  client.server_capabilities.semanticTokensProvider = nil
  vim.api.nvim_set_option_value('omnifunc', 'v:lua.vim.lsp.omnifunc', {
    buf = bufnr
  })
  local bufopts = { silent = true, buffer = bufnr }
  vim.keymap.set('n', '<Leader>i', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-\\>', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, bufopts)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, bufopts)
  vim.keymap.set('n', '<C-g><C-d>', vim.diagnostic.open_float, bufopts)
	vim.opt.tagfunc = 'v:lua.vim.lsp.tagfunc'
  vim.keymap.set('n', '<Leader>cl', vim.lsp.codelens.run, bufopts)

  local organize_import = function()
    print("organize_import")
  end
  local actions = vim.tbl_get(client.server_capabilities, 'codeActionProvider', "codeActionKinds")
  if actions ~= nil and vim.tbl_contains(actions, "source.organizeImports") then
    organize_import = function()
      vim.lsp.buf.code_action({ context = { only = { "source.organizeImports" } }, apply = true })
    end
  end
  vim.keymap.set('n', 'mi', organize_import)

	if client.supports_method("textDocument/formatting") then
    vim.keymap.set('n', ']f', vim.lsp.buf.format, { buffer = bufnr })
  end
end

local config = function()
  require('mason-lspconfig').setup({
    automatic_installation = {
      exclude = {
        'gopls',
      }
    }
  })

  local lss = {
    'gopls',
    'graphql',
    'bashls',
    'vimls',
    'yamlls',
    'jsonls',
    'marksman',
    'lua_ls',
    'intelephense',
    'ts_ls',
  }

  local lspconfig = require("lspconfig")

  for _, ls in pairs(lss) do
    (function()
      local opts = {}

      if ls == 'ts_ls' then
        opts = {
          root_dir = lspconfig.util.root_pattern('tsconfig.json', 'package.json'),
          single_file_support = true,
          root_markers = {'package.json'},
        }
      elseif ls == 'lua_ls' then
        opts = {
          settings = {
            Lua = {
              runtime = {
                version = 'LuaJIT'
              },
              diagnostics = {
                globals = { 'vim' },
              },
              workspace = {
                library = vim.list_extend(vim.api.nvim_get_runtime_file('lua', true), {
                  vim.fs.joinpath(vim.fn.stdpath('config') --[[@as string]], 'lua'),
                  vim.fs.joinpath(vim.env.VIMRUNTIME, "lua"),
                  '${3rd}/luv/library',
                  '${3rd}/busted/library',
                  '${3rd}/luassert/library',
                })
              },
            },
          },
        }
      elseif ls == 'yamlls' then
        opts = {
          settings = {
            yaml = {
              schemas = {
                ['https://json.schemastore.org/github-workflow.json'] = "/.github/workflows/*",
                ['https://json.schemastore.org/github-action.json'] = '/.github/actions/*',
                ['https://json.schemastore.org/dependabot-2.0.json'] = '/.github/dependabot.y*ml',
                ['https://goreleaser.com/static/schema.json'] = '.goreleaser.*',
                ['https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json'] =
                "*compose.y*ml"
              }
            }
          }
        }
      elseif ls == 'intelephense' then
        opts = {
          settings = {
            intelephense = {
              environment = {
                phpVersion = "8.1.0",
              }
            }
          }
        }
      end

      opts['on_attach'] = on_attach

      lspconfig[ls].setup(opts)
    end)()
  end
end

local mason = {
  'williamboman/mason-lspconfig.nvim',
  dependencies = {
    { 'neovim/nvim-lspconfig' },
    {
      'williamboman/mason.nvim',
      config = function()
        require('mason').setup()
        require('mason-lspconfig').setup()
      end,
    },
  },
  config = config,
  event = { 'BufReadPre', 'BufNewFile', 'BufEnter', 'BufNew' },
}

return mason
