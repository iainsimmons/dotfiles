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
              bg = darken(colors.selection, 15),
            },
          }
        end,
      })
      vim.cmd.colorscheme("fluoromachine")
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "fluoromachine",
    },
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    main = "ibl",
    config = function()
      local ibl = require("ibl")
      local hooks = require("ibl.hooks")
      local colors = {
        cyan = "#61E2FF",
        green = "#72F1B8",
        orange = "#FF8B39",
        pink = "#FC199A",
        purple = "#AF6DF9",
        red = "#FE4450",
        yellow = "#FFCC00",
        blankline = "#57367C",
        active_blankline = "#7E0C4D",
        inlay_hint = "#8C57C7",
      }

      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "IndentBlanklineIndent1", { fg = colors.red })
        vim.api.nvim_set_hl(0, "IndentBlanklineIndent2", { fg = colors.orange })
        vim.api.nvim_set_hl(0, "IndentBlanklineIndent3", { fg = colors.yellow })
        vim.api.nvim_set_hl(0, "IndentBlanklineIndent4", { fg = colors.green })
        vim.api.nvim_set_hl(0, "IndentBlanklineIndent5", { fg = colors.cyan })
        vim.api.nvim_set_hl(0, "IndentBlanklineIndent6", { fg = colors.purple })
        vim.api.nvim_set_hl(0, "IndentBlanklineActive", { fg = colors.active_blankline })
      end)
      ibl.setup({
        indent = {
          char = "│",
          tab_char = "│",
          highlight = {
            "IndentBlanklineIndent1",
            "IndentBlanklineIndent2",
            "IndentBlanklineIndent3",
            "IndentBlanklineIndent4",
            "IndentBlanklineIndent5",
            "IndentBlanklineIndent6",
          },
        },
        scope = { enabled = true, highlight = "IndentBlanklineActive" },
        exclude = {
          filetypes = {
            "help",
            "alpha",
            "dashboard",
            "neo-tree",
            "Trouble",
            "lazy",
            "mason",
            "notify",
            "toggleterm",
            "lazyterm",
          },
        },
      })
    end,
  },
  {
    "brenoprata10/nvim-highlight-colors",
    cmd = { "HighlightColorsOn", "HighlightColorsOff", "HighlightColorsToggle" },
    opts = {
      render = "background",
      enable_tailwind = true,
    },
  },
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    opts = function(_, opts)
      -- Logo generated from:
      -- https://patorjk.com/software/taag/#p=display&f=ANSI%20Shadow&t=iainvim
      local logo = [[
██╗ █████╗ ██╗███╗   ██╗██╗   ██╗██╗███╗   ███╗
██║██╔══██╗██║████╗  ██║██║   ██║██║████╗ ████║
██║███████║██║██╔██╗ ██║██║   ██║██║██╔████╔██║
██║██╔══██║██║██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║██║  ██║██║██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝
      ]]

      logo = string.rep("\n", 8) .. logo .. "\n\n"
      opts.config.header = vim.split(logo, "\n")
      opts.config.center = {
        {
          action = "Telescope find_files",
          desc = " Find file",
          icon = " ",
          key = "f",
        },
        {
          action = "ene | startinsert",
          desc = " New file",
          icon = " ",
          key = "n",
        },
        {
          action = "Telescope oldfiles",
          desc = " Recent files",
          icon = " ",
          key = "r",
        },
        {
          action = "Telescope live_grep",
          desc = " Find text",
          icon = " ",
          key = "g",
        },
        {
          action = "Mason",
          desc = " Mason",
          icon = " ",
          key = "u",
        },
        {
          action = 'lua require("persistence").load()',
          desc = " Restore Session",
          icon = " ",
          key = "s",
        },
        {
          action = "LazyExtras",
          desc = " Lazy Extras",
          icon = " ",
          key = "x",
        },
        {
          action = "Lazy",
          desc = " Lazy",
          icon = "󰒲 ",
          key = "l",
        },
        {
          action = "qa",
          desc = " Quit",
          icon = " ",
          key = "q",
        },
      }
    end,
  },
}
