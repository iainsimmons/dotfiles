return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "kkharji/sqlite.lua",
      { "prochri/telescope-all-recent.nvim", opts = {} },
      "natecraddock/telescope-zf-native.nvim",
      "piersolenski/telescope-import.nvim",
      "debugloop/telescope-undo.nvim",
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
    },
    -- change some options
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      telescope.load_extension("zf-native")
      telescope.load_extension("import")
      telescope.load_extension("smart_open")
      telescope.load_extension("undo")

      vim.keymap.set("n", "<leader>U", "<cmd>Telescope undo<cr>")
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
      },
    },
  },
  {
    "nvim-telescope/telescope-live-grep-args.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      local telescope = require("telescope")
      local lga_actions = require("telescope-live-grep-args.actions")
      -- https://github.com/nvim-telescope/telescope-live-grep-args.nvim
      -- Uses ripgrep args (rg) for live_grep
      -- Command examples:
      -- -i "Data"  # case insensitive
      -- -g "!*.md" # ignore md files
      -- -w # whole word
      -- -e # regex
      -- see 'man rg' for more
      telescope.load_extension("live_grep_args")
      telescope.setup({
        extensions = {
          live_grep_args = {
            auto_quoting = true, -- enable/disable auto-quoting
            -- define mappings, e.g.
            mappings = { -- extend mappings
              i = {
                ["<C-k>"] = lga_actions.quote_prompt(),
                ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
              },
            },
          },
        },
      })
    end,
    keys = {
      {
        "<leader>fa",
        ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
        desc = "Live Grep (Args)",
      },
    },

    -- opts will be merged with the parent spec
    opts = {
      pickers = {
        live_grep = {
          additional_args = function()
            return { "--hidden" }
          end,
        },
      },
    },
  },
}
