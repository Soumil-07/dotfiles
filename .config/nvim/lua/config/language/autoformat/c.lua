M = {
  function()
  return {
    exe = 'clang-format',
    args = {'-assume-filename=', vim.fn.shellescape(vim.api.nvim_buf_get_name(0))},
    stdin = true
  }
  end
}

return M
