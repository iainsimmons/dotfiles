return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "astro-language-server",
        "emmet-ls",
        "eslint-lsp",
        "glint",
        "html-lsp",
        "htmx-lsp",
        "json-lsp",
        "lemminx",
        "lua-language-server",
        "markdownlint",
        "marksman",
        "prettierd",
        "shfmt",
        "stylua",
        "tailwindcss-language-server",
        "typescript-language-server",
        "xmlformatter",
        "yaml-language-server",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "jose-elias-alvarez/typescript.nvim",
      {
        "b0o/SchemaStore.nvim",
        lazy = true,
        version = false, -- last release is way too old
      },
    },
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- disable rename keymap so we can instead use Incremental rename
      keys[#keys + 1] = { "<leader>cr", false }
      keys[#keys + 1] = { "<leader>cc", false }
    end,
    opts = {
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { "vim" },
              },
            },
          },
        },
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
            },
          },
        },
        jsonls = {
          settings = {
            json = {
              schemas = require("schemastore").json.schemas({
                select = {
                  ".eslintrc",
                  "package.json",
                  "openapi.json",
                },
              }),
              validate = { enable = true },
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
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    event = { "LspAttach" },
    commit = "cf2306d",
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
  -- Incremental rename
  {
    "smjonas/inc-rename.nvim",
    event = { "BufNewFile", "BufReadPost" },
    dependencies = {
      "folke/noice.nvim",
    },
    cmd = "IncRename",
    config = function()
      ---@diagnostic disable-next-line: missing-parameter
      require("inc_rename").setup()
      require("noice").setup({
        presets = { inc_rename = true },
      })
      vim.keymap.set("n", "<leader>cr", function()
        return ":IncRename " .. vim.fn.expand("<cword>")
      end, { expr = true, desc = "Incremental Rename" })
    end,
  },
}
