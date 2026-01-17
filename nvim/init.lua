-- 基本設定
vim.opt.number = true
vim.opt.relativenumber = true


vim.opt.termguicolors = true
vim.opt.clipboard = "unnamedplus"
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("state") .. "/undo"
vim.opt.undolevels = 10000
vim.g.mapleader = " "
require("keymaps")


if vim.env.SSH_TTY then
  vim.g.clipboard = {
    name = 'OSC 52',
    copy = {
      ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
      ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
    },
    paste = {
      ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
      ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
    },
  }
end

-- IME 自動オフ（挿入モード抜けた時）
if vim.fn.has("win32") == 1 then
  local zenhan = vim.fn.expand("~/bin/zenhan/bin64/zenhan.exe")
  vim.api.nvim_create_autocmd("InsertLeave", {
    callback = function()
      vim.fn.system(zenhan .. " 0")
    end,
  })
end

-- Terminal title for WezTerm tab name
vim.o.title = true
vim.o.titlestring = "Neovim"

-- csv.vim 設定
vim.g.csv_delim = ","
vim.g.csv_no_conceal = 1

-- lazy.nvim ブートストラップ
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- プラグイン読み込み
require("lazy").setup("plugins")

-- カラースキーム
vim.cmd.colorscheme("kanagawa")

-- 背景透過
local transparent_enabled = true

local function set_transparent()
  vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "NormalNC", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "NonText", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "MsgArea", { fg = "white" })
  vim.api.nvim_set_hl(0, "LineNr", { fg = "white" })
end

local function apply_transparency()
  if transparent_enabled then
    set_transparent()
  end
end

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = apply_transparency,
})
vim.defer_fn(apply_transparency, 10)

function _G.toggle_transparency()
  transparent_enabled = not transparent_enabled
  if transparent_enabled then
    apply_transparency()
  else
    vim.cmd.colorscheme("kanagawa")
  end
  vim.notify("Transparency: " .. (transparent_enabled and "on" or "off"))
end

