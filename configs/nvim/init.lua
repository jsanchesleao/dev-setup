local set = vim.opt
local cmd = vim.cmd
local keymap = vim.api.nvim_set_keymap
local noremap = { noremap = true }
local Plug = vim.fn['plug#']
local isDir = vim.fn['isdirectory']
local cocExtensions = {}

-- Global/Buffer Variables
vim.g.mapleader = ','
vim.g.coc_snippet_next = '<C-j>'
vim.g.coc_snippet_prev = '<C-k>'
set.number = true
set.relativenumber = true
set.tabstop = 2
set.shiftwidth = 2
set.expandtab = true

-- PLUG
vim.call('plug#begin')

Plug 'christoomey/vim-tmux-navigator'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug('styled-components/vim-styled-components', { branch = 'main' })
Plug 'jparise/vim-graphql'

Plug 'neovim/nvim-lspconfig'
Plug('neoclide/coc.nvim', { branch = 'release' })
Plug 'neoclide/coc-eslint'
Plug 'neoclide/coc-prettier'
Plug 'folke/lua-dev.nvim'

Plug 'preservim/nerdtree'
Plug 'tpope/vim-surround'

Plug 'ianks/vim-tsx'
Plug 'sainnhe/everforest'
Plug 'bagrat/vim-buffet'
Plug 'tpope/vim-fugitive'

Plug 'nvim-lua/plenary.nvim'
Plug('nvim-treesitter/nvim-treesitter')
Plug 'nvim-telescope/telescope.nvim'
Plug 'fannheyward/telescope-coc.nvim'
Plug('nvim-telescope/telescope-fzf-native.nvim', {
  ['do'] = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
})

Plug 'ThePrimeagen/harpoon'
Plug "LinArcX/telescope-command-palette.nvim"

vim.call('plug#end')

-- COC Configuration
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

-- Telescope Config
local telescope = require('telescope')
telescope.load_extension('coc')
telescope.load_extension('command_palette')
telescope.setup {
  defaults = { file_ignore_patterns = { "node_modules" } },
}
table.insert(require("command_palette").CpMenu, require("custom_commands").File)
table.insert(require("command_palette").CpMenu, require("custom_commands").Help)
table.insert(require("command_palette").CpMenu, require("custom_commands").Vim)
table.insert(require("command_palette").CpMenu, require("custom_commands").Code)

local telescope_resp = function(command)
  local theme = ""
  if vim.api.nvim_win_get_width(0) < 150
  then
    theme = " theme=dropdown"
  end
  return ":Telescope " .. command .. theme .. "<CR>"
end

-- Keybindings
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

-- Telescope Keybindings
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

-- CoC Keybindings
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

-- Harpoon Keybindings
keymap('n', '<leader>ha', ':lua require("harpoon.mark").add_file()<CR>', noremap)
keymap('n', '<leader>hh', ':lua require("harpoon.ui").toggle_quick_menu()<CR>', noremap)
keymap('n', '<leader>hn', ':lua require("harpoon.ui").nav_next()<CR>', noremap)
keymap('n', '<leader>hp', ':lua require("harpoon.ui").nav_prev()<CR>', noremap)

-- Split Keybindings
keymap('n', 'ss', ':split<CR><C-w>w', {})
keymap('n', 'sv', ':vsplit<CR><C-w>w', {})
keymap('n', '<C-w><left>', '<C-w><', {})
keymap('n', '<C-w><right>', '<C-w>>', {})
keymap('n', '<C-w><up>', '<C-w>+', {})
keymap('n', '<C-w><down>', '<C-w>-', {})


local hasNvimrc = io.open(".nvimrc")
if hasNvimrc
then
  print "sourcing .nvimrc"
  dofile(vim.fn.getcwd() .. '/.nvimrc')
else
  print "no .nvimrc was found"
end


-- VIMScript Config
cmd [[
  autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
  autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear
  colorscheme everforest
  syntax on
]]
