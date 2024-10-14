local M = {
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
}

function M.config()
	local dap = require("dap")
	local dapui = require("dapui")

	--- @diagnostic disable: missing-fields
	dapui.setup({
		floating = {
			border = "rounded",
		},
		layouts = {
			{
				elements = {
					{
						id = "scopes",
						size = 0.25,
					},
					{
						id = "breakpoints",
						size = 0.25,
					},
					{
						id = "stacks",
						size = 0.25,
					},
					{
						id = "watches",
						size = 0.25,
					},
				},
				position = "left",
				size = 40,
			},
			{
				elements = {
					"repl",
				},
				position = "bottom",
				size = 0.25,
			},
		},
	})
	--- @diagnostic enable: missing-fields

	dap.listeners.before.attach.dapui_config = function()
		dapui.open()
	end

	dap.listeners.before.launch.dapui_config = function()
		dapui.open()
	end

	dap.listeners.before.event_terminated.dapui_config = function()
		dapui.close()
	end

	dap.listeners.before.event_exited.dapui_config = function()
		dapui.close()
	end

	dap.listeners.before.event_exited.dapui_stopped = function()
		vim.print("Terminated")
		dapui.close()
	end

	local sign = vim.fn.sign_define

	sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
	sign("DapBreakpointCondition", { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
	sign("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })
end

return M
