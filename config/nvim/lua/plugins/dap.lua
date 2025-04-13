---@module "lazy"
---@type LazySpec
return {
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
		---@module "dapui"
		---@type dapui.Config
		---@diagnostic disable-next-line: missing-fields
		opts = {
			layouts = {
				{
					elements = {
						{ id = "scopes", size = 0.25 },
						{ id = "breakpoints", size = 0.25 },
						{ id = "stacks", size = 0.25 },
						{ id = "watches", size = 0.25 },
					},
					position = "left",
					size = 40,
				},
				{
					elements = {
						{ id = "repl", size = 0.5 },
						{ id = "console", size = 0.5 },
					},
					position = "bottom",
					size = 10,
				},
			},
		},
		init = function()
			local dap = require("dap")
			local dapui = require("dapui")
			vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Toggle Breakpoint" })
			vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
			vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue" })
			vim.keymap.set("n", "F5", dap.continue, { desc = "Continue" })
			vim.keymap.set("n", "<leader>dr", dap.repl.open, { desc = "Open REPL" })
			vim.keymap.set("n", "<leader>ds", dap.step_into, { desc = "Step Into" })
			vim.keymap.set("n", "F11", dap.step_into, { desc = "Step Into" })
			vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Step Over" })
			vim.keymap.set("n", "F10", dap.step_over, { desc = "Step Over" })
			vim.keymap.set("n", "<leader>dt", dap.step_out, { desc = "Step Out" })
			vim.keymap.set("n", "<leader>dh", dapui.eval, { desc = "Evaluate" })
			vim.keymap.set("n", "<leader>dl", dapui.float_element, { desc = "Float Element" })
		end,
	},
	{
		"julianolf/nvim-dap-lldb",
		dependencies = { "mfussenegger/nvim-dap" },
		opts = {},
		init = function()
			local dap = require("dap")
			dap.adapters.lldb = {
				type = "executable",
				name = "lldb",
			}
		end,
	},
}
