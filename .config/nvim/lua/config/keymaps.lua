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

keymap.set("n", "<leader>cc", ":! cpf %<CR>", { desc = "[C]opy [C]urrent file", silent = true })

-- https://github.com/stevedylandev/dotfiles/blob/main/nvim/lua/keymaps.lua
-- If I visually select words and paste from clipboard, don't replace my
-- clipboard with the selected word, instead keep my old word in the
-- clipboard
keymap.set("x", "p", '"_dP', { silent = true, noremap = true })
-- align buffer to vertical center
keymap.set("n", "<C-d>", "<C-d>zz", { silent = true, noremap = true })
keymap.set("n", "<C-u>", "<C-u>zz", { silent = true, noremap = true })
keymap.set("n", "n", "nzzzv", { silent = true, noremap = true })
keymap.set("n", "N", "Nzzzv", { silent = true, noremap = true })
-- Some useful quickfix shortcuts for quickfix
keymap.set("n", "<C-n>", "<cmd>cnext<CR>zz", { silent = true, noremap = true })
keymap.set("n", "<C-p>", "<cmd>cprev<CR>zz", { silent = true, noremap = true })
keymap.set("n", "<leader>xc", "<cmd>cclose<CR>", { silent = true, noremap = true })
