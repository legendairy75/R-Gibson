return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      dashboard = {
        preset = {
          header = [[
        ██╗      █████╗ ███████╗██╗   ██╗ ██████╗  █████╗ ██╗             Z
        ██║     ██╔══██╗╚══███╔╝╚██╗ ██╔╝ ██╔══██╗██╔══██║╚═╝          Z   
        ██║     ███████║  ███╔╝  ╚████╔╝  █████══╝██║  ██║██╗       z      
        ██║     ██╔══██║ ███╔╝    ╚██╔╝   ██╔══██╗██║  ██║██║     z        
        ███████╗██║  ██║███████╗   ██║    ██████╔╝ █████╔╝██║              
        ╚══════╝╚═╝  ╚═╝╚══════╝   ╚═╝    ╚═════╝  ╚════╝ ╚═╝              
       ]],
        -- stylua: ignore
        ---@type snacks.dashboard.Item[]
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
          { icon = " ", key = "s", desc = "Restore Session", section = "session" },
          { icon = " ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
          { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
        },
        sections = {
          { section = "header", gap = 1 },
          -- {
          --   pane = 2,
          --   section = "terminal",
          --   cmd = "echo hello!",
          --   height = 5,
          --   padding = 1,
          -- },
          { section = "keys", gap = 1, padding = 1 },
          { pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
          { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
          -- {
          --   pane = 2,
          --   icon = " ",
          --   title = "Git Status",
          --   section = "terminal",
          --   enabled = Snacks.git.get_root() ~= nil,
          --   cmd = "hub status --short --branch --renames",
          --   height = 5,
          --   padding = 1,
          --   ttl = 5 * 60,
          --   indent = 3,
          -- },
          { section = "startup" },
        },
      },
    },
  },
}
