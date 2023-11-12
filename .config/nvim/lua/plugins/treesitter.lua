return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = { "nvim-treesitter/nvim-treesitter-context" },
    opts = function(_, opts)
      require("nvim-treesitter.configs").setup(vim.list_extend(opts, {
        autotag = {
          enable = true,
        },
        auto_install = true,
        highlight = {
          enable = true,
        },
        ensure_installed = {
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
        },
        textobjects = {
          select = {
            enable = true,

            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,
          },
        },
      }))
    end,
  },
}
