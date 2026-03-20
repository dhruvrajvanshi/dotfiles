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
				css = {
					require("formatter.filetypes.css").prettier,
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
				zig = {
					require("formatter.filetypes.zig").zigfmt,
				},
			},
		})
		vim.keymap.set("n", "<leader>pp", ":Format<CR>")

		local enable_format_on_save = function()
			vim.api.nvim_create_augroup("__formatter__", { clear = true })
			vim.api.nvim_create_autocmd("BufWritePost", {
				group = "__formatter__",
				command = ":FormatWrite",
			})
		end
		local project_dir = vim.fn.getcwd()

		-- Auto enable format on save if we find known formatter config files in the project
		local patterns = { ".prettierrc", ".prettierignore" }
		for _, pattern in ipairs(patterns) do
			if vim.fn.filereadable(project_dir .. "/" .. pattern) == 1 then
				enable_format_on_save()
				return
			end
		end

		-- if not, check local.config/init.lua for format_on_save
		local config = require("localconfig")
		if config.format_on_save then
			enable_format_on_save()
		end
	end,
}
