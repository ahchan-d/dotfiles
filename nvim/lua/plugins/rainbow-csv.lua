return {
  "cameron-wags/rainbow_csv.nvim",
  config = function()
    require("rainbow_csv").setup()

    local colors = {
      "#E06C75",  -- 赤
      "#98C379",  -- 緑
      "#61AFEF",  -- 青
      "#E5C07B",  -- 黄
      "#C678DD",  -- 紫
      "#56B6C2",  -- シアン
      "#FF9E64",  -- オレンジ
      "#FF79C6",  -- ピンク
      "#7DCFFF",  -- 水色
    }

    vim.api.nvim_create_autocmd("FileType", {
      pattern = {
        "csv",
        "tsv",
        "csv_semicolon",
        "csv_whitespace",
        "csv_pipe",
        "rfc_csv",
        "rfc_semicolon",
      },
      callback = function()
        for i = 0, 9 do
          vim.api.nvim_set_hl(0, "column" .. i, { fg = colors[i + 1] })
          vim.api.nvim_set_hl(0, "csvCol" .. i, { fg = colors[i + 1] })
        end
      end,
    })
  end,
  ft = {
    "csv",
    "tsv",
    "csv_semicolon",
    "csv_whitespace",
    "csv_pipe",
    "rfc_csv",
    "rfc_semicolon",
  },
  cmd = {
    "RainbowDelim",
    "RainbowDelimSimple",
    "RainbowDelimQuoted",
    "RainbowMultiDelim",
  },
}
