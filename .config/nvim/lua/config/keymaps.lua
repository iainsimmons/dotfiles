-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap.set -- for consiseness

keymap("v", "J", ":m '>+1<CR>gv=gv") -- move selected line down
keymap("v", "K", ":m '<-2<CR>gv=gv") -- move selected line up

-- yank and delete to other registers
keymap("n", "<leader>y", '"+y')
keymap("v", "<leader>y", '"+y')
keymap("n", "<leader>Y", '"+Y')
keymap("n", "<leader>d", '"_d')
keymap("v", "<leader>d", '"_d')
keymap("n", "x", '"_x')

-- increment & decrement
keymap("n", "<leader>+", "<C-a>", { desc = "Increment number" })
keymap("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

-- cycle buffers
keymap("n", "<C-Tab>", ":bnext<CR>", { desc = "Next Buffer", silent = true })
keymap("n", "<CS-Tab>", ":bprev<CR>", { desc = "Previous Buffer", silent = true })

-- Yank whole function / object
-- https://twitter.com/Adib_Hanna/status/1662310859962548224
keymap("n", "YY", "vabVy", { desc = "Yank lines around brackets" })

-- Reveal folder of current file
keymap("n", "<leader>rf", ":! open %:h<CR>", { desc = "[R]eveal [F]older of current file in Finder", silent = true })

keymap("n", "<leader>ga", ":! git add -f %<CR>", { desc = "[G]it [A]dd (force) current file", silent = true })

keymap("n", "<leader>cc", ":! cpf %<CR>", { desc = "[C]opy [C]urrent file", silent = true })

-- https://github.com/stevedylandev/dotfiles/blob/main/nvim/lua/keymaps.lua
-- If I visually select words and paste from clipboard, don't replace my
-- clipboard with the selected word, instead keep my old word in the
-- clipboard
keymap("x", "p", '"_dP', { silent = true, noremap = true })
-- align buffer to vertical center
keymap("n", "<C-d>", "<C-d>zz", { silent = true, noremap = true })
keymap("n", "<C-u>", "<C-u>zz", { silent = true, noremap = true })
keymap("n", "n", "nzzzv", { silent = true, noremap = true })
keymap("n", "N", "Nzzzv", { silent = true, noremap = true })
-- Some useful quickfix shortcuts for quickfix
keymap("n", "<C-n>", "<cmd>cnext<CR>zz", { silent = true, noremap = true })
keymap("n", "<C-p>", "<cmd>cprev<CR>zz", { silent = true, noremap = true })
keymap("n", "<leader>xc", "<cmd>cclose<CR>", { silent = true, noremap = true })

-- . repeat or execute macro on all visually selected lines
-- eg. press A"<esc> on line one, select all others, press . and they all end in "
-- https://www.reddit.com/r/neovim/comments/1abd2cq/comment/kjn1kww/
keymap("x", ".", ":norm .<CR>", { silent = false })
keymap("x", "@", ":norm @q<CR>", { silent = false })

-- Using the keymap will take the word under the cursor
-- and populate the beginning of a global search and replace command
-- https://www.reddit.com/r/neovim/comments/1abd2cq/comment/kjojs2y/
keymap("n", "<leader>rw", ":%s/<C-r><C-w>/", { silent = false })
keymap("n", "<leader>rW", ":%s/<C-r><C-a>/", { silent = false })

-- search within selected block of code
-- https://www.reddit.com/r/neovim/comments/1abd2cq/comment/kjym8kg/
keymap("x", "/", "<Esc>/\\%V", { silent = true })

-- Gitsigns toggle line blame
keymap(
  "n",
  "<leader>gl",
  ":Gitsigns toggle_current_line_blame<CR>",
  { silent = true, desc = "[G]itsigns toggle current [L]ine blame" }
)
