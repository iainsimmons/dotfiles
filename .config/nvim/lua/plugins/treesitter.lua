return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = { "nvim-treesitter/nvim-treesitter-context" },
    opts = function(_, opts)
      require("nvim-treesitter.configs").setup(vim.list_extend(opts, {
        autotag = {
          enable = true,
        },
      }))
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, {
          "astro",
          "bash",
          "css",
          "gitignore",
          "jsdoc",
          "json",
          "json5",
          "jsonc",
          "lua",
          "markdown",
          "markdown_inline",
          "regex",
          "scss",
          "toml",
          "tsx",
          "typescript",
          "vim",
        })
      end
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = { "BufReadPost", "BufNewFile" },
    keys = {
      {
        "[c",
        function()
          require("treesitter-context").go_to_context()
        end,
        silent = true,
        desc = "Go to Context",
      },
    },
  },
  {
    "ckolkey/ts-node-action",
    dependencies = { "nvim-treesitter" },
    opts = {},
  },
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-treesitter/nvim-treesitter" },
    },
  },
}
