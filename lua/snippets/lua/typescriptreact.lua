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
local su = require "snippets.lua.common.snip_utils"
local nl = su.new_line
local te = su.trig_engine
local jt = su.join_text
local function page_name(_, parent)
  return sn(nil, i(1, su.dir_name(parent)))
end

return {
  s(
    {
      trig = "uss",
      name = "useState",
      dscr = "React hook useState with initial value",
      priority = 5000,
    },
    fmt("const [{}, set{setter}] = useState({})", {
      i(1, "state"),
      i(2, ""),
      setter = l(l._1:sub(1, 1):upper() .. l._1:sub(2, -1), 1),
    })
  ),
  s({ trig = "usc", descr = "useCallback(fn, inputs)", priority = 0, trigEngine = te "b" }, {
    t "const ",
    i(1, "callback", { key = "i1" }),
    t " = useCallback((",
    i(2, "", { key = "i2" }),
    t ")) => ",
    c(
      3,
      { { t "{", nl(), i(1, "", { key = "i4" }), t "\t${4}", nl() }, { i(1, jt { "{", "\n", "", "\t${4}", "\n" }) } },
      { key = "i3" }
    ),
    t ", [",
    i(4, "", { key = "i5" }),
    t "])",
  }),
  s({ trig = "usm", descr = '(useM) "useMemo(fn, inputs)"', priority = 0, trigEngine = te "b" }, {
    t "const ",
    i(1, "memorized", { key = "i1" }),
    t " = useMemo(() => ",
    c(
      2,
      { { t "{", nl(), i(1, "", { key = "i3" }), t "\t${3}", nl() }, { i(1, jt { "{", "\n", "", "\t${3}", "\n" }) } },
      { key = "i2" }
    ),
    t ", [",
    i(3, "", { key = "i4" }),
    t "])",
  }),
  s({ trig = "usr", descr = '(useR) "useRef(defaultValue)"', priority = 0, trigEngine = te "b" }, {
    t "const ",
    i(1, "ref", { key = "i1" }),
    t " = useRef(",
    i(2, "null", { key = "i2" }),
    t ")",
  }),
  s({ trig = "hook", descr = '(useR) "useRef(defaultValue)"', priority = 0, trigEngine = te "b" }, {
    t "const ",
    i(1, "ref", { key = "i1" }),
    t " = useRef(",
    i(2, "null", { key = "i2" }),
    t ")",
  }),
  s(
    "cl",
    fmt("className={}", {
      c(1, {
        { t "'", i(1), t "'" },
        { t "{", i(1), t "}" },
        { t "{clsx(", i(1), t ")}" },
        { t "{cn(", i(1), t ")}" },
      }),
    })
  ),
  s({
    trig = "pns",
    name = "Simple page",
    dscr = "Next.js simple page",
    priority = 5000,
  }, {
    t "export default function ",
    f(function(args, parent)
      return su.dir_name(parent)
    end),
    t " () {",
    nl(),
    t "return <div>",
    f(function(args, parent)
      return su.dir_name(parent)
    end),

    t "</div>",
    nl(),
    t "}",
  }),
  s(
    {
      trig = "ps",
      name = "Simple Nextjs page",
      dscr = "Next.js simple page",
      priority = 5000,
    },
    fmt(
      [[export default function {}Page ()  {{
          return <div>Page {}</div>
    }}
    ]],
      {
        d(1, page_name),
        rep(1),
      }
    )
  ),
  s(
    {
      trig = "psp",
      name = "Simple Nextjs page with id params",
      dscr = "Next.js simple page with id params",
      priority = 5000,
    },
    fmt(
      [[export default function {}Page({{
	params,
}}: {{
	params: {{ id: string }};
}}) {{
	return <div>{} Page</div>;
}}    ]],
      {
        d(1, page_name),
        rep(1),
      }
    )
  ),
}
