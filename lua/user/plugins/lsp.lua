return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"jay-babu/mason-nvim-dap.nvim",
			{
				"rcarriga/nvim-dap-ui",
				dependencies = {
					"nvim-neotest/nvim-nio",
				},
			},
		},
		cmd = { "DapContinue" },
		config = function()
			require("user.lsp.dap")
		end,
		keys = {
			{
				"<space>dt",
				function()
					require("dap").toggle_breakpoint()
				end,
				desc = "Toggle Breakpoint",
			},
			{
				"<space>db",
				function()
					require("dap").step_back()
				end,
				desc = "Step Back",
			},
			{
				"<space>dc",
				function()
					require("dap").continue()
				end,
				desc = "Continue Dap",
			},
			{
				"<space>dC",
				function()
					require("dap").run_to_cursor()
				end,
				desc = "Run To Cursor",
			},
			{
				"<space>dd",
				function()
					require("dap").disconnect()
				end,
				desc = "Disconnect Dap",
			},
			{
				"<space>dg",
				function()
					require("dap").session()
				end,
				desc = "Get Dap Session",
			},
			{
				"<space>di",
				function()
					require("dap").step_into()
				end,
				desc = "Step Into",
			},
			{
				"<space>do",
				function()
					require("dap").step_over()
				end,
				desc = "Step Over",
			},
			{
				"<space>du",
				function()
					require("dap").step_out()
				end,
				desc = "Step Out",
			},
			{
				"<space>dp",
				function()
					require("dap").pause()
				end,
				desc = "Pause Dap",
			},
			{
				"<space>dr",
				function()
					require("dapui").float_element("repl", { enter = true })
				end,
				desc = "Toggle Dap Repl",
			},
			{
				"<space>ds",
				function()
					require("dap").continue()
				end,
				desc = "Start Dap",
			},
			{
				"<space>dQ",
				function()
					require("dap").close()
				end,
				desc = "Quit Dap",
			},
			{
				"<space>dU",
				function()
					require("dapui").toggle({ reset = true })
				end,
				desc = "Toggle Dap UI",
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Better lua vim completions
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",

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
					"-Xms1g",
					"--add-modules=ALL-SYSTEM",
					"--add-opens",
					"java.base/java.util=ALL-UNNAMED",
					"--add-opens",
					"java.base/java.lang=ALL-UNNAMED",
					"-javaagent:" .. vim.fn.expand("$MASON/share/jdtls/lombok.jar"),
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
									path = "D:\\scoop\\apps\\openjdk8-redhat\\8u342-b07",
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
						format = {
							settings = {
								url = vim.fn.stdpath("config") .. "/Menards.xml",
							},
						},
						signatureHelp = { enabled = true },
						completion = {
							favoriteStaticMembers = {
								"org.hamcrest.MatcherAssert.assertThat",
								"org.hamcrest.Matchers.*",
								"org.hamcrest.CoreMatchers.*",
								"org.junit.jupiter.api.Assertions.*",
								"org.mockito.Mockito.*",
							},
							importOrder = {
								"java",
								"javax",
								"com",
								"de",
								"feign",
								"io",
								"lombok",
								"net",
								"nz",
								"okio",
								"okhttp3",
								"org",
								"reactor",
								"redis",
								"com.menards",
								"*",
							},
						},
						sources = {
							organizeImports = {
								starThreshold = 9999,
								staticStarThreshold = 9999,
							},
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
		cmd = "BufNew",
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
	},
	{
		"mrcjkb/rustaceanvim",
		version = "^4",
		lazy = false,
		init = function()
			local extension_path = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/"
			local codelldb_path = extension_path .. "adapter/codelldb"
			local liblldb_path = extension_path .. "lldb/lib/liblldb"
			local this_os = vim.loop.os_uname().sysname

			if this_os:find("Windows") then
				codelldb_path = extension_path .. "adapter\\codelldb.exe"
				liblldb_path = extension_path .. "lldb\\bin\\liblldb.dll"
			else
				liblldb_path = liblldb_path .. (this_os == "Linux" and ".so" or ".dylib")
			end

			local cfg = require("rustaceanvim.config")
			vim.g.rustaceanvim = {
				tools = {
					hover_actions = {
						replace_builtin_hover = true,
						auto_focus = false,
					},
					-- ref: api-win_config
					float_win_config = {
						border = "rounded",
					},
				},
				server = {
					settings = function(proj_root)
						local ra = require("rustaceanvim.config.server")
						return vim.tbl_deep_extend(
							"force",
							{
								["rust-analyzer"] = {
									cargo = {
										features = "all",
									},
									checkOnSave = {
										command = "clippy",
									},
								},
							},
							ra.load_rust_analyzer_settings(proj_root, {
								settings_file_pattern = "rust-analyzer.json",
							})
						)
					end,
				},
				dap = {
					adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
				},
			}
		end,
	},
	{
		"nvim-pack/nvim-spectre",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("spectre").setup({
				-- open_cmd = "vsplit",
			})

			vim.keymap.set("n", "<space>S", require("spectre").toggle, { desc = "Toggle Spectre" })
			vim.keymap.set("n", "<space>sw", function()
				require("spectre").open_visual({ select_word = true })
			end, {
				desc = "Search current word",
				buffer = true,
			})
			vim.keymap.set("v", "<space>sw", require("spectre").open_visual, {
				desc = "Search current word",
				buffer = true,
			})
			vim.keymap.set("n", "<space>sp", function()
				require("spectre").open_file_search({ select_word = true })
			end, {
				desc = "Search on current file",
				buffer = true,
			})
		end,
	},
	{
		"echasnovski/mini.ai",
		cmd = "BufNew",
		version = "*",
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		config = function()
			require("treesitter-context").setup({
				enable = false,
				max_lines = 4, -- max lines the window should span
				min_window_height = 0, -- min editor window height
				line_numbers = true, -- show line numbers
				multiline_threshold = 20, -- max lines for single context
				trim_scope = "outer", -- trim scope lines if max_lines is exceeded
				mode = "cursor", -- Line used to calc context
				seperator = nil, -- separator between context and content
				zindex = 20, -- zindex of the floating window
				on_attach = nil,
			})
		end,
	},
}
