return {
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
