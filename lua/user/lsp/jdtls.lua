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
					local runtimes = require("jdtls")._complete_set_runtime()
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
					require("jdtls").set_runtime(selection.value)
				end)
				return true
			end,
		})
		:find()
end

-- to execute the function
-- JavaRuntimes(require("telescope.themes").get_dropdown({}))

vim.api.nvim_create_autocmd("LspAttach", {
	pattern = "*.java",
	callback = function()
		vim.keymap.set("n", "<space>tm", function()
			jdtls.test_nearest_method()
		end, { buffer = 0, desc = "Test nearest method" })
		vim.keymap.set("n", "<space>tc", function()
			jdtls.test_class()
		end, { buffer = 0, desc = "Test class" })
	end,
})

local dap_config_java = {}

local ports_ok, ports = pcall(require, "user.lsp.java_ports")
if ports_ok then
	for name, port in pairs(ports) do
		dap_config_java[name] = {
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

return dap_config_java
