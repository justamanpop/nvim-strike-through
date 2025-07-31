--splits string with given seperator into table of strings
-- copied from  https://stackoverflow.com/questions/1426954/split-string-in-lua
local function stringSplit(ip, sep)
	local t = {}
	for str in string.gmatch(ip, "([^" .. sep .. "]+)") do
		table.insert(t, str)
	end
	return t
end

local function isVisualMode()
	local current_mode = vim.fn.mode()
	-- Visual modes are 'v' (character), 'V' (line), and '^V' (block)
	return current_mode:find("[vV\x16]") ~= nil
	-- \x16 is the ASCII code for Ctrl-V, which represents block visual mode
end

-- gets start and end position of visual selection. Since selection can be forward or backward,
-- finding which one comes first and returning that as start, the other as end here
local function getVStartAndEndPos()
	--getpos returns {buf, lno, col, off}, of which we care only about lno and col
	--lno and col are both 1 indexed
	local v_mark_1 = vim.fn.getpos(".")
	local v_mark_2 = vim.fn.getpos("v")

	-- if mark1's lno is lower than mark 2's , mark1 is the starting one
	if v_mark_1[2] < v_mark_2[2] then
		return v_mark_1, v_mark_2
	end

	-- vice versa of first condition
	if v_mark_1[2] > v_mark_2[2] then
		return v_mark_2, v_mark_1
	end

	-- same pair of checks, but now the lno values are equal, checking col value
	if v_mark_1[3] < v_mark_2[3] then
		return v_mark_1, v_mark_2
	end

	if v_mark_1[3] > v_mark_2[3] then
		return v_mark_2, v_mark_1
	end

	--both are at same spot
	return v_mark_1, v_mark_2
end

local toggleStrikeThroughVisual = function()
	if not isVisualMode then
		return
	end

	local v_start_pos, v_end_pos = getVStartAndEndPos()

	--the values from above are 1 indexed, but nvim_buf_get_text requires 0 indexed, so subbing 1
	local start_row = v_start_pos[2] - 1
	local end_row = v_end_pos[2] - 1

	local start_col = v_start_pos[3] - 1
	-- not subbing 1 since col indices are end exclusive in nvim_buf_get_text function
	local end_col = v_end_pos[3]

	-- returns table (array) of text, one per line
	local selected_text_lines = vim.api.nvim_buf_get_text(0, start_row, start_col, end_row, end_col, {})
	local selected_text = table.concat(selected_text_lines, "\n")

	local strike_through_char = "\xCC\xB6"
	local is_struck_through = string.find(selected_text, strike_through_char) ~= nil

	if is_struck_through then
		local no_strike_through_text = string.gsub(selected_text, strike_through_char, "")
		-- since set_text needs table of lines, have to split
		local no_strike_through_lines = stringSplit(no_strike_through_text, "\n")
		vim.api.nvim_buf_set_text(0, start_row, start_col, end_row, end_col + 2, no_strike_through_lines)
	else
		--replace each char with each char + strike through char, which gives strike out effect
		local strike_through_text = string.gsub(selected_text, ".", "%1" .. strike_through_char)
		local strike_through_lines = stringSplit(strike_through_text, "\n")
		vim.api.nvim_buf_set_text(0, start_row, start_col, end_row, end_col, strike_through_lines)
	end

	-- go back to normal mode after
	local keys = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
	vim.api.nvim_feedkeys(keys, "v", true)
end
vim.api.nvim_create_user_command("ToggleStrikeThroughVisual", toggleStrikeThroughVisual, {})
vim.keymap.set("v", "<leader>co", toggleStrikeThroughVisual)

local toggleStrikeThrough = function()
	local curr_line = vim.api.nvim_get_current_line()
	local strike_through_char = "\xCC\xB6"
	local is_struck_through = string.find(curr_line, strike_through_char) ~= nil

	if is_struck_through then
		local no_strike_through_line = string.gsub(curr_line, strike_through_char, "")
		vim.api.nvim_set_current_line(no_strike_through_line)
	else
		vim.cmd("s/./&̶/g")
		vim.cmd("nohl")
	end
end
vim.api.nvim_create_user_command("ToggleStrikeThrough", toggleStrikeThrough, {})
vim.keymap.set("n", "<leader>co", ":ToggleStrikeThrough<cr>")
