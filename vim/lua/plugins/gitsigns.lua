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

local gitsigns = {
      'lewis6991/gitsigns.nvim',
      event = { 'BufRead', 'BufNewFile' },
      config = gitsigns_config,
}

return gitsigns
