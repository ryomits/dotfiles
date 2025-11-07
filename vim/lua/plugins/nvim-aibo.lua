return {
  'lambdalisue/nvim-aibo',
  config = function()
    local claude_on_attach = function(bufnr)
      local win_id = vim.fn.win_findbuf(bufnr)[1]
      local opts = { buffer = bufnr, nowait = true, silent = true }
      vim.api.nvim_set_option_value('winfixwidth', true, { win = win_id })
      vim.keymap.set('n', 'qq', '<Cmd>bw!<CR>', opts)
    end

    require('aibo').setup({
      tools = {
        claude = {
          on_attach = claude_on_attach
        }
      }
    })

    vim.api.nvim_create_user_command('Claude', function(opts)
      local width = math.floor(vim.o.columns * 1 / 2)
      vim.cmd(string.format('Aibo -toggle -opener="botright %dvsplit" claude %s', width, opts.args))
    end, { nargs = '*' })

    vim.keymap.set('n', '<leader>ac', '<Cmd>Claude<CR>')
    vim.keymap.set('n', '<leader>ar', '<Cmd>Claude -r<CR>')
  end
}
