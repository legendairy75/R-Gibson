return {
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "LazyFile",
    version = "3.5.4",
    main = "ibl",
    opts = {},
  },
  -- messages, cmdline and the popupmenu
  {
    "folke/noice.nvim",
    opts = function(_, opts)
      table.insert(opts.routes, {
        filter = {
          event = "notify",
          find = "No information available",
        },
        opts = { skip = true },
      })
      local focused = true
      vim.api.nvim_create_autocmd("FocusGained", {
        callback = function()
          focused = true
        end,
      })
      vim.api.nvim_create_autocmd("FocusLost", {
        callback = function()
          focused = false
        end,
      })
      table.insert(opts.routes, 1, {
        filter = {
          cond = function()
            return not focused
          end,
        },
        view = "notify_send",
        opts = { stop = false },
      })

      opts.commands = {
        all = {
          -- options for the message history that you get with `:Noice`
          view = "split",
          opts = { enter = true, format = "details" },
          filter = {},
        },
      }

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function(event)
          vim.schedule(function()
            require("noice.text.markdown").keys(event.buf)
          end)
        end,
      })

      opts.presets.lsp_doc_border = true
    end,
  },

  {
    "rcarriga/nvim-notify",
    opts = {
      timeout = 5000,
    },
  },

  -- animations
  {
    "echasnovski/mini.animate",
    event = "VeryLazy",
    opts = function(_, opts)
      opts.scroll = {
        enable = false,
      }
    end,
  },

  -- buffer line
  -- {
  -- 	"akinsho/bufferline.nvim",
  -- 	event = "VeryLazy",
  -- 	keys = {
  -- 		{ "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next tab" },
  -- 		{ "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev tab" },
  -- 	},
  -- 	opts = {
  -- 		options = {
  -- 			mode = "tabs",
  -- 			-- separator_style = "slant",
  -- 			show_buffer_close_icons = false,
  -- 			show_close_icon = false,
  -- 		},
  -- 	},
  -- },:

  -- statusline
  -- {
  -- 	"nvim-lualine/lualine.nvim",
  -- 	event = "VeryLazy",
  -- 	opts = {
  -- 		options = {
  -- 			-- globalstatus = false,
  -- 			theme = "solarized_dark",
  -- 		},
  -- 	},
  -- },

  -- filename
  {
    "b0o/incline.nvim",
    dependencies = { "craftzdog/solarized-osaka.nvim" },
    event = "BufReadPre",
    priority = 1200,
    config = function()
      local colors = require("solarized-osaka.colors").setup()
      require("incline").setup({
        highlight = {
          groups = {
            InclineNormal = { guibg = colors.magenta500, guifg = colors.base04 },
            InclineNormalNC = { guifg = colors.violet500, guibg = colors.base03 },
          },
        },
        window = { margin = { vertical = 0, horizontal = 1 } },
        hide = {
          cursorline = true,
        },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          if vim.bo[props.buf].modified then
            filename = "[+] " .. filename
          end

          local icon, color = require("nvim-web-devicons").get_icon_color(filename)
          return { { icon, guifg = color }, { " " }, { filename } }
        end,
      })
    end,
  },

  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opts = {
      plugins = {
        gitsigns = true,
        tmux = true,
        kitty = { enabled = false, font = "+2" },
      },
    },
    keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
  },
  -- {
  --   "nvimdev/dashboard-nvim",
  --   event = "VimEnter",
  --   opts = function(_, opts)
  --     local logo = [[
  --      ██╗      █████╗ ███████╗██╗   ██╗ ██████╗  █████╗ ██╗             Z
  --      ██║     ██╔══██╗╚══███╔╝╚██╗ ██╔╝ ██╔══██╗██╔══██║╚═╝          Z
  --      ██║     ███████║  ███╔╝  ╚████╔╝  █████══╝██║  ██║██╗       z
  --      ██║     ██╔══██║ ███╔╝    ╚██╔╝   ██╔══██╗██║  ██║██║     z
  --      ███████╗██║  ██║███████╗   ██║    ██████╔╝ █████╔╝██║
  --      ╚══════╝╚═╝  ╚═╝╚══════╝   ╚═╝    ╚═════╝  ╚════╝ ╚═╝
  --     ]]
  --
  --     logo = string.rep("\n", 8) .. logo .. "\n\n"
  --
  --     local opts = {
  --       theme = "doom",
  --       hide = {
  --         -- this is taken care of by lualine
  --         -- enabling this messes up the actual laststatus setting after loading a file
  --         statusline = false,
  --       },
  --       config = {
  --         header = vim.split(logo, "\n"),
  --     -- stylua: ignore
  --     center = {
  --       { action = 'lua LazyVim.pick()()',                           desc = " Find File",       icon = " ", key = "f" },
  --       { action = "ene | startinsert",                              desc = " New File",        icon = " ", key = "n" },
  --       { action = 'lua LazyVim.pick("oldfiles")()',                 desc = " Recent Files",    icon = " ", key = "r" },
  --       { action = 'lua LazyVim.pick("live_grep")()',                desc = " Find Text",       icon = " ", key = "g" },
  --       { action = 'lua LazyVim.pick.config_files()()',              desc = " Config",          icon = " ", key = "c" },
  --       { action = 'lua require("persistence").load()',              desc = " Restore Session", icon = " ", key = "s" },
  --       { action = "LazyExtras",                                     desc = " Lazy Extras",     icon = " ", key = "x" },
  --       { action = "Lazy",                                           desc = " Lazy",            icon = "󰒲 ", key = "l" },
  --       { action = function() vim.api.nvim_input("<cmd>qa<cr>") end, desc = " Quit",            icon = " ", key = "q" },
  --     },
  --         footer = function()
  --           local stats = require("lazy").stats()
  --           local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
  --           return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
  --         end,
  --       },
  --     }
  --
  --     for _, button in ipairs(opts.config.center) do
  --       button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
  --       button.key_format = "  %s"
  --     end
  --
  --     -- open dashboard after closing lazy
  --     if vim.o.filetype == "lazy" then
  --       vim.api.nvim_create_autocmd("WinClosed", {
  --         pattern = tostring(vim.api.nvim_get_current_win()),
  --         once = true,
  --         callback = function()
  --           vim.schedule(function()
  --             vim.api.nvim_exec_autocmds("UIEnter", { group = "dashboard" })
  --           end)
  --         end,
  --       })
  --     end
  --
  --     return opts
  --   end,
  -- },

  -- {
  --   "nvim-lualine/lualine.nvim",
  --   event = "VeryLazy",
  --   init = function()
  --     vim.g.lualine_laststatus = vim.o.laststatus
  --     if vim.fn.argc(-1) > 0 then
  --       -- set an empty statusline till lualine loads
  --       vim.o.statusline = " "
  --     else
  --       -- hide the statusline on the starter page
  --       vim.o.laststatus = 0
  --     end
  --   end,
  --   opts = function()
  --     -- PERF: we don't need this lualine require madness 🤷
  --     local lualine_require = require("lualine_require")
  --     lualine_require.require = require
  --
  --     local icons = LazyVim.config.icons
  --
  --     vim.o.laststatus = vim.g.lualine_laststatus
  --
  --     local opts = {
  --       options = {
  --         theme = "auto",
  --         globalstatus = vim.o.laststatus == 3,
  --         disabled_filetypes = { statusline = { "dashboard", "alpha", "ministarter" } },
  --       },
  --       sections = {
  --         lualine_a = { "mode" },
  --         lualine_b = { "branch" },
  --
  --         lualine_c = {
  --           LazyVim.lualine.root_dir(),
  --           {
  --             "diagnostics",
  --             symbols = {
  --               error = icons.diagnostics.Error,
  --               warn = icons.diagnostics.Warn,
  --               info = icons.diagnostics.Info,
  --               hint = icons.diagnostics.Hint,
  --             },
  --           },
  --           { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
  --           { LazyVim.lualine.pretty_path() },
  --         },
  --
  --         lualine_d = { "buffers" },
  --
  --         lualine_x = {
  --         -- stylua: ignore
  --         {
  --           function() return require("noice").api.status.command.get() end,
  --           cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
  --           color = function() return LazyVim.ui.fg("Statement") end,
  --         },
  --         -- stylua: ignore
  --         {
  --           function() return require("noice").api.status.mode.get() end,
  --           cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
  --           color = function() return LazyVim.ui.fg("Constant") end,
  --         },
  --         -- stylua: ignore
  --         {
  --           function() return "  " .. require("dap").status() end,
  --           cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
  --           color = function() return LazyVim.ui.fg("Debug") end,
  --         },
  --         -- stylua: ignore
  --         {
  --           require("lazy.status").updates,
  --           cond = require("lazy.status").has_updates,
  --           color = function() return LazyVim.ui.fg("Special") end,
  --         },
  --           {
  --             "diff",
  --             symbols = {
  --               added = icons.git.added,
  --               modified = icons.git.modified,
  --               removed = icons.git.removed,
  --             },
  --             source = function()
  --               local gitsigns = vim.b.gitsigns_status_dict
  --               if gitsigns then
  --                 return {
  --                   added = gitsigns.added,
  --                   modified = gitsigns.changed,
  --                   removed = gitsigns.removed,
  --                 }
  --               end
  --             end,
  --           },
  --         },
  --         lualine_y = {
  --           { "progress", separator = " ", padding = { left = 1, right = 0 } },
  --           { "location", padding = { left = 0, right = 1 } },
  --         },
  --         lualine_z = {
  --           function()
  --             return " " .. os.date("%R")
  --           end,
  --         },
  --       },
  --       inactive_sections = {
  --         lualine_a = {},
  --         lualine_b = {},
  --         lualine_c = { "filename" },
  --         lualine_x = { "location" },
  --         lualine_y = {},
  --         lualine_z = {},
  --       },
  --       extensions = { "neo-tree", "lazy" },
  --     }
  --
  --     -- do not add trouble symbols if aerial is enabled
  --     -- And allow it to be overriden for some buffer types (see autocmds)
  --     if vim.g.trouble_lualine and LazyVim.has("trouble.nvim") then
  --       local trouble = require("trouble")
  --       local symbols = trouble.statusline({
  --         mode = "symbols",
  --         groups = {},
  --         title = false,
  --         filter = { range = true },
  --         format = "{kind_icon}{symbol.name:Normal}",
  --         hl_group = "lualine_c_normal",
  --       })
  --       table.insert(opts.sections.lualine_c, {
  --         symbols and symbols.get,
  --         cond = function()
  --           return vim.b.trouble_lualine ~= false and symbols.has()
  --         end,
  --       })
  --     end
  --
  --     return opts
  --   end,
  -- },
  -- {
  --   "jake-stewart/multicursor.nvim",
  --   branch = "1.0",
  --   config = function()
  --     local mc = require("multicursor-nvim")
  --
  --     mc.setup()
  --
  --     local set = vim.keymap.set
  --
  --     -- Add or skip cursor above/below the main cursor.
  --     set({ "n", "v" }, "<up>", function()
  --       mc.lineAddCursor(-1)
  --     end)
  --     set({ "n", "v" }, "<down>", function()
  --       mc.lineAddCursor(1)
  --     end)
  --     set({ "n", "v" }, "<leader><up>", function()
  --       mc.lineSkipCursor(-1)
  --     end)
  --     set({ "n", "v" }, "<leader><down>", function()
  --       mc.lineSkipCursor(1)
  --     end)
  --
  --     -- Add or skip adding a new cursor by matching word/selection
  --     set({ "n", "v" }, "<leader>n", function()
  --       mc.matchAddCursor(1)
  --     end)
  --     set({ "n", "v" }, "<leader>s", function()
  --       mc.matchSkipCursor(1)
  --     end)
  --     set({ "n", "v" }, "<leader>N", function()
  --       mc.matchAddCursor(-1)
  --     end)
  --     set({ "n", "v" }, "<leader>S", function()
  --       mc.matchSkipCursor(-1)
  --     end)
  --
  --     -- Add all matches in the document
  --     set({ "n", "v" }, "<leader>A", mc.matchAllAddCursors)
  --
  --     -- You can also add cursors with any motion you prefer:
  --     -- set("n", "<right>", function()
  --     --     mc.addCursor("w")
  --     -- end)
  --     -- set("n", "<leader><right>", function()
  --     --     mc.skipCursor("w")
  --     -- end)
  --
  --     -- Rotate the main cursor.
  --     set({ "n", "v" }, "<left>", mc.nextCursor)
  --     set({ "n", "v" }, "<right>", mc.prevCursor)
  --
  --     -- Delete the main cursor.
  --     set({ "n", "v" }, "<leader>x", mc.deleteCursor)
  --
  --     -- Add and remove cursors with control + left click.
  --     set("n", "<c-leftmouse>", mc.handleMouse)
  --
  --     -- Easy way to add and remove cursors using the main cursor.
  --     set({ "n", "v" }, "<c-q>", mc.toggleCursor)
  --
  --     -- Clone every cursor and disable the originals.
  --     set({ "n", "v" }, "<leader><c-q>", mc.duplicateCursors)
  --
  --     set("n", "<esc>", function()
  --       if not mc.cursorsEnabled() then
  --         mc.enableCursors()
  --       elseif mc.hasCursors() then
  --         mc.clearCursors()
  --       else
  --         -- Default <esc> handler.
  --       end
  --     end)
  --
  --     -- bring back cursors if you accidentally clear them
  --     set("n", "<leader>gv", mc.restoreCursors)
  --
  --     -- Align cursor columns.
  --     set("n", "<leader>a", mc.alignCursors)
  --
  --     -- Split visual selections by regex.
  --     set("v", "S", mc.splitCursors)
  --
  --     -- Append/insert for each line of visual selections.
  --     set("v", "I", mc.insertVisual)
  --     set("v", "A", mc.appendVisual)
  --
  --     -- match new cursors within visual selections by regex.
  --     set("v", "M", mc.matchCursors)
  --
  --     -- Rotate visual selection contents.
  --     set("v", "<leader>t", function()
  --       mc.transposeCursors(1)
  --     end)
  --     set("v", "<leader>T", function()
  --       mc.transposeCursors(-1)
  --     end)
  --
  --     -- Jumplist support
  --     set({ "v", "n" }, "<c-i>", mc.jumpForward)
  --     set({ "v", "n" }, "<c-o>", mc.jumpBackward)
  --
  --     -- Customize how cursors look.
  --     local hl = vim.api.nvim_set_hl
  --     hl(0, "MultiCursorCursor", { link = "Cursor" })
  --     hl(0, "MultiCursorVisual", { link = "Visual" })
  --     hl(0, "MultiCursorSign", { link = "SignColumn" })
  --     hl(0, "MultiCursorDisabledCursor", { link = "Visual" })
  --     hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
  --     hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
  --   end,
  -- },
}
