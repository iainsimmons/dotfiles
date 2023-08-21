return {
  {
    "neovim/nvim-lspconfig",
    dependencies = { "jose-elias-alvarez/typescript.nvim" },
    opts = {
      servers = {
        tsserver = {
          settings = {
            completions = {
              completeFunctionCalls = true,
            },
          },
        },
        yamlls = {
          filetypes = { "yaml", "yaml.docker-compose", "yml" },
          settings = {
            yaml = {
              redhat = { telemetry = { enabled = false } },
              keyOrdering = false,
              schemas = {
                ["https://raw.githubusercontent.com/distinction-dev/alacritty-schema/main/alacritty/reference.json"] = "alacritty.yml",
              },
            },
          },
        },
      },
    },
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      table.insert(
        opts.sources,
        nls.builtins.formatting.djlint.with({
          filetypes = { "django", "jinja.html", "htmldjango", "handlebars" },
          command = "djlint",
          args = { "--reformat", "-" },
        })
      )
      table.insert(
        opts.sources,
        nls.builtins.formatting.prettierd.with({
          disabled_filetypes = { "handlebars" },
        })
      )
    end,
  },
  {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    event = { "LspAttach" },
    config = function()
      require("lsp_lines").setup()
      vim.diagnostic.config({
        virtual_text = false,
      })
    end,
    keys = {
      {
        "<leader>uL",
        function()
          require("lsp_lines").toggle()
        end,
        desc = "Toggle LSP Lines",
      },
    },
  },
}
