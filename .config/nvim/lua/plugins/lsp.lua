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
                ["https://raw.githubusercontent.com/distinction-dev/alacritty-schema/main/alacritty/reference.json"] = "alacritty.yml"
              }
            },
          },
        },
      },
    },
  },
}
