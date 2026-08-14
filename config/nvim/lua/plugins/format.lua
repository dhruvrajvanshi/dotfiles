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

		local project_dir = vim.fs.normalize(vim.fn.getcwd())
		local patterns = { ".prettierrc", ".prettierignore", ".clang-format" }

		local has_formatter_config = function(bufnr)
			local buffer_name = vim.api.nvim_buf_get_name(bufnr)
			if buffer_name == "" then
				return false
			end

			local buffer_dir = vim.fs.dirname(vim.fs.normalize(buffer_name))
			if not vim.fs.relpath(project_dir, buffer_dir) then
				return false
			end

			-- Search from the buffer up to and including the project root.
			local dir = buffer_dir
			while dir do
				for _, pattern in ipairs(patterns) do
					if vim.fn.filereadable(vim.fs.joinpath(dir, pattern)) == 1 then
						return true
					end
				end

				if dir == project_dir then
					break
				end
				local parent = vim.fs.dirname(dir)
				if parent == dir then
					break
				end
				dir = parent
			end

			return false
		end

		local config = require("localconfig")
		vim.api.nvim_create_augroup("__formatter__", { clear = true })
		vim.api.nvim_create_autocmd("BufWritePost", {
			group = "__formatter__",
			callback = function(args)
				if config.format_on_save or has_formatter_config(args.buf) then
					vim.cmd("FormatWrite")
				end
			end,
		})
	end,
}
