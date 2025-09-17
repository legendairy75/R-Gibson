return {
  {
    "olrtg/nvim-emmet",
    config = function()
      vim.keymap.set({ "n", "v" }, "<leader>xe", require("nvim-emmet").wrap_with_abbreviation)
    end,
  },
  require("luasnip.loaders.from_vscode").lazy_load({ paths = "~/.config/nvim/my_snippets" }),
}
