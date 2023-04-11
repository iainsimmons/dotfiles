return {
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = {
      style = "night",
      dim_inactive = true,
      on_highlights = function(hl, c)
        local util = require("tokyonight.util")
        hl.Visual = {
          bg = util.darken(c.blue0, 0.5)
        }
      end
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight-night",
      style = "night",
    },
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      char = "│",
      space_char_blankline = " ",
      char_highlight_list = {
        -- see .config/nvim/lua/config/options.lua
        "IndentBlanklineIndent1",
        "IndentBlanklineIndent2",
        "IndentBlanklineIndent3",
        "IndentBlanklineIndent4",
        "IndentBlanklineIndent5",
        "IndentBlanklineIndent6",
      },
    },
  },
}
