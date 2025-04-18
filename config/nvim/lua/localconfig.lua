local config = {
	format_on_save = false,
}

-- check if cwd/local.nvim exists
local local_config_path = vim.fn.getcwd() .. "/local.nvim/init.lua"
if vim.fn.filereadable(local_config_path) == 1 then
	local local_config = dofile(local_config_path)
	config = vim.tbl_deep_extend("force", config, local_config)
end

return config
