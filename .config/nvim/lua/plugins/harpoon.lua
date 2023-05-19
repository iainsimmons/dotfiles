return {
  "ThePrimeagen/harpoon",
  event = {
    "BufReadPre",
    "BufNewFile",
  },
  config = function()
    local mark = require("harpoon.mark")
    local ui = require("harpoon.ui")
    require("telescope").load_extension("harpoon")
    vim.keymap.set("n", "<leader>a", mark.add_file, { desc = "Harpoon: Add File" })
    vim.keymap.set("n", "<leader>h", ":Telescope harpoon marks<CR>", { desc = "Harpoon: Quick Menu", silent = true })
    vim.keymap.set("n", "<leader>1", function()
      ui.nav_file(1)
    end, { desc = "Harpoon: Jump to 1" })
    vim.keymap.set("n", "<leader>2", function()
      ui.nav_file(2)
    end, { desc = "Harpoon: Jump to 2" })
    vim.keymap.set("n", "<leader>3", function()
      ui.nav_file(3)
    end, { desc = "Harpoon: Jump to 3" })
    vim.keymap.set("n", "<leader>4", function()
      ui.nav_file(4)
    end, { desc = "Harpoon: Jump to 4" })
  end,
}
