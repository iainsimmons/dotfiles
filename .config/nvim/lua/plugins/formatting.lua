return {
  "stevearc/conform.nvim",
  opts = {
    format = {
      lsp_fallback = true,
    },
    formatters_by_ft = {
      lua = { "stylua" },
      fish = { "fish_indent" },
      sh = { "shfmt" },
      javascript = { "prettierd", "prettier" },
      javascriptreact = { "prettierd", "prettier" },
      typescript = { "prettierd", "prettier" },
      typescriptreact = { "prettierd", "prettier" },
      vue = { "prettierd", "prettier" },
      css = { "prettierd", "prettier" },
      scss = { "prettierd", "prettier" },
      less = { "prettierd", "prettier" },
      html = { "prettierd", "prettier" },
      json = { "prettierd", "prettier" },
      jsonc = { "prettierd", "prettier" },
      yaml = { "prettierd", "prettier" },
      markdown = { "markdownlint", "cbfmt" },
      --
      ["markdown.mdx"] = { "markdownlint", "cbfmt" },
      graphql = { "prettierd", "prettier" },
      handlebars = { "prettierd", "prettier" },
      svelte = { "prettierd", "prettier" },
      xml = { "xmlformatter" },
      rss = { "xmlformatter" },
    },
  },
}
