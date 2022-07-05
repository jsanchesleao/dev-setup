local M = {}

M.setup = function()
  vim.cmd [[
    function! s:gitModified()
      let files = systemlist('git ls-files -m 2>/dev/null')
      return map(files, "{'line': v:val, 'path': v:val}")
    endfunction

    function! s:gitUntracked()
      let files = systemlist('git ls-files -o --exclude-standard 2>/dev/null')
      return map(files, "{'line': v:val, 'path': v:val}")
    endfunction

    let g:startify_lists = [
      \ {'type': 'bookmarks', 'header': ['Bookmarks'] },
      \ {'type': function('s:gitModified'), 'header': ['git modified'] },
      \ {'type': function('s:gitUntracked'), 'header': ['git untracked'] },
      \ {'type': 'dir',   'header': ['Recent Files ']  },
      \ ]
  ]]
end

return M
