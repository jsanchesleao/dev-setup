local M = {}

M.setup = function()
  local debug = function()
    require('dap').run({
      name = 'Attach to process',
      type = 'node2',
      request = 'attach',
      processId = require'dap.utils'.pick_process,
      port = 9239,
    })
  end

  vim.keymap.set('n', '<leader>dd', debug)

end

return M
