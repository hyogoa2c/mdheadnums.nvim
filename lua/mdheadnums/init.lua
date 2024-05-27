local M = {}

function M.add_heading_numbers(start_level, end_level)
	-- デフォルト値の設定
	start_level = start_level or 2
	end_level = end_level or 4

	-- 現在のバッファの内容を取得
	local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
	local numbers = {}
	for i = start_level, end_level do
		table.insert(numbers, 0)
	end

	-- 各行を解析
	for i, line in ipairs(lines) do
		local level = line:match("^(#+)")
		if level then
			level = #level
			-- 指定されたレベル範囲内での番号
			if level >= start_level and level <= end_level then
				numbers[level - start_level + 1] = numbers[level - start_level + 1] + 1

				-- 現在のレベルより高いレベルの番号をリセット
				for j = level - start_level + 2, #numbers do
					numbers[j] = 0
				end

				-- 番号文字列を生成
				local number_str = table.concat(numbers, ".", 1, level - start_level + 1)
				-- 行を書き換え
				lines[i] = line:gsub("^(#+)%s*", "%1 " .. number_str .. ". ")
			end
		end
	end

	-- 変更された内容をバッファに戻す
	vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
end

function M.remove_heading_numbers()
	-- 現在のバッファの内容を取得
	local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

	-- 各行を解析し、ヘッダから番号を削除
	for i, line in ipairs(lines) do
		repeat
			local old_line = line
			line = line:gsub("^(#+)%s*%d+%.%s*", "%1 ")
		until line == old_line -- 変更がなくなるまで繰り返し
		lines[i] = line
	end

	-- 変更された内容をバッファに戻す
	vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
end

function M.setup()
	require("mdheadnums.command").setup()
end

return M
