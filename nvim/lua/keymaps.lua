-- Key mappings (centralized)

vim.keymap.set("n", "<leader>ub", function()
  _G.toggle_transparency()
end, { silent = true, desc = "UI: Toggle background transparency" })

-- F13 を Esc として使う
vim.keymap.set({ "n", "i", "v", "s" }, "<F12>", "<Esc>", { silent = true })

-- nvim-tree
vim.keymap.set("n", "<leader>tt", "<cmd>NvimTreeToggle<CR>", { desc = "Tree: Toggle" })
vim.keymap.set("n", "<leader>tF", "<cmd>NvimTreeFocus<CR>", { desc = "Tree: Focus" })
vim.keymap.set("n", "<leader>tf", "<cmd>NvimTreeFindFile<CR>", { desc = "Tree: Find file" })
vim.keymap.set("n", "<leader>tr", "<cmd>NvimTreeRefresh<CR>", { desc = "Tree: Refresh" })
vim.keymap.set("n", "<leader>tc", "<cmd>NvimTreeCollapse<CR>", { desc = "Tree: Collapse" })
vim.keymap.set("n", "<leader>to", "<cmd>NvimTreeOpen<CR>", { desc = "Tree: Open" })
vim.keymap.set("n", "<leader>tq", "<cmd>NvimTreeClose<CR>", { desc = "Tree: Close" })

-- Window resize (Alt+h/l)
vim.keymap.set("n", "<M-h>", "<cmd>vertical resize -2<CR>", { desc = "Window: Shrink width" })
vim.keymap.set("n", "<M-l>", "<cmd>vertical resize +2<CR>", { desc = "Window: Grow width" })

-- Copilot
vim.keymap.set("i", "<Tab>", function()
  local ok, suggestion = pcall(require, "copilot.suggestion")
  if ok and suggestion.is_visible() then
    suggestion.accept()
  else
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
  end
end, { desc = "Copilot: Accept suggestion or Tab" })
