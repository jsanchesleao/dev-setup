local Plug = vim.fn['plug#']
local M = {}

M.setup = function()
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

  Plug 'tpope/vim-surround'
--  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'kyazdani42/nvim-tree.lua'

  Plug 'ianks/vim-tsx'
  Plug 'sainnhe/everforest'
  Plug 'bagrat/vim-buffet'
  Plug 'tpope/vim-fugitive'

  Plug 'nvim-lua/plenary.nvim'
  Plug 'mfussenegger/nvim-dap'
  Plug 'rcarriga/nvim-dap-ui'
  Plug 'Pocco81/dap-buddy.nvim'
  Plug('nvim-treesitter/nvim-treesitter')
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'fannheyward/telescope-coc.nvim'
  Plug('nvim-telescope/telescope-fzf-native.nvim', {
    ['do'] = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
  })

  Plug 'ThePrimeagen/harpoon'
  Plug "LinArcX/telescope-command-palette.nvim"

  vim.call('plug#end')
end

return M
