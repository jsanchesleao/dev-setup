-- ~/.config/nvim
local set = vim.opt
local cmd = vim.cmd

-- Global/Buffer Variables
vim.g.mapleader = ','
vim.g.coc_snippet_next = '<C-j>'
vim.g.coc_snippet_prev = '<C-k>'
set.number = true
set.relativenumber = true
set.tabstop = 2
set.shiftwidth = 2
set.expandtab = true

require('plugins').setup() -- ./lua/plugins.lua
require('debug.base').setup() -- ./lua/debug/base.lua
require('keymappings').setup() -- ./lua/keymappings.lua
require('coc_config').setup() -- ./lua/coc_config.lua
require('telescope_config').setup() -- ./lua/telescope_config.lua
require('custom_commands').setup() -- ./lua/custom_commands.lua

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
  autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear
  colorscheme everforest
  syntax on
]]
