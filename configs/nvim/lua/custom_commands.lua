local palette = require('command_palette')

local M = {}

M.setup = function()
  local config = {}

  config.File = { "File",
    { "entire selection", ':call feedkeys("GVgg")' },
    { "save current file", ':w' },
    { "save all files", ':wa' },
    { "quit", ':qa' },
    { "file browser", ":lua require'telescope'.extensions.file_browser.file_browser()", 1 },
    { "search word", ":lua require('telescope.builtin').live_grep()", 1 },
    { "git files", ":lua require('telescope.builtin').git_files()", 1 },
    { "files", ":lua require('telescope.builtin').find_files()", 1 },
    { "Copy (selection)", ':normal "+y'},
    { "Copy Whole File", ':normal mCggVG"+y`C'},
  }

  config.Help = { "Help",
    { "tips", ":help tips" },
    { "cheatsheet", ":help index" },
    { "tutorial", ":help tutor" },
    { "summary", ":help summary" },
    { "quick reference", ":help quickref" },
    { "search help", ":lua require('telescope.builtin').help_tags()", 1 },
  }

  config.Vim = { "Vim",
    { "reload vimrc", ":source $MYVIMRC" },
    { "close hidden buffers", ":up | %bd | e#" },
    { 'check health', ":checkhealth" },
    { "jumps", ":lua require('telescope.builtin').jumplist()" },
    { "commands", ":lua require('telescope.builtin').commands()" },
    { "command history", ":lua require('telescope.builtin').command_history()" },
    { "registers", ":lua require('telescope.builtin').registers()" },
    { "colorshceme", ":lua require('telescope.builtin').colorscheme()", 1 },
    { "vim options", ":lua require('telescope.builtin').vim_options()" },
    { "keymaps", ":lua require('telescope.builtin').keymaps()" },
    { "buffers", ":Telescope buffers" },
    { "search history (C-h)", ":lua require('telescope.builtin').search_history()" },
    { "paste mode", ':set paste!' },
    { 'cursor line', ':set cursorline!' },
    { 'cursor column', ':set cursorcolumn!' },
    { "spell checker", ':set spell!' },
    { "relative number", ':set relativenumber!' },
    { "search highlighting", ':set hlsearch!' },
  }

  config.Code = { "Code",
    { "Organize Imports", ":CocCommand editor.action.organizeImport" },
    { "Autofix Lint", ":CocCommand eslint.executeAutofix"},
    { "Format Document", ":CocCommand editor.action.formatDocument"},
    { "List Commands", ":CocCommand"},
  }

  config.Debug = { "Debug",
   { "Commands", ":lua require'telescope'.extensions.dap.commands()"},
   { "Configurations", ":lua require'telescope'.extensions.dap.configurations()"},
   { "Breakpoints", ":lua require'telescope'.extensions.dap.list_breakpoints()"},
   { "Variables", ":lua require'telescope'.extensions.dap.variables()"},
   { "Frames", ":lua require'telescope'.extensions.dap.frames()"},
  }

  for _, value in pairs(config) do
    table.insert(palette.CpMenu, value)
  end

end

return M
