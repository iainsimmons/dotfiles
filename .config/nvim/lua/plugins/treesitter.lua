return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
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
}
