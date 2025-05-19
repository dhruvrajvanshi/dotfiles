return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
	},
	init = function()
		vim.keymap.set("n", "<leader>b", "<cmd>Neotree toggle<cr>", { desc = "Toggle NeoTree" })
		vim.keymap.set("n", "<C-S-B>", "<cmd>Neotree toggle<cr>", { desc = "Toggle NeoTree" })
	end,
}
