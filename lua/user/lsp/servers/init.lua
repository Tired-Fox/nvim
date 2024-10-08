local utils = require("user.utils")

--- @alias Array<T> { [integer]: T }

--- @class Servers
--- @field __config { [string]: table }
--- Get the list of langauge servers that are to be installed
--- @field install fun(self): Array<string>
--- Get the list of language servers that are to be configured/setup
--- along with their user defined configurations
--- @field setup fun(self): Array<[string, table]>

--- @class Tools
--- Get the tools that are to be installed with `mason-tool-installer`
--- @field install fun(self): Array<string>

--- Configuration setup for language servers, formatters, dap, etc...
--- @class LspConfig
--- @field servers Servers
--- @field tools Tools
--- @field setup fun(self)

--- @type LspConfig
--- @diagnostic disable: missing-fields
local config = {
	--- @type { [string]: boolean | "setup" | "install" }
	servers = {
		bashls = true,
		pyright = true,
		lua_ls = true,

		-- Needed for nvim-jdtls
		jdtls = "install",
		lemminx = true,

		cssls = true,
		eslint = true,
		volar = true,
		ts_ls = true,
		jsonls = true,
		yamlls = true,
		clangd = true,

		zls = "setup",
	},
	--- @type { [string]: boolean }
	tools = {
		stylua = true,
		codelldb = true,
		lua_ls = true,
		delve = true,
		lemminx = true,

		["java-debug-adapter"] = true,
		["java-test"] = true,

		javadbg = true,
		javatest = true,
	},
}

function config.servers:install()
	local to_install = {}
	for server, state in pairs(self) do
		if server ~= "__config" then
			if state == true then
				table.insert(to_install, server)
			elseif state == "install" then
				table.insert(to_install, server)
			end
		end
	end
	return to_install
end

function config.tools:install()
	local to_install = {}
	for server, state in pairs(self) do
		if state == true then
			table.insert(to_install, server)
		end
	end
	return to_install
end

local lspconfig = require("lspconfig")

local capabilities = nil
if pcall(require, "cmp_nvim_lsp") then
	capabilities = require("cmp_nvim_lsp").default_capabilities()
end

function config.servers:setup()
	for server, state in pairs(self) do
		if server ~= "__config" and (state == true or state == "setup") then
			local conf = {
				capabilities = capabilities,
			}

			if self.__config[server] then
				conf = vim.tbl_deep_extend("force", {}, conf, self.__config[server])
			end

			lspconfig[server].setup(conf)
		end
	end
end

--- Install and setup language servers, debuggers, formatters, etc...
---
--- **IMPORTANT**: Expects that `mason` has already been setup
function config:setup()
	-- install and setup configured servers and tools
	require("mason-tool-installer").setup({
		ensure_installed = utils.merge_lists(self.servers:install(), self.tools:install()),
	})
	self.servers:setup()
end

--- Load in configs from other files and append to list of configs
config.servers.__config = {}
for _, ft_path in ipairs(vim.api.nvim_get_runtime_file("lua/user/lsp/servers/*.lua", true)) do
	local name = utils.get_filename(ft_path)

	-- Only load the config if the server is setup to be installed + configured
	if config.servers[name] == true or config.servers[name] == "setup" then
		local ok, c = pcall(require, "user.lsp.servers." .. name)
		if ok then
			config.servers.__config[name] = c
		end
	end
end

return config
