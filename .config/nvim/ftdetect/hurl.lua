vim.filetype.add({
  extension = {
    hurl = "hurl",
  },
})
vim.api.nvim_command("set commentstring=#%s")
