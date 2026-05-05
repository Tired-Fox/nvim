return {
    "MeanderingProgrammer/render-markdown.nvim",
	opts = {
		file_types = { "markdown" },
		-- render_modes = { 'n', 'c', 't' },
		render_modes = true,
		completions = { blink = { enabled = true } },
		injections = {
			gitcommit = {
				enabled = true,
				query = [[
                ((message) @injection.content
                    (#set! injection.combined)
                    (#set! injection.include-children)
                    (#set! injection.language "markdown"))
            ]],
			},
		},
	},
}
