local keymap = vim.api.nvim_set_keymap
local noremap = { noremap = true }

local M = {}

local telescope_resp = function(command)
  local theme = ""
  if vim.api.nvim_win_get_width(0) < 150
  then
    theme = " theme=dropdown"
  end
  return ":Telescope " .. command .. theme .. "<CR>"
end


M.setup = function()
  -- General Purpose
  keymap('i', 'kj', '<Esc>', {})
  keymap('n', '<C-e>', '4<C-e>', noremap)
  keymap('n', '<C-y>', '4<C-y>', noremap)
  keymap('n', ';', ':', noremap)
  keymap('n', 'tt', ':NERDTreeToggle<CR>', { silent = true, noremap = true })
  keymap('n', '<Tab>', ':bn<CR>', noremap)
  keymap('n', '<S-Tab>', ':bp<CR>', noremap)
  keymap('n', '<Leader><Tab>', ':Bw<CR>', noremap)
  keymap('n', '<Leader><S-Tab>', ':Bw!<CR>', noremap)
  keymap('n', 'K', ':call CocActionAsync(\'doHover\')<CR>', noremap)
  keymap('n', '<Leader>ss', ':source ~/.config/nvim/init.lua<CR>', noremap)
  keymap('n', '<Leader>se', ':tabnew ~/.config/nvim/init.lua<CR>', noremap)
  keymap('n', '<Leader>sm', ':tabnew ~/.config/nvim/lua/custom_commands.lua<CR>', noremap)
  keymap('v', '<leader>f', '<Plug>(coc-format-selected)', {})
  keymap('t', '<Esc>', '<C-\\><C-n>', noremap)
  keymap('t', 'kj', '<C-\\><C-n>', noremap)

  -- Telescope
  keymap('n', '<C-p>', telescope_resp('find_files'), noremap)
  keymap('n', '<C-F>', telescope_resp('live_grep'), noremap)
  keymap('n', '<leader>tc', telescope_resp('coc'), noremap)
  keymap('n', '<leader>tr', telescope_resp('coc references_used'), noremap)
  keymap('n', '<leader>ts', telescope_resp('coc document_symbols'), noremap)
  keymap('n', '<leader>tt', telescope_resp('coc type_definitions'), noremap)
  keymap('n', '<leader>td', telescope_resp('coc definitions'), noremap)
  keymap('n', '<leader>ti', telescope_resp('coc implementations'), noremap)
  keymap('n', '<leader>ta', telescope_resp('coc code_actions'), noremap)
  keymap('n', '<C-x>', telescope_resp('command_palette'), noremap)

  -- CoC
  keymap('n', 'gd', '<Plug>(coc-definition)', { silent = true })
  keymap('n', 'gD', '<Plug>(coc-implementation)', { silent = true })
  keymap('n', 'gr', '<Plug>(coc-references)', { silent = true })
  keymap('n', '<leader>ci', ':CocCommand editor.action.organizeImport<CR>', { silent = true })
  keymap('n', '<leader>cl', ':CocCommand eslint.executeAutofix<CR>', { silent = true })
  keymap('n', '<leader>cf', ':CocCommand editor.action.formatDocument<CR>', { silent = true })
  keymap('n', '<leader>ch', ':call CocActionAsync(\'doHover\')<CR>', { silent = true })
  keymap('n', '<leader>cr', ':CocCommand document.renameCurrentWord<CR>', { silent = true })
  keymap('n', '<leader>cc', ':CocCommand<CR>', { silent = true })
  keymap('i', '<C-l>', '<Plug>(coc-snippets-expand)', {})
  keymap('v', '<C-l>', '<Plug>(coc-snippets-select)', {})
  keymap('i', '<C-l>', '<Plug>(coc-snippets-expand-jump)', {})
  keymap('x', '<leader>x', '<Plug>(coc-convert-snippet)', {})

  -- Harpoon
  keymap('n', '<leader>ha', ':lua require("harpoon.mark").add_file()<CR>', noremap)
  keymap('n', '<leader>hh', ':lua require("harpoon.ui").toggle_quick_menu()<CR>', noremap)
  keymap('n', '<leader>hn', ':lua require("harpoon.ui").nav_next()<CR>', noremap)
  keymap('n', '<leader>hp', ':lua require("harpoon.ui").nav_prev()<CR>', noremap)

  -- Split
  keymap('n', 'ss', ':split<CR><C-w>w', {})
  keymap('n', 'sv', ':vsplit<CR><C-w>w', {})
  keymap('n', '<C-w><left>', '<C-w><', {})
  keymap('n', '<C-w><right>', '<C-w>>', {})
  keymap('n', '<C-w><up>', '<C-w>+', {})
  keymap('n', '<C-w><down>', '<C-w>-', {})

  vim.keymap.set('n', '<C-Space>', function()
    local command = vim.fn.input('$ '):gsub('"', '\\"')
    vim.cmd(':silent !~/bin/tmux-popup-run "' .. command .. '"')
  end)

  keymap('n', '<leader>ne', ':silent !~/bin/dev-notes edit<CR>', {silent = true})
  keymap('n', '<leader>nr', ':silent !~/bin/dev-notes read<CR>', {silent = true})
end

return M

