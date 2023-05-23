return {
  "stevearc/oil.nvim",
  cmd = "Oil",
  opts = {
    view_options = {
      -- Show files and directories that start with "."
      show_hidden = true,
      -- This function defines what is considered a "hidden" file
      is_hidden_file = function(name, _)
        return vim.startswith(name, ".")
      end,
      -- This function defines what will never be shown, even when `show_hidden` is set
      is_always_hidden = function(name, _)
        if name == ".DS_Store" then
          return true
        end
        return false
      end,
    },
  },
  -- Optional dependencies
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { "<leader>o", ":Oil --float %:p:h<CR>", desc = "Oil: Open Current Dir", silent = true },
  },
}
