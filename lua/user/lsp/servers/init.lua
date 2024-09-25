local get_filename = require("user").get_filename

local servers = {
	bashls = true,
	pyright = true,
	gopls = true,
	lua_ls = true,

	-- Needed for nvim-jdtls
	jdtls = true,
	lemminx = true,

	cssls = true,
	eslint = true,
	-- vuels = true,
	volar = true,
	ts_ls = true,
	jsonls = true,
	yamlls = true,
	clangd = true,
}

local tools = {
	stylua = true,
	codelldb = true,
	lua_ls = true,
	delve = true,
	lemminx = true,
	["java-debug-adapter"] = true,
	["java-test"] = true,
}

local dap = {
	javadbg = true,
	javatest = true,
}

local setup_no_install = {
	zls = true,
}

local exclude_setup = {
	"jdtls",
}

local server_configs = {}
--- Load in configs from other files and append to list of configs
for _, ft_path in ipairs(vim.api.nvim_get_runtime_file("lua/user/lsp/servers/*.lua", true)) do
	local name = get_filename(ft_path)

	-- Only load the config if the server is setup to be installed + configured
	if servers[name] and not vim.tbl_contains(exclude_setup, name) then
		local ok, config = pcall(require, "user.lsp.servers." .. name)
		if ok then
			server_configs[name] = config
		end
	end
end

--- Filter table returning a list of active keys
---
--- @param tbl table<string, boolean>
--- @return table<number, string>
local function filter_active(tbl)
	return vim.tbl_filter(function(key)
		--- @diagnostic disable-next-line: return-type-mismatch
		return tbl[key]
	end, vim.tbl_keys(tbl))
end

--- @class Servers
--- @field language_servers table<integer, string>
--- @field tools table<integer, string>
--- @field dap table<integer, string>
--- @field setup_no_install table<integer, string>
--- @field configs table<string, table>
--- @field exclude_setup table<integer, string>
return {
	language_servers = filter_active(servers),
	tools = filter_active(tools),
	dap = filter_active(dap),
	setup_no_install = filter_active(setup_no_install),
	configs = server_configs,
	exclude_setup = exclude_setup,
}
