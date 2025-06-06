local lspconfig = {
  'neovim/nvim-lspconfig',
  config = function()
    vim.diagnostic.config({
      virtual_text = true
    })
    local augroup = vim.api.nvim_create_augroup('lsp/init.lua', {})
    vim.api.nvim_create_autocmd('LspAttach', {
      group = augroup,
      callback = function(args)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    		vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
    		vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
      end,
    })

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.resolveSupport = {
      properties = {
        "documentation",
        "detail",
        "additionalTextEdits",
      },
    }
    vim.lsp.config("*", { capabilities = capabilities })
    vim.lsp.enable('lua_ls')
    vim.lsp.enable('ts_ls')
    vim.lsp.enable('gopls')
    vim.lsp.enable('bashls')
    vim.lsp.enable('jsonls')
    vim.lsp.enable('yamlls')
    vim.lsp.enable('marksman')
    vim.lsp.enable('intelephense')
    vim.lsp.enable('graphql')
  end,
  event = { "BufReadPre", "BufNewFile" },
}
return lspconfig
