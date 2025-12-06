local previewers = require("telescope.previewers")
local pickers = require("telescope.pickers")
local sorters = require("telescope.sorters")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
-- https://community.ezlo.com/t/how-to-lua-script-to-extract-particular-data-value-from-string-variable-json-api-http-requests/220593
-- local logging = require "logging"
-- https://github.com/nvim-telescope/telescope.nvim/blob/master/developers.md
-- https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes#running-external-commands

vim.api.nvim_create_autocmd("User", {
	pattern = "TelescopePreviewerLoaded",
	callback = function(args)
		if args.data.filetype ~= "help" then
			vim.wo.number = true
		elseif args.data.bufname:match("*.csv") then
			vim.wo.wrap = false
		end
	end,
})

local function http()
	pickers.new({
		results_title = "Results",
		-- Run an external command and show the results in the finder window
		finder = finders.new_oneshot_job({ "rg", "http" }, {}),
		sorter = sorters.get_fuzzy_file(),
		previewer = previewers.new_buffer_previewer {
			define_preview = function(self, entry, status)
				local pattern = "http[s]?://[%w%-%/.:#_()]+"
				return require('telescope.previewers.utils').job_maker(
					{ "echo", string.match(entry.value, pattern) },
					self.state.bufnr,
					{
						-- callback = function(bufnr, content)
						-- 	if content ~= nil then
						-- 		-- require('telescope.previewers.utils').regex_highlighter(bufnr, 'xdg-open')
						-- 		vim.notify(content)
						-- 	end
						-- end,
					})
			end
		},
		attach_mappings = function(prompt_bufnr, map)
			actions.select_default:replace(function()
				actions.close(prompt_bufnr)
				local selected_entry = action_state.get_selected_entry()
			end)
			return true
		end,
	}, {}):find()
end


return require("telescope").register_extension {
	setup = function(extension_config, user_config)
	end,
	exports = {
		http = http
	},
}
