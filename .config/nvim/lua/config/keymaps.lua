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
