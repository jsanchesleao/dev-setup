local M = {}

M.setup = function()

require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
        { key = "<space>", action = "edit" },
      },
    },
  },
  renderer = {
    highlight_opened_files = 'all',
    group_empty = true,
    icons = {
      webdev_colors = true,
      show = {
        file = true,
        folder = true,
        folder_arrow = false,
      },
      glyphs = {
        default = "⊟",
        symlink = "s",
        folder = {
          default = "+",
          open = "-",
          arrow_open = "v",
          arrow_closed = ">",
        },
      },
    },
  },
  filters = {
    dotfiles = true,
  },
})

end

return M
