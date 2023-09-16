return {
  {
    "maxmx03/fluoromachine.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      local fm = require("fluoromachine")

      fm.setup({
        glow = true,
        theme = "fluoromachine",
        overrides = function(colors, darken)
          return {
            Visual = {
              bg = darken(colors.selection, 20),
            },
          }
        end,
      })
      vim.cmd.colorscheme("fluoromachine")
    end,
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
  {
    "brenoprata10/nvim-highlight-colors",
    cmd = { "HighlightColorsOn", "HighlightColorsOff", "HighlightColorsToggle" },
    opts = {
      render = "foreground",
      enable_tailwind = true,
    },
  },
}
