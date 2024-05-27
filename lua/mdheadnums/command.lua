local mdheadnums = require("mdheadnums")

local commands = {
	add = mdheadnums.add_heading_numbers,
	remove = mdheadnums.remove_heading_numbers,
}

local M = {}

function M.setup()
	vim.api.nvim_create_user_command("MDHeading", function(args)
		if commands[args.args] then
			commands[args.args]()
		else
			print("Invalid command. Use 'add' or 'remove'.")
		end
	end, {
		nargs = 1,
	})
end

return M
