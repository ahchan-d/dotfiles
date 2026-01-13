return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    dashboard.section.header.val = {
      "                                                     ",
      "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
      "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
      "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
      "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
      "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
      "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
      "                                                     ",
    }

    dashboard.section.buttons.val = {
      dashboard.button("r", "  Recent files", "<cmd>Telescope oldfiles<CR>"),
      dashboard.button("f", "  Find file", "<cmd>Telescope find_files<CR>"),
      dashboard.button("g", "  Grep text", "<cmd>Telescope live_grep<CR>"),
      dashboard.button("n", "  New file", "<cmd>ene<CR>"),
      dashboard.button("q", "  Quit", "<cmd>qa<CR>"),
    }

    -- カラー設定
    vim.api.nvim_set_hl(0, "AlphaHeader", { fg = "#61AFEF" })       -- ヘッダー：青
    vim.api.nvim_set_hl(0, "AlphaButtons", { fg = "#98C379" })      -- ボタン：緑
    vim.api.nvim_set_hl(0, "AlphaShortcut", { fg = "#E5C07B" })     -- ショートカット：黄
    vim.api.nvim_set_hl(0, "AlphaFooter", { fg = "#C678DD" })       -- フッター：紫

    dashboard.section.header.opts.hl = "AlphaHeader"
    dashboard.section.buttons.opts.hl = "AlphaButtons"

    alpha.setup(dashboard.config)
  end,
}
