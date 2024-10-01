local ls = require "luasnip"
local c = ls.choice_node
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep
local l = require("luasnip.extras").lambda
local treesitter_postfix = require("luasnip.extras.treesitter_postfix").treesitter_postfix
local postfix = require("luasnip.extras.postfix").postfix

local date = function()
  return { os.date "%Y-%m-%d" }
end

return {
  s("!cc", {
    t "//----------------------------------------------------------------------------------------------------------------------",
  }),
  postfix({ trig = ".log", priority = 5000 }, {
    f(function(_, parent)
      return "console.log(" .. parent.snippet.env.POSTFIX_MATCH .. ")"
    end, {}),
  }),
  postfix({ trig = ".clg", priority = 5000 }, {
    f(function(_, parent)
      return "console.log(" .. parent.snippet.env.POSTFIX_MATCH .. ")"
    end, {}),
  }),
  s({
    trig = "date",
    namr = "Date",
    dscr = "Date in the form of YYYY-MM-DD",
  }, {
    f(date, {}),
  }),
  s(
    "custom_env",

    d(1, function(args, parent)
      local env = parent.snippet.env
      return sn(
        nil,
        t {
          -- "TM_SELECTED_TEXT: " .. env.TM_SELECTED_TEXT,
          -- "VISUAL: " .. env.VISUAL,
          -- "CLIPBOARD: " .. env.CLIPBOARD,
          "TM_CURRENT_LINE: " .. env.TM_CURRENT_LINE,
          "TM_CURRENT_WORD: " .. env.TM_CURRENT_WORD,
          "TM_LINE_INDEX: " .. env.TM_LINE_INDEX,
          "TM_LINE_NUMBER: " .. env.TM_LINE_NUMBER,
          "TM_FILENAME: " .. env.TM_FILENAME,
          "TM_FILENAME_BASE: " .. env.TM_FILENAME_BASE,
          "TM_DIRECTORY: " .. env.TM_DIRECTORY,
          "TM_FILEPATH: " .. env.TM_FILEPATH,
          "WORKSPACE_NAME: " .. env.WORKSPACE_NAME,
          "WORKSPACE_FOLDER: " .. env.WORKSPACE_FOLDER,
          "CURRENT_YEAR: " .. env.CURRENT_YEAR,
          "CURRENT_YEAR_SHORT: " .. env.CURRENT_YEAR_SHORT,
          "CURRENT_MONTH: " .. env.CURRENT_MONTH,
          "CURRENT_MONTH_NAME: " .. env.CURRENT_MONTH_NAME,
          "CURRENT_MONTH_NAME_SHORT: " .. env.CURRENT_MONTH_NAME_SHORT,
          "CURRENT_DATE: " .. env.CURRENT_DATE,
          "CURRENT_DAY_NAME: " .. env.CURRENT_DAY_NAME,
          "CURRENT_DAY_NAME_SHORT: " .. env.CURRENT_DAY_NAME_SHORT,
          "CURRENT_HOUR: " .. env.CURRENT_HOUR,
          "CURRENT_MINUTE: " .. env.CURRENT_MINUTE,
          "CURRENT_SECOND: " .. env.CURRENT_SECOND,
          "CURRENT_SECONDS_UNIX: " .. env.CURRENT_SECONDS_UNIX,
          "RANDOM: " .. env.RANDOM,
          "RANDOM_HEX: " .. env.RANDOM_HEX,
          "UUID: " .. env.UUID,
          "BLOCK_COMMENT_START: " .. env.BLOCK_COMMENT_START,
          "BLOCK_COMMENT_END: " .. env.BLOCK_COMMENT_END,
          "LINE_COMMENT: " .. env.LINE_COMMENT,
        }
      )
    end, {})
  ),
  s(
    "logc",
    fmt([[Debug.Log($"<color={}>{}</color>");]], {
      c(1, {
        t "red",
        t "green",
        t "blue",
        t "cyan",
        t "magenta",
      }),
      i(2),
    })
  ),
  s("co", {
    t "position([",
    f(function()
      local register_data = vim.fn.getreg() .. ""
      if string.match(register_data, "[%d-]+,%s*[%d-]+") then
        return register_data
      else
        print "register does not contain the pattern"
      end
    end),
    t "])",
  }),
  s("com", {
    d(function()
      local register_data = vim.fn.getreg() .. ""
      if string.match(register_data, "[%d-]+,%s*[%d-]+") then
        return sn(nil, {
          t("position([" .. register_data .. "])"),
        })
      else
        print "register does not contain the pattern"
        return sn(nil, {})
      end
    end),
    i(1),
  }),
}
