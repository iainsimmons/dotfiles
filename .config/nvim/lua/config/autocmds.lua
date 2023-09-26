-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_custom_" .. name, { clear = true })
end

-- disable wrapping and spell check for hosts file
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  group = augroup("nowrap_hosts"),
  pattern = { "/etc/hosts" },
  callback = function()
    vim.opt_local.wrap = false
    vim.opt_local.spell = false
  end,
})

-- Disable the plugin in Lazy.nvim
vim.api.nvim_create_autocmd("FileType", {
  pattern = "lazy",
  callback = function()
    local previous = not require("lsp_lines").toggle()
    if not previous then
      require("lsp_lines").toggle()
    end
  end,
})

-- Use html.handlebars for hbs files
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  pattern = "*.hbs",
  callback = function()
    vim.bo.filetype = "html.handlebars"
  end,
})
