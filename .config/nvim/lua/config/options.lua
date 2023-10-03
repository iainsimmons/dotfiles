-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.wrap = true
vim.opt.conceallevel = 0
vim.opt.diffopt = "internal,filler,closeoff,vertical"

-- Add .psv extension for Pipe Separated Values format
vim.filetype.add({
  pattern = {
    ["*.psv"] = "csv_pipe",
    ["*.csv"] = "csv_semicolon",
  },
})
