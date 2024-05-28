require("luasnip.session.snippet_collection").clear_snippets("vue")

local ls = require("luasnip")

local s = ls.snippet
local i = ls.insert_node

local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("vue", {
	s("vF", fmt('<v-form v-slot="{{ {} }}">{}', { i(1), i(0) })),
	s("vf", fmt('<v-field v-slot="{{ {} }}">{}', { i(1), i(0) })),
})
