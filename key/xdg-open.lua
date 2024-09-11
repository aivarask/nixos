local wk = require "which-key"


local p = [[!nix eval nixos\#nixosConfigurations.]]

local nixpkgs = [[!nix eval nixpkgs\#]]
local hostname = vim.uv.os_gethostname()
local w = function() return vim.fn.expand "<cword>" end
string.xdg_open = function(v) vim.cmd("!xdg-open " .. v) end
wk.add {
	{ "<leader>g",  group = "xdg-open", },
	{ "<leader>gd", function() vim.cmd(nixpkgs .. w() .. ".meta.description | xargs notify-send") end,              desc = "nixpkgs.<cword>.description", },
	{ "<leader>gD", function() vim.cmd(nixpkgs .. w() .. ".meta.longDescription --raw | xargs -0 notify-send") end, desc = "nixpkgs.<cword>.longDescription", },
	{ "<leader>gh", function()
		local cmd = nixpkgs .. 'git' .. [[.meta.homepage | xdg-open]]
		vim.notify(cmd)
		vim.cmd(cmd)
	end, desc = "nixpkgs.<cword>.homepage", },
	-- git

	-- { "<leader>gc", function() vim.cmd([[!composer browse ]] .. vim.fn.expand "<cWORD>":gsub(":", "")) end,                             desc = "composer browse", },
	-- { "<leader>gd", function() vim.cmd(p .. hostname .. ".pkgs." .. w() .. ".meta.description | xargs notify-send") end,                desc = "description", },
	-- { "<leader>gD", function() vim.cmd(p .. hostname .. ".pkgs." .. w() .. [[.meta.longDescription --raw | xargs -0 notify-send]]) end, desc = "longDescription", },
	-- { "<leader>gg", function() vim.fn.expand "<cWORD>":gsub("github:", "https://github.com/"):gsub(";", ""):xdg_open() end,             desc = "github:owner/repo", },


}


local res = vim.system { "nix", "eval", "nixpkgs#git.meta.homepage", }

wk.add {

	{ "-",    "<cmd>cd ..<CR>", },
	{ "<F1>", function() vim.cmd.help(vim.fn.expand "<cword>") end, mode = { "n", "i", "v", }, },
	{ "qq",   [[:NvimTreeToggle<CR>]],                              noremap = true, },
	{ "qw",   [[:NvimTreeCollapse<CR>]], },

}

vim.cmd [[
	cab == lua= print('foo')
	
]]


function get_visual_selection()
	local s_start = vim.fn.getpos "'<"
	local s_end = vim.fn.getpos "'>"
	local n_lines = math.abs(s_end[2] - s_start[2]) + 1
	local lines = vim.api.nvim_buf_get_lines(0, s_start[2] - 1, s_end[2], false)
	lines[1] = string.sub(lines[1], s_start[3], -1)
	if n_lines == 1 then
		lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3] - s_start[3] + 1)
	else
		lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3])
	end
	-- return table.concat(lines, '\n')
	print(table.concat(lines, '\n'))
end

vim.keymap.set('v', '<Leader>F', ':<C-u>lua get_visual_selection()<CR>', { silent = true, })

wk.add {
	{ '<F3>', function()
		local mode = vim.fn.mode()
		-- vim.fn.feedkeys ':<C-u>lua get_visual_selection()<CR>'
		if mode == 'v' then
		end
		vim.ui.select({
			vim.fn.expand '<cword>',
			vim.fn.expand '<cWORD>',
			vim.fn.expand '<cfile>',
			vim.fn.expand '<cexpr>',

		}, {}, function(item, idx)
			if item then vim.cmd.help(item) end
		end);
	end, mode = { 'n', 'i', 'v', }, },

}
