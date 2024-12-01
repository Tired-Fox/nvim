require("luasnip.session.snippet_collection").clear_snippets("python")

local ls = require("luasnip")

local s = ls.snippet
local i = ls.insert_node

local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("python", {
	s("main", fmt('if __name__ == "__main__":\n    {}', { i(0) })),
})
