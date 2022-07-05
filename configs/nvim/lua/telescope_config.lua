local M = {}

M.setup = function()

  local telescope = require('telescope')
  telescope.load_extension('coc')
  telescope.load_extension('command_palette')
  telescope.setup {
    defaults = { file_ignore_patterns = { "node_modules" } },
  }
  telescope.load_extension('dap')
  telescope.load_extension('harpoon')

end

return M
