local M = {}

local cocExtensions = {}
local isDir = vim.fn['isdirectory']

M.setup = function()
  vim.g['coc_global_extensions'] = cocExtensions
  cocExtensions[1] = 'coc-tsserver'
  cocExtensions[2] = 'coc-snippets'
  if (isDir('./node_modules')) then
    if (isDir('./node_modules/prettier')) then
      table.insert(cocExtensions, 'coc-prettier')
    end
    if (isDir('./node_modules/eslint')) then
      table.insert(cocExtensions, 'coc-eslint')
    end
  end

end

return M
