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
        emmet_ls = {
          filetypes = {
            "astro",
            "css",
            "eruby",
            "handlebars",
            "html",
            "htmldjango",
            "javascriptreact",
            "less",
            "pug",
            "sass",
            "scss",
            "svelte",
            "typescriptreact",
            "vue",
          },
        },
      },
    },
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = "neovim/nvim-lspconfig",
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        debounce = 150,
        save_after_format = false,
        sources = {
          null_ls.builtins.code_actions.eslint,
          null_ls.builtins.code_actions.gitsigns,
          null_ls.builtins.code_actions.refactoring,
          null_ls.builtins.code_actions.ts_node_action,
          null_ls.builtins.completion.luasnip,
          null_ls.builtins.diagnostics.fish,
          null_ls.builtins.diagnostics.flake8,
          null_ls.builtins.diagnostics.markdownlint,
          null_ls.builtins.formatting.black,
          null_ls.builtins.formatting.fish_indent,
          null_ls.builtins.formatting.mdformat,
          null_ls.builtins.formatting.shfmt,
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.djlint.with({
            filetypes = { "django", "jinja.html", "htmldjango", "handlebars" },
            command = "djlint",
            args = { "--reformat", "-" },
          }),
          null_ls.builtins.formatting.prettierd.with({
            disabled_filetypes = { "handlebars" },
          }),
        },
        root_dir = require("null-ls.utils").root_pattern("package.json", ".null-ls-root", ".neoconf.json", ".git"),
      })
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
