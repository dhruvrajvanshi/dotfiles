---@module "lazy"
---@type LazySpec
return {
	"mhartington/formatter.nvim",
	init = function()
		require("formatter").setup({
			filetype = {
				javascript = {
					require("formatter.filetypes.javascript").prettier,
				},
				javascriptreact = {
					require("formatter.filetypes.javascript").prettier,
				},
				typescript = {
					require("formatter.filetypes.javascript").prettier,
				},
				typescriptreact = {
					require("formatter.filetypes.javascript").prettier,
				},
				lua = {
					require("formatter.filetypes.lua").stylua,
				},
				rust = {
					require("formatter.filetypes.rust").rustfmt,
				},
				toml = {
					require("formatter.filetypes.toml").taplo,
				},
				c = {
					require("formatter.filetypes.c").clangformat,
				},
				cpp = {
					require("formatter.filetypes.c").clangformat,
				},
			},
		})
		vim.keymap.set("n", "<leader>pp", ":Format<CR>")
		local config = require("localconfig")

		if config.format_on_save then
			vim.api.nvim_create_augroup("__formatter__", { clear = true })
			vim.api.nvim_create_autocmd("BufWritePost", {
				group = "__formatter__",
				command = ":FormatWrite",
			})
		end
	end,
}
