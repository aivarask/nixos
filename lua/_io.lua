local nio = require("nio")

local Job = require("plenary.job")
-- Job:new({
--   command = 'clock',
--   args = nil,
--   on_stdout = function(_, line)
--     -- vim.notify(line)
--   end,
--   on_exit = function(self, code, signal)
--     vim.print(self:result())
--   end,
-- }):start()
