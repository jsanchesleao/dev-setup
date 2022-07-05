local dap = require('dap')
local dapui = require('dapui')
local keymap = vim.api.nvim_set_keymap

local M = {}

M.setup = function()
  dapui.setup()

  dap.adapters.node2 = {
    type = 'executable',
    command = 'node',
    args = {os.getenv('HOME') .. '/dev/microsoft/vscode-node-debug2/out/src/nodeDebug.js'},
  }

  keymap('n', '<leader>db', ':lua require("dap").toggle_breakpoint()<CR>', {})
  keymap('n', '<leader>dB', ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))", {})
  keymap('n', '<leader>dc', ':lua require("dap").continue()<CR>', {})
  keymap('n', '<leader>do', ':lua require("dap").step_over()<CR>', {})
  keymap('n', '<leader>dO', ':lua require("dap").step_out()<CR>', {})
  keymap('n', '<leader>di', ':lua require("dap").step_into()<CR>', {})
  keymap('n', '<leader>dr', ':lua require("dap").repl_open()<CR>', {})
  keymap('n', '<leader>dt', ':lua require("dapui").toggle()<CR>', {})
  keymap('n', '<leader>dD', ':lua require("dap").run_last()<CR>', {})

end

M.launch_debug_node = function()
  require('dap').run({
    type = 'node2',
    request = 'launch',
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    program = '${file}',
    protocol = 'inspector'
  })
end

return M
