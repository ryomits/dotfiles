return {
  root_dir = function(bufnr, callback)
    local found_dirs = vim.fs.find({
      'package.json',
      'tsconfig.json',
      'jsconfig.json',
    }, {
      upward = true,
      path = vim.fs.dirname(vim.fs.normalize(vim.api.nvim_buf_get_name(bufnr))),
    })
    if #found_dirs > 0 then
      return callback(vim.fs.dirname(found_dirs[1]))
    end
  end,
}

