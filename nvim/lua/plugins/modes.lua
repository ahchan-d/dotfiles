return {
  "mvllow/modes.nvim",
  event = "VeryLazy",
  config = function()
    -- modes.nvim に必要
    vim.opt.cursorline = true

    require("modes").setup({
      colors = {
        copy = "#f5c359",
        delete = "#c75c6a",
        insert = "#78ccc5",
        visual = "#9745be",
      },
      line_opacity = 0.2,
      set_cursor = true,
      set_cursorline = true,
      set_number = true,
      ignore = { "NvimTree", "TelescopePrompt", "alpha" },
    })
  end,
}
