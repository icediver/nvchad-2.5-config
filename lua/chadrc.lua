-- This file  needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.ui = {
  theme = "onedark",
  transparency = true,
  telescope = {
    style = "bordered",
  }, -- borderless / bordered
  statusline = {
    theme = "default", -- default/vscode/vscode_colored/minimal
    separator_style = "arrow",
  },

  hl_override = {
    Comment = { italic = true, bg = "none", fg = "#059669" },
    ["@comment"] = { italic = true, bg = "none", fg = "#A8A29E", underline = true },
    DiffChange = {
      bg = "#464414",
      fg = "none",
    },
    DiffAdd = {
      bg = "#103507",
      fg = "none",
    },
    DiffRemoved = {
      bg = "#461414",
      fg = "none",
    },
    Visual = {
      bg = "#737373",
      fg = "none",
    },
    CursorLineNr = {
      bg = "#ffffff",
    },
    LineNr = {
      fg = "#a0a0a0",
      bg = "none",
    },
  },
}

return M
