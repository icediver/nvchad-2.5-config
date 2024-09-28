require "nvchad.options"

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
-- vim.g.lua_snippets_path = "~/.config/nvim/lua/snippets/luasnippets"
vim.g.lua_snippets_path = vim.fn.stdpath "config" .. "/lua/snippets/lua"
vim.g.vscode_snippets_path = vim.fn.stdpath "config" .. "/lua/snippets/"
-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!
