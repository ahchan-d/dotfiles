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

    dashboard.section.footer.val = "Loading plugins..."

    -- カラースキームのデフォルト配色を使用
    dashboard.section.header.opts.hl = "Type"
    dashboard.section.buttons.opts.hl = "String"
    dashboard.section.footer.opts.hl = "Comment"

    alpha.setup(dashboard.config)

    local function update_footer()
      local ok, lazy = pcall(require, "lazy")
      if not ok then
        return false
      end
      local stats = lazy.stats()
      local ms = math.floor(stats.startuptime * 100 + 0.5) / 100
      dashboard.section.footer.val = string.format(
        "Neovim loaded %d/%d plugins in %.2fms",
        stats.loaded,
        stats.count,
        ms
      )
      pcall(vim.cmd.AlphaRedraw)
      return true
    end

    vim.api.nvim_create_autocmd("User", {
      pattern = "LazyDone",
      callback = update_footer,
    })

    vim.defer_fn(function()
      if not update_footer() then
        vim.defer_fn(update_footer, 300)
      end
    end, 120)
  end,
}
