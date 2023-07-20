return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    {
      "nvim-telescope/telescope-ui-select.nvim",
      config = function()
        require("telescope").load_extension("ui-select")
      end,
    },
  },
  keys = {
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
  },
}
