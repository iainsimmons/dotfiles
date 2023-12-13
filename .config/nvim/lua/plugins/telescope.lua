return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "kkharji/sqlite.lua",
      { "prochri/telescope-all-recent.nvim", opts = {} },
      "natecraddock/telescope-zf-native.nvim",
      "piersolenski/telescope-import.nvim",
      "fdschmidt93/telescope-egrepify.nvim",
      {
        "danielfalk/smart-open.nvim",
        branch = "0.2.x",
        config = function() end,
        dependencies = {
          "kkharji/sqlite.lua",
          { "nvim-telescope/telescope-fzy-native.nvim" },
        },
      },
    },
    keys = {
      { "<leader>/", false },
      {
        "<leader><space>",
        function()
          require("telescope").extensions.smart_open.smart_open({
            cwd_only = true,
            filename_first = true,
          })
        end,
        noremap = true,
        silent = true,
        desc = "Find existing buffers",
      },
      {
        "<leader>?",
        require("telescope.builtin").oldfiles,
        desc = "Find recently opened files",
      },
      {
        "<leader>fg",
        require("telescope.builtin").git_files,
        desc = "Find Git files",
      },
      {
        "<leader>fi",
        ":Telescope import<CR>",
        desc = "[F]ind [I]mports",
        silent = true,
      },
      {
        "<leader>sg",
        function()
          require("telescope").extensions.egrepify.egrepify({
            vimgrep_arguments = {
              "rg",
              "--color=never",
              "--no-heading",
              "--with-filename",
              "--line-number",
              "--column",
              "--smart-case",
              "--trim", -- add this value
            },
          })
        end,
        silent = true,
        desc = "Live Grep (Telescope egrepify)",
      },
    },
    -- change some options
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      telescope.load_extension("zf-native")
      telescope.load_extension("import")
      telescope.load_extension("smart_open")
      telescope.load_extension("egrepify")
    end,
    opts = {
      defaults = {
        file_ignore_patterns = {
          "^static/",
          "^matrix-files/",
          "^dist/",
          "^.git/",
          "package-lock.json",
          "*.lock",
        },
        layout_strategy = "horizontal",
        layout_config = {
          height = 0.90,
          width = 0.90,
          preview_cutoff = 0,
          horizontal = { preview_width = 0.60 },
          vertical = { width = 0.55, height = 0.9, preview_cutoff = 0 },
          prompt_position = "top",
        },
        path_display = { "smart" },
        prompt_prefix = " ",
        selection_caret = " ",
        sorting_strategy = "ascending",
        winblend = 0,
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--hidden",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--trim", -- add this value
        },
      },
      pickers = {
        find_files = {
          -- Find files with Telescope, with grep, including hidden, ignoring .git
          find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
        },
        buffers = {
          prompt_prefix = "󰸩 ",
        },
        commands = {
          prompt_prefix = " ",
          layout_config = {
            height = 0.63,
            width = 0.78,
          },
        },
        command_history = {
          prompt_prefix = " ",
          layout_config = {
            height = 0.63,
            width = 0.58,
          },
        },
        git_files = {
          prompt_prefix = "󰊢 ",
          show_untracked = true,
        },
        live_grep = {
          prompt_prefix = "󰱽 ",
        },
        grep_string = {
          prompt_prefix = "󰱽 ",
        },
        undo = {
          prompt_prefix = "↩ ",
        },
      },
      extensions = {
        ["zf-native"] = {
          file = { -- options for sorting file-like items
            enable = true, -- override default telescope file sorter
            highlight_results = true, -- highlight matching text in results
            match_filename = true, -- enable zf filename match priority
          },
          generic = { -- options for sorting all other items
            enable = true, -- override default telescope generic item sorter
            highlight_results = true, -- highlight matching text in results
            match_filename = false, -- disable zf filename match priority
          },
        },
        import = {
          -- Add imports to the top of the file keeping the cursor in place
          insert_at_top = true,
        },
        smart_open = {
          cwd_only = true,
          filename_first = true,
        },
        egrepify = {
          prefixes = {
            -- ADDED ! to invert matches
            -- example prompt: ! sorter
            -- matches all lines that do not comprise sorter
            -- rg --invert-match -- sorter
            ["?"] = {
              flag = "hidden",
            },
          },
        },
      },
    },
  },
}
