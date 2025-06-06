local gitsigns_config = function()
  require('gitsigns').setup({
    current_line_blame = true,
    on_attach = function()
      local gs = package.loaded.gitsigns
      vim.keymap.set('n', '<Leader>hS', gs.stage_buffer)
      vim.keymap.set('n', '<Leader>hu', gs.undo_stage_hunk)
      vim.keymap.set('n', '<Leader>hR', gs.reset_buffer)
      vim.keymap.set('n', '<Leader>hp', gs.preview_hunk)
      vim.keymap.set('n', '<Leader>hb', function() gs.blame_line { full = true } end)
      vim.keymap.set('n', '<Leader>tb', gs.toggle_current_line_blame)
      vim.keymap.set('n', '<Leader>hd', gs.diffthis)
      vim.keymap.set('n', '<Leader>hD', function() gs.diffthis('~') end)
      vim.keymap.set('n', '<Leader>td', gs.toggle_deleted)
    end
  })
end

local gitsigns = {
  'lewis6991/gitsigns.nvim',
  event = { 'BufRead', 'BufNewFile' },
  config = gitsigns_config,
}

return gitsigns
