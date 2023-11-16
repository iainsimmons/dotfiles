return {
  {
    "neovim/nvim-lspconfig",
    dependencies = { "jose-elias-alvarez/typescript.nvim" },
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- disable rename keymap so we can instead use Incremental rename
      keys[#keys + 1] = { "<leader>cr", false }
    end,
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
