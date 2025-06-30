-- This is our module table
local M = {}

-- We place our function inside the module table
function M.copy_all_to_clipboard()
	local all_lines = {}
	local file_count = 0

	for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_is_loaded(bufnr) and vim.bo[bufnr].buflisted then
			local bufname = vim.api.nvim_buf_get_name(bufnr)
			if bufname and bufname ~= "" then
				file_count = file_count + 1
				table.insert(all_lines, ("--- START: %s ---"):format(bufname))
				table.insert(all_lines, "")

				local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
				for _, line in ipairs(lines) do
					table.insert(all_lines, line)
				end

				table.insert(all_lines, "")
				table.insert(all_lines, ("--- END: %s ---"):format(bufname))
				table.insert(all_lines, "")
				table.insert(all_lines, "")
			end
		end
	end

	if file_count > 0 then
		vim.fn.setreg("+", all_lines)
		vim.notify("Copied content of " .. file_count .. " buffer(s) to clipboard.", vim.log.levels.INFO)
	else
		vim.notify("No file buffers found to copy.", vim.log.levels.WARN)
	end
end

-- We return the module table so other files can use it
return M
