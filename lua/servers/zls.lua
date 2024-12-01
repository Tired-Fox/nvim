local utils = require("user.utils")
return {
	settings = {
		zls = {
			path = utils.path.expand("~/.zvm/bin/"),
			Zls = {
				path = utils.path.expand("~/.zvm/bin/"),
				enableAutofix = true,
				enable_snippets = true,
				enable_ast_check_diagnostics = true,
				enable_autofix = true,
				enable_import_embedfile_argument_completions = true,
				warn_style = true,
				enable_semantic_tokens = true,
				enable_inlay_hints = true,
				inlay_hints_hide_redundant_param_names = true,
				inlay_hints_hide_redundant_param_names_last_token = true,
				operator_completions = true,
				include_at_in_builtins = true,
				max_detail_length = 1048576,
			},
		},
	},
}
