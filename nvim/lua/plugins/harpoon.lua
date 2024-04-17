return {
  "ThePrimeagen/harpoon",
  keys = {
    {
      "<leader>H",
      function()
        require("harpoon"):list():add()
      end,
      desc = "Harpoon file",
    },
    {
      "<leader>h",
      function()
        local harpoon = require("harpoon")
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end,
      desc = "Harpoon quick menu",
    },
    {
      "<tab>j",
      function()
        require("harpoon"):list():select(1)
      end,
      desc = "Harpoon to file 1",
    },
    {
      "<tab>k",
      function()
        require("harpoon"):list():select(2)
      end,
      desc = "Harpoon to file 2",
    },
    {
      "<tab>l",
      function()
        require("harpoon"):list():select(3)
      end,
      desc = "Harpoon to file 3",
    },
    {
      "<tab>;",
      function()
        require("harpoon"):list():select(4)
      end,
      desc = "Harpoon to file 4",
    },
  },
}
