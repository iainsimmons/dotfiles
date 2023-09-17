-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap -- for consiseness
keymap.set("v", "J", ":m '>+1<CR>gv=gv") -- move selected line down
keymap.set("v", "K", ":m '<-2<CR>gv=gv") -- move selected line up
-- yank and delete to other registers
keymap.set("n", "<leader>y", '"+y')
keymap.set("v", "<leader>y", '"+y')
keymap.set("n", "<leader>Y", '"+Y')
keymap.set("n", "<leader>d", '"_d')
keymap.set("v", "<leader>d", '"_d')
keymap.set("n", "x", '"_x')
-- increment & decrement
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" })
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" })
-- cycle buffers
keymap.set("n", "<C-Tab>", ":bnext<CR>", { desc = "Next Buffer", silent = true })
keymap.set("n", "<CS-Tab>", ":bprev<CR>", { desc = "Previous Buffer", silent = true })
-- Yank whole function / object
-- https://twitter.com/Adib_Hanna/status/1662310859962548224
keymap.set("n", "YY", "vabVy", { desc = "Yank lines around brackets" })
-- Reveal folder of current file
keymap.set(
  "n",
  "<leader>rf",
  ":! open %:h<CR>",
  { desc = "[R]eveal [F]older of current file in Finder", silent = true }
)

keymap.set("n", "<leader>ga", ":! git add -f %<CR>", { desc = "[G]it [A]dd (force) current file", silent = true })

keymap.set("n", "<leader>uh", ":HighlightColorsToggle<CR>", { desc = "[H]ighlightColors Toggle", silent = true })
