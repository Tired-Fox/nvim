local M = {
	"mfussenegger/nvim-jdtls",
}

local apps = {
	["menards.com"] = 6080,
	accountledgerexportprocessor = 6391,
	accountretrievalmanagementservice = 7088,
	admin = 6481,
	authorizationservice = 7682,
	bargainitemprocessor = 6381,
	buyingguideservice = 7181,
	cacheapp = 6483,
	categoryandsearchservice = 7182,
	checkout = 6181,
	checkoutservice = 7283,
	configurationmaintenance = 6485,
	contactusservice = 7081,
	contentservice = 7183,
	creditinceptionservice = 7082,
	customproductservice = 7381,
	dcinventoryconsumer = 6881,
	deliveryrateconsumer = 6882,
	dynamiccontentprocessor = 6383,
	ecomemailservice = 7083,
	ecomlocationservice = 7580,
	ecomstoreservice = 7581,
	featureadmin = 6385,
	forms = 6083,
	fraudpreventionservice = 7681,
	giftrecapemailprocessor = 6392,
	gimli = 7084,
	guestprojectservice = 7180,
	haulerconsumer = 6883,
	header = 4372,
	inventoryprocessor = 7181,
	inventoryservice = 7382,
	managedverbiageservice = 7184,
	mcom = 6080,
	orderarchiver = 6393,
	orderauthorizationservice = 7682,
	orderpenaltyprocessor = 6385,
	orderprocessor = 7780,
	orderservice = 7683,
	ordertrackerservice = 7086,
	packagingchargeservice = 7281,
	pickuporderpenaltyconsumer = 6884,
	plantlocationservice = 7383,
	poupdateconsumer = 6885,
	priceandstatusprocessor = 6281,
	productcalculatorservice = 7384,
	productdetailsservice = 7385,
	productfeedprocessor = 6386,
	productinformationconsumer = 6886,
	productlistservice = 7185,
	productlocationconsumer = 6889,
	promotionservice = 7481,
	publishservice = 7186,
	rayslistservice = 7582,
	rebateinternational = 6087,
	rebateinternationaladmin = 6485,
	rebateservice = 7482,
	receiptlookupservice = 7087,
	releaseapp = 6484,
	reportingemailprocessor = 6387,
	searchandsuggestservice = 7189,
	searchprocessor = 6282,
	servicecenterservice = 7583,
	shippingestimateservice = 7783,
	shippingservice = 7781,
	shoppingcartservice = 7282,
	shoppingcart = 6090,
	sitemapprocessor = 6388,
	skusearchservice = 7187,
	spoc = 7782,
	springcloudgateway = 1432,
	storedetails = 6086,
	storeinventoryconsumer = 6887,
	storeprocessor = 6389,
	storeverificationconsumer = 6888,
	typeaheadservice = 7188,
	urlshortener = 6084,
	variationprocessor = 6390,
	helloworlds = 6081,
	astronomyservice = 7182,
}

function M.config()
	-- local pickers = require 'telescope.pickers'
	-- local finders = require 'telescope.finders'
	-- local conf = require('telescope.config').values
	--
	-- local actions = require 'telescope.actions'
	-- local action_state = require 'telescope.actions.state'

	-- --- Pick a java runtime from jdtls and set it as the active runtime
	-- --- @reference: https://github.com/nvim-telescope/telescope.nvim/blob/master/developers.md#introduction
	-- function JavaRuntimes(opts)
	--   opts = opts or {}
	--   pickers
	--     .new(opts, {
	--       prompt_title = 'Java Runtimes',
	--       finder = finders.new_dynamic {
	--         entry_maker = opts.entry_maker or function(entry)
	--           local pretty = entry:gsub('-', ' '):gsub('SE', '')
	--           return {
	--             value = entry,
	--             display = pretty,
	--             ordinal = pretty,
	--           }
	--         end,
	--         fn = function()
	--           local runtimes = jdtls._complete_set_runtime()
	--           if type(runtimes) ~= 'table' then
	--             local _runtimes = {}
	--             for runtime in runtimes:gmatch '[^\r\n]+' do
	--               table.insert(_runtimes, runtime)
	--             end
	--             runtimes = _runtimes
	--           end
	--           return runtimes
	--         end,
	--       },
	--       sorter = conf.generic_sorter(opts),
	--       attach_mappings = function(prompt_bufnr)
	--         actions.select_default:replace(function()
	--           actions.close(prompt_bufnr)
	--           local selection = action_state.get_selected_entry()
	--           vim.notify('Setting jdtls java runtime to ' .. selection.value, vim.log.levels.INFO)
	--           jdtls.set_runtime(selection.value)
	--         end)
	--         return true
	--       end,
	--     })
	--     :find()
	-- end

	-- to execute the function
	-- JavaRuntimes(require("telescope.themes").get_dropdown({}))

	local ports = {}
	for name, port in pairs(apps) do
		ports[name] = {
			type = "java",
			request = "attach",
			name = "Debug Remote JVM (Attach: " .. port .. ")",
			hostName = "127.0.0.1",
			port = port,
		}
	end

	--- This assumes that nvim is only opening one project at a time and that
	--- the root of the project is current working directory
	local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
	if ports[project_name] ~= nil then
		local exists, dap = pcall(require, "dap")
		if exists then
			if dap.configurations.java == nil then
				dap.configurations.java = { ports[project_name] }
			else
				table.insert(dap.configurations.java, ports[project_name])
			end
		end
	end

	-- create autocmd to load main class configs on LspAttach.
	-- This ensures that the LSP is fully attached.
	-- See https://github.com/mfussenegger/nvim-jdtls#nvim-dap-configuration
	vim.api.nvim_create_autocmd("LspAttach", {
		pattern = "*.java",
		callback = function(args)
			vim.keymap.set("n", "goi", function()
				vim.lsp.buf.code_action({ context = { only = { "source.organizeImports" } }, apply = true })
			end, { buffer = 0, desc = "Organize Imports" })

			local client = vim.lsp.get_client_by_id(args.data.client_id)
			-- ensure that only the jdtls client is activated
			if client.name == "jdtls" then
				require("jdtls.dap").setup_dap_main_class_configs()
			end
		end,
	})
end

return M
