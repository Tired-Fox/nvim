return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Better lua vim completions
			"folke/neodev.nvim",
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"mfussenegger/nvim-dap",
			{
				"rcarriga/nvim-dap-ui",
				dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
			},
			"jay-babu/mason-nvim-dap.nvim",

			-- Display lsp logs in fancy output at bottom right
			{ "j-hui/fidget.nvim", opts = {} },

			-- Autoformatting
			"stevearc/conform.nvim",

			-- Schema information
			"b0o/SchemaStore.nvim",
		},
		config = function()
			require("user.lsp")
		end,
	},
	{
		"mfussenegger/nvim-jdtls",
		ft = { "java" },
		dependencies = {
			"telescope",
			"williamboman/mason-lspconfig.nvim",
		},
		--- @reference: https://github.com/AstroNvim/astrocommunity/blob/main/lua/astrocommunity/pack/java/init.lua
		opts = function(_, opts)
			-- use this function notation to build some variables
			local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle", ".project" }
			local root_dir = require("jdtls.setup").find_root(root_markers)
			-- calculate workspace dir
			local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
			local workspace_dir = vim.fn.stdpath("data") .. "/site/java/workspace-root/" .. project_name
			vim.fn.mkdir(workspace_dir, "p")

			-- validate operating system
			if not (vim.fn.has("mac") == 1 or vim.fn.has("unix") == 1 or vim.fn.has("win32") == 1) then
				vim.notify("jdtls: Could not detect valid OS", vim.log.levels.ERROR)
			end

			return vim.tbl_extend("force", {
				cmd = {
					"java",
					"-Declipse.application=org.eclipse.jdt.ls.core.id1",
					"-Dosgi.bundles.defaultStartLevel=4",
					"-Declipse.product=org.eclipse.jdt.ls.core.product",
					"-Dlog.protocol=true",
					"-Dlog.level=ALL",
					"-javaagent:" .. vim.fn.expand("$MASON/share/jdtls/lombok.jar"),
					"-Xms1g",
					"--add-modules=ALL-SYSTEM",
					"--add-opens",
					"java.base/java.util=ALL-UNNAMED",
					"--add-opens",
					"java.base/java.lang=ALL-UNNAMED",
					"-jar",
					vim.fn.expand("$MASON/share/jdtls/plugins/org.eclipse.equinox.launcher.jar"),
					"-configuration",
					vim.fn.expand("$MASON/share/jdtls/config"),
					"-data",
					workspace_dir,
				},
				root_dir = root_dir,
				settings = {
					java = {
						eclipse = { downloadSources = true },
						configuration = {
							updateBuildConfiguration = "interactive",
							runtimes = {
								{
									name = "JavaSE-1.8",
									path = "C:\\Java\\jdk-8u161",
									default = true,
								},
								{
									name = "JavaSE-21",
									path = "D:\\scoop\\apps\\oraclejdk-lts\\21.0.2",
								},
							},
						},
						maven = { downloadSources = true },
						implementationsCodeLens = { enabled = true },
						referencesCodeLens = { enabled = true },
						inlayHints = { parameterNames = { enabled = "all" } },
					},
					signatureHelp = { enabled = true },
					completion = {
						favoriteStaticMembers = {
							"org.hamcrest.MatcherAssert.assertThat",
							"org.hamcrest.Matchers.*",
							"org.hamcrest.CoreMatchers.*",
							"org.junit.jupiter.api.Assertions.*",
							"java.util.Objects.requireNonNull",
							"java.util.Objects.requireNonNullElse",
							"org.mockito.Mockito.*",
						},
					},
					sources = {
						organizeImports = {
							starThreshold = 9999,
							staticStarThreshold = 9999,
						},
					},
				},
				init_options = {
					bundles = {
						vim.fn.expand("$MASON/share/java-debug-adapter/com.microsoft.java.debug.plugin.jar"),
						-- unpack remaining bundles
						(table.unpack or unpack)(vim.split(vim.fn.glob("$MASON/share/java-test/*.jar"), "\n", {})),
					},
				},
				handlers = {
					["$/progress"] = function() end, -- disable progress updates.
				},
				filetypes = { "java" },
				on_attach = function(...)
					require("jdtls").setup_dap({ hotcodereplace = "auto" })
				end,
			}, opts)
		end,
		config = function(_, opts)
			local ports = require("user.lsp.jdtls")
			local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

			if ports[project_name] ~= nil then
				local dap = require("dap")
				if dap.configurations.java == nil then
					dap.configurations.java = { ports[project_name] }
				else
					table.insert(dap.configurations.java, ports[project_name])
				end
			end

			-- setup autocmd on filetype detect java
			vim.api.nvim_create_autocmd("Filetype", {
				pattern = "java", -- autocmd to start jdtls
				callback = function()
					if opts.root_dir and opts.root_dir ~= "" then
						require("jdtls").start_or_attach(opts)
					else
						vim.notify("jdtls: root_dir not found. Please specify a root marker", vim.log.levels.ERROR)
					end
				end,
			})
			-- create autocmd to load main class configs on LspAttach.
			-- This ensures that the LSP is fully attached.
			-- See https://github.com/mfussenegger/nvim-jdtls#nvim-dap-configuration
			vim.api.nvim_create_autocmd("LspAttach", {
				pattern = "*.java",
				callback = function(args)
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					-- ensure that only the jdtls client is activated
					if client.name == "jdtls" then
						require("jdtls.dap").setup_dap_main_class_configs()
					end
				end,
			})
		end,
	},
	{
		"numToStr/Comment.nvim",
		dependencies = {
			"JoosepAlviste/nvim-ts-context-commentstring",
		},
		config = function()
			require("Comment").setup({
				pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
				---Enable keybindings
				---NOTE: If given `false` then the plugin won't create any mappings
				mappings = {
					---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
					basic = true,
					---Extra mapping; `gco`, `gcO`, `gcA`
					extra = true,
				},
			})
		end,
		lazy = false,
	},
	{
		"mrcjkb/rustaceanvim",
		version = "^4",
		lazy = false,
	},
}
