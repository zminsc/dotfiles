-- remove comment on newline
vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()
		vim.opt_local.formatoptions:remove({ "c", "r", "o" })
	end,
})

-- quit Snacks explorer if it is the only window left
-- credit: https://karn.work/blog/2025/2025-03-30-quit_neovim_when_window_is_last_and_snacks_explorer_still_open
vim.api.nvim_create_autocmd("QuitPre", {
	callback = function()
		local snacks_windows = {}
		local floating_windows = {}
		local windows = vim.api.nvim_list_wins()
		for _, w in ipairs(windows) do
			local filetype = vim.api.nvim_get_option_value("filetype", { buf = vim.api.nvim_win_get_buf(w) })
			if filetype:match("snacks_") ~= nil then
				table.insert(snacks_windows, w)
			elseif vim.api.nvim_win_get_config(w).relative ~= "" then
				table.insert(floating_windows, w)
			end
		end
		if 1 == #windows - #floating_windows - #snacks_windows then
			-- Should quit, so we close all Snacks windows.
			for _, w in ipairs(snacks_windows) do
				vim.api.nvim_win_close(w, true)
			end
		end
	end,
})
