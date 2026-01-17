return {
  "chrisbra/csv.vim",
  config = function()
    local colors = {
      "#E06C75", -- 赤
      "#98C379", -- 緑
      "#61AFEF", -- 青
      "#E5C07B", -- 黄
    }

    local function apply_csv_colors()
      vim.api.nvim_set_hl(0, "CSVColumnOdd", { fg = colors[1] })
      vim.api.nvim_set_hl(0, "CSVColumnEven", { fg = colors[2] })
      vim.api.nvim_set_hl(0, "CSVColumnHeaderOdd", { fg = colors[3], bold = true })
      vim.api.nvim_set_hl(0, "CSVColumnHeaderEven", { fg = colors[4], bold = true })
    end

    apply_csv_colors()
    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "*",
      callback = apply_csv_colors,
    })

    -- セルの境界を取得（クォート対応）
    local function get_cell_range()
      local line = vim.api.nvim_get_current_line()
      local col = vim.fn.col(".")
      local cell_start = 1
      local cell_end = #line
      local in_quote = false

      for i = 1, col do
        local c = line:sub(i, i)
        if c == '"' then in_quote = not in_quote end
        if c == "," and not in_quote and i < col then
          cell_start = i + 1
        end
      end

      in_quote = false
      for i = 1, #line do
        local c = line:sub(i, i)
        if c == '"' then in_quote = not in_quote end
        if c == "," and not in_quote and i >= col then
          cell_end = i - 1
          break
        end
      end

      return cell_start, cell_end
    end

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "csv",
      callback = function()
        -- セル削除 (dc)
        vim.keymap.set("n", "dc", function()
          local line = vim.api.nvim_get_current_line()
          local cell_start, cell_end = get_cell_range()
          local before = line:sub(1, cell_start - 1)
          local after = line:sub(cell_end + 1)
          vim.api.nvim_set_current_line(before .. after)
          vim.fn.cursor(0, math.max(1, cell_start))
        end, { buffer = true, silent = true, desc = "Delete CSV cell" })

        -- セル置換 (rc)
        vim.keymap.set("n", "rc", function()
          local line = vim.api.nvim_get_current_line()
          local cell_start, cell_end = get_cell_range()
          local paste = vim.fn.getreg('+'):gsub("\n", "")  -- OSクリップボード
          local before = line:sub(1, cell_start - 1)
          local after = line:sub(cell_end + 1)
          vim.api.nvim_set_current_line(before .. paste .. after)
          vim.fn.cursor(0, cell_start)
        end, { buffer = true, silent = true, desc = "Replace CSV cell" })

        -- セルヤンク (yc)
        vim.keymap.set("n", "yc", function()
          local line = vim.api.nvim_get_current_line()
          local cell_start, cell_end = get_cell_range()
          local content = line:sub(cell_start, cell_end)
          vim.fn.setreg('"', content)
          vim.notify("Yanked: " .. content)
        end, { buffer = true, silent = true, desc = "Yank CSV cell" })
      end,
    })
  end,
}
