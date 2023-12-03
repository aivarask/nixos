local M = {}

function M.hello() print('Hello') end

---@param something? string
function M.say(something) print(something or 'have nothing to say') end

function M.bye() print('Goodbye') end

M.some = function() print('i have something to say') end

return M
