local orig_hover = vim.lsp.handlers["textDocument/hover"]
vim.lsp.handlers["textDocument/hover"] = function(err, result, ctx, config)
  config = vim.tbl_deep_extend("force", config or {}, { border = "single" })
  return orig_hover(err, result, ctx, config)
end
vim.diagnostic.config({ virtual_text = false })
