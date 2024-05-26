local commands = {
	add = require("mdheadnums").add_heading_numbers,
	remove = require("mdheadnums").remove_heading_numbers,
}

local M = {}

function M.setup()
	vim.api.nvim_create_user_command("MDHeading", function(args)
		if commands[args.args] then
			commands[args.args]()
		end
	end, {
		nargs = 1,
		complete = function()
			return { "add", "remove" }
		end,
	})
end

return M
