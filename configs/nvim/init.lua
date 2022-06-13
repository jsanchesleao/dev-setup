local set = vim.opt
local cmd = vim.cmd
local keymap = vim.api.nvim_set_keymap
local noremap = { noremap = true }
local Plug = vim.fn['plug#']
local isDir = vim.fn['isdirectory']
local cocExtensions = {}

-- Global/Buffer Variables
vim.g.mapleader = ','
set.number = true
set.relativenumber = true
set.tabstop = 2
set.shiftwidth = 2
set.expandtab = true

-- PLUG
vim.call('plug#begin')

Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug('styled-components/vim-styled-components', {branch = 'main'})
Plug 'jparise/vim-graphql'

Plug 'neovim/nvim-lspconfig'
Plug('neoclide/coc.nvim', {branch = 'release'})
Plug 'neoclide/coc-eslint'
Plug 'neoclide/coc-prettier'
Plug 'folke/lua-dev.nvim'

Plug 'preservim/nerdtree'
Plug 'tpope/vim-surround'

Plug 'ianks/vim-tsx'
Plug 'sainnhe/everforest'
Plug 'bagrat/vim-buffet'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-fugitive'

Plug 'nvim-lua/plenary.nvim'
Plug('nvim-treesitter/nvim-treesitter')
Plug 'nvim-telescope/telescope.nvim'

vim.call('plug#end')

-- COC Configuration
vim.g['coc_global_extensions'] = cocExtensions
cocExtensions[1] = 'coc-tsserver'
if (isDir('./node_modules')) then
  if (isDir('./node_modules/prettier')) then
    table.insert(cocExtensions, 'coc-prettier')
  end
  if (isDir('./node_modules/eslint')) then
    table.insert(cocExtensions, 'coc-eslint')
  end
end

-- Telescope Config
require('telescope').setup{ defaults = { file_ignore_patterns = {"node_modules"} } }

-- Keybindings
keymap('i', 'kj',  '<Esc>', {})

keymap('n', ';',  ':', noremap)
keymap('n', '<C-p>',  ':Telescope find_files<CR>', noremap)
keymap('n', '<C-F>',  ':Telescope live_grep<CR>', noremap)
keymap('n', '<leader><C-p>',  ':Telescope find_files theme=dropdown<CR>', noremap)
keymap('n', '<leader><C-F>',  ':Telescope live_grep theme=dropdown<CR>', noremap)
keymap('n', 'gd', '<Plug>(coc-definition)', { silent = true })
keymap('n', 'gD', '<Plug>(coc-implementation)', { silent = true })
keymap('n', 'gr', '<Plug>(coc-references)', { silent = true })
keymap('n', 'tt', ':NERDTreeToggle<CR>', { silent = true, noremap = true })
keymap('n', '<Tab>', ':bn<CR>', noremap)
keymap('n', '<S-Tab>', ':bp<CR>', noremap)
keymap('n', '<Leader><Tab>', ':Bw<CR>', noremap)
keymap('n', '<Leader><S-Tab>', ':Bw!<CR>', noremap)
keymap('n', '<C-t>', ':tabnew<CR>', noremap)
keymap('n', '<leader>f',  '<Plug>(coc-format-selected)', {})
keymap('n', '<leader>l', ':CocCommand eslint.executeAutofix<CR>', noremap)
keymap('n', '<C-Space>', ':call CocActionAsync(\'doHover\')<CR>', noremap)
keymap('n', '<Leader>ss', ':source ~/.config/nvim/init.lua<CR>', noremap) 
keymap('n', '<Leader>se', ':tabnew ~/.config/nvim/init.lua<CR>', noremap)
keymap('n', '<leader>t', ':tabnew<CR>:terminal<CR>a', noremap)

keymap('v', '<leader>f',  '<Plug>(coc-format-selected)', {})

keymap('t', '<Esc>', '<C-\\><C-n>', noremap)

-- VIMScript Config
cmd [[
  autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
  autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear
  colorscheme everforest
  syntax on
]]

