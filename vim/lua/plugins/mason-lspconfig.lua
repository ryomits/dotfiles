local config = function()
  require('mason-lspconfig').setup({
    ensure_installed = {
      'jsonls',
      'rust_analyzer',
      'ts_ls',
      'yamlls',
      'lua_ls',
      'bashls',
      'marksman',
      'intelephense',
      'denols',
      'eslint',
    },
  })
end

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp', { clear = true }),
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
    if client:supports_method("textDocument/formatting") then
      vim.keymap.set('n', ']f', vim.lsp.buf.format, { buffer = bufnr })
    end
  end,
})
vim.diagnostic.config({ virtual_text = true })

local mason = {
  'williamboman/mason-lspconfig.nvim',
  dependencies = {
    {
      'williamboman/mason.nvim',
      config = function()
        require('mason').setup()
      end,
    },
    {
      'neovim/nvim-lspconfig',
      config = function()
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities.textDocument.completion.completionItem.resolveSupport = {
          properties = {
            "documentation",
            "detail",
            "additionalTextEdits",
          },
        }
        vim.lsp.config("*", { capabilities = capabilities })
      end,
      event = { "BufReadPre", "BufNewFile" },
    }
  },
  config = config,
  event = { 'BufReadPre', 'BufNewFile', 'BufEnter', 'BufNew' },
}

return mason
