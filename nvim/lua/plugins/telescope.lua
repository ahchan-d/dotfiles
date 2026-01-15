return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = "Telescope",
  keys = {
    { "<leader>r", "<cmd>Telescope oldfiles<CR>", desc = "Recent files" },
    { "<leader>f", "<cmd>Telescope find_files<CR>", desc = "Find files" },
    { "<leader>g", "<cmd>Telescope live_grep<CR>", desc = "Grep" },
    { "<leader>b", "<cmd>Telescope buffers<CR>", desc = "Buffers" },
  },
  opts = {
    defaults = {
      mappings = {
        --i = {  -- インサートモード
        --  ["<F13>"] = "close",
        --},
        n = {  -- ノーマルモード
          ["<F12>"] = "close",
        },
      },
    },
  },
}
