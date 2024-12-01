require("luasnip.session.snippet_collection").clear_snippets("html")

local ls = require("luasnip")

local s = ls.snippet
local i = ls.insert_node

local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("html", {
	s(
		"!!!",
		fmt(
			[[<html>
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>{}</title>
  </head>
  <body>
    <body>
      {}
    </body>
  </body>
</html>]],
			{ i(1), i(0) }
		)
	),
})
