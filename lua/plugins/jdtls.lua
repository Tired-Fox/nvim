local M = {
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
								path = os.getenv("SCOOP") .. "\\apps\\openjdk8-redhat\\current",
								default = true,
							},
							{
								name = "JavaSE-21",
								path = os.getenv("SCOOP") .. "\\apps\\oraclejdk-lts\\current",
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
		local pickers = require("telescope.pickers")
		local finders = require("telescope.finders")
		local conf = require("telescope.config").values

		local actions = require("telescope.actions")
		local action_state = require("telescope.actions.state")

		local jdtls = require("jdtls")

		--- Pick a java runtime from jdtls and set it as the active runtime
		--- @reference: https://github.com/nvim-telescope/telescope.nvim/blob/master/developers.md#introduction
		function JavaRuntimes(opts)
			opts = opts or {}
			pickers
				.new(opts, {
					prompt_title = "Java Runtimes",
					finder = finders.new_dynamic({
						entry_maker = opts.entry_maker or function(entry)
							local pretty = entry:gsub("-", " "):gsub("SE", "")
							return {
								value = entry,
								display = pretty,
								ordinal = pretty,
							}
						end,
						fn = function()
							local runtimes = jdtls._complete_set_runtime()
							if type(runtimes) ~= "table" then
								local _runtimes = {}
								for runtime in runtimes:gmatch("[^\r\n]+") do
									table.insert(_runtimes, runtime)
								end
								runtimes = _runtimes
							end
							return runtimes
						end,
					}),
					sorter = conf.generic_sorter(opts),
					attach_mappings = function(prompt_bufnr)
						actions.select_default:replace(function()
							actions.close(prompt_bufnr)
							local selection = action_state.get_selected_entry()
							vim.notify("Setting jdtls java runtime to " .. selection.value, vim.log.levels.INFO)
							jdtls.set_runtime(selection.value)
						end)
						return true
					end,
				})
				:find()
		end

		-- to execute the function
		-- JavaRuntimes(require("telescope.themes").get_dropdown({}))

		local overrides = {
			-- This puts the java arguments in an arguments file: Only for java versions 9+
			-- shortenCommandLine = "argfile",
			-- This creates a jar manifest that contains the classpath and java arguments works with most if not all  java versions
			shortenCommandLine = "jarmanifest",
		}

		vim.api.nvim_create_autocmd("LspAttach", {
			pattern = "*.java",
			callback = function()
				vim.keymap.set("n", "<space>tm", function()
					vim.print("Testing nearest test method")
					jdtls.test_nearest_method({
						config_overrides = overrides,
					})
				end, { buffer = 0, desc = "Test nearest method" })
				vim.keymap.set("n", "<space>tc", function()
					vim.print("Testing entire test class")
					jdtls.test_class({
						config_overrides = overrides,
					})
				end, { buffer = 0, desc = "Test class" })
			end,
		})

		local ports = {}
		local ports_ok, dap_config_java = pcall(require, "user.java_ports")
		if ports_ok then
			for name, port in pairs(dap_config_java) do
				ports[name] = {
					type = "java",
					request = "attach",
					name = "Debug Remote JVM (Attach: " .. port .. ")",
					hostName = "127.0.0.1",
					port = port,
				}
			end
		else
			vim.notify("Could not load ports.lua for dap java remote ports", vim.log.levels.ERROR)
		end

		-- Remove the quit mapping as it breaks remote debugging
		vim.keymap.del("n", "<space>dQ")

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
}

return M
