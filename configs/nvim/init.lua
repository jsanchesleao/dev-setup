-- ~/.config/nvim
local set = vim.opt
local cmd = vim.cmd

cmd [[
function! g:BuffetSetCustomColors()
  hi! BuffetCurrentBuffer cterm=NONE ctermbg=250 ctermfg=238 guibg=#BGBGBG guifg=#FFFFFF
  hi! BufferActiveBuffer cterm=NONE ctermbg=231 ctermfg=238 guibg=#FFFFFF guifg=#444444
  hi! BuffetBuffer cterm=NONE ctermbg=238 ctermfg=231 guibg=#444444 guifg=#FFFFFF
  hi! BuffetTab cterm=NONE ctermbg=232 ctermfg=238 guibg=#080808 guifg=#444444
endfunction
]]

-- Global/Buffer Variables
vim.g.mapleader = ','
vim.g.coc_snippet_next = '<C-j>'
vim.g.coc_snippet_prev = '<C-k>'
set.number = true
set.relativenumber = true
set.tabstop = 2
set.shiftwidth = 2
set.expandtab = true
set.laststatus = 3

require('plugins').setup() -- ./lua/plugins.lua
require('startify_config').setup() -- ./lua/startify_config.lua
require('debug.base').setup() -- ./lua/debug/base.lua
require('keymappings').setup() -- ./lua/keymappings.lua
require('coc_config').setup() -- ./lua/coc_config.lua
require('telescope_config').setup() -- ./lua/telescope_config.lua
require('nvim_tree_config').setup() -- ./lua/nvim_tree_config.lua
require('lualine_config').setup() -- ./lua/lualine_config.lua
require('custom_commands').setup() -- ./lua/custom_commands.lua

-- nvim project
require('project_nvim').setup {
  manual_mode = true,
  detection_method = { "lsp", "pattern" },
  patterns = { "go.mod", ".git" },
  ignore_lsp = {},
  exclude_dirs = { "node_modules", "^src", "^lib" },
  show_hidden = false,
  silent_chdir = true,
  datapath = vim.fn.stdpath("data"),
}
require('telescope').load_extension('projects')

-- Load Local .nvimrc.lua
local hasNvimrc = io.open(".nvimrc.lua")
if hasNvimrc
then
  print "sourcing .nvimrc.lua"
  vim.cmd(":source .nvimrc.lua")
else
  print "no .nvimrc was found"
end

-- VIMScript Config
cmd [[
  autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
  autocmd BufEnter *.{njk} :set syntax=html
  autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear
  autocmd BufEnter *.json :set foldmethod=syntax
  colorscheme everforest
  syntax on

  set path+=**
  set wildmenu
  set nowrap

  set guifont=MesloLGS\ NF
]]
