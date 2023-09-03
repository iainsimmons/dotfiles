return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      {
        "nvim-telescope/telescope-ui-select.nvim",
        config = function()
          require("telescope").load_extension("ui-select")
        end,
      },
    },
    keys = {
      { "<leader>/", false },
      {
        "<leader><space>",
        require("telescope.builtin").buffers,
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
    },
    -- change some options
    config = function()
      local telescope = require("telescope")
      telescope.setup({
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
          layout_config = { prompt_position = "top" },
          sorting_strategy = "ascending",
          winblend = 0,
        },
        pickers = {
          find_files = {
            -- Find files with Telescope, with grep, including hidden, ignoring .git
            find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
          },
        },
      })
      require("telescope").load_extension("fzf")
    end,
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
        "<leader>/",
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
