-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.wrap = true
vim.opt.conceallevel = 0
vim.opt.diffopt = "internal,filler,closeoff,vertical"

-- add highlight colours for indent blankline
vim.cmd([[highlight IndentBlanklineIndent1 guifg=#ff007c gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent2 guifg=#ff9e64 gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent3 guifg=#bb9af7 gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent4 guifg=#9ece6a gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent5 guifg=#1abc9c gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent6 guifg=#f7768e gui=nocombine]])

-- Add .psv extension for Pipe Separated Values format
vim.filetype.add({
  pattern = {
    ["*.psv"] = "csv_pipe",
    ["*.csv"] = "csv_semicolon",
  },
})
