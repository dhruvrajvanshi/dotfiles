---@module "lazy"
---@type LazySpec
return {
	-- Show git changes in the gutter
	{
		"lewis6991/gitsigns.nvim",
		opts = {},
	},
	{ "tpope/vim-fugitive" },
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"sindrets/diffview.nvim", -- optional - Diff integration
		},
		config = true,
	},
}
