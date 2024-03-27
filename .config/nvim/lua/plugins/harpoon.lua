return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  opts = {
    menu = {
      width = vim.api.nvim_win_get_width(0) - 4,
    },
  },
  config = function(_, opts)
    local harpoon = require("harpoon")
    harpoon:setup(opts)

    -- basic telescope configuration
    local conf = require("telescope.config").values
    local actions = require("telescope.actions")

    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      require("telescope.pickers")
        .new({}, {
          prompt_title = "Harpoon",
          finder = require("telescope.finders").new_table({
            results = file_paths,
          }),
          previewer = conf.file_previewer({}),
          sorter = conf.generic_sorter({}),
          attach_mappings = function(_, map)
            map({ "i", "n" }, "<M-d>", function(prompt_bufnr)
              local action_state = require("telescope.actions.state")
              local current_picker = action_state.get_current_picker(prompt_bufnr)

              current_picker:delete_selection(function(selection)
                require("harpoon"):list():removeAt(selection.index)
              end)
            end, { desc = "Remove from harpoon list" })
            return true
          end,
        })
        :find()
    end

    vim.keymap.set("n", "<leader>h", function()
      toggle_telescope(harpoon:list())
    end, { desc = "Open harpoon window" })
  end,
  keys = {
    {
      "<leader>H",
      function()
        require("harpoon"):list():append()
      end,
      desc = "Harpoon file",
    },
    {
      "<C-e>",
      function()
        local harpoon = require("harpoon")
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end,
      desc = "Harpoon quick menu",
    },
    {
      "<leader>1",
      function()
        require("harpoon"):list():select(1)
      end,
      desc = "Harpoon to file 1",
    },
    {
      "<leader>2",
      function()
        require("harpoon"):list():select(2)
      end,
      desc = "Harpoon to file 2",
    },
    {
      "<leader>3",
      function()
        require("harpoon"):list():select(3)
      end,
      desc = "Harpoon to file 3",
    },
    {
      "<leader>4",
      function()
        require("harpoon"):list():select(4)
      end,
      desc = "Harpoon to file 4",
    },
    {
      "<leader>5",
      function()
        require("harpoon"):list():select(5)
      end,
      desc = "Harpoon to file 5",
    },
  },
}
