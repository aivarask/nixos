local async = require('neotest.async')
local logger = require('neotest.logging')

local child_chan, parent_chan
local callbacks = {}
local next_cb_id = 1
local enabled = false

local M = {}

local function cleanup()
  if child_chan then
    logger.info('Closing child channel')
    xpcall(function()
      async.fn.chanclose(child_chan, 'rpc')
    end, function(msg)
      logger.error('Failed to close child channel: ' .. msg)
    end)
  end
end

function M.init()
  logger.info("Starting child process")
  local parent_address = async.fn.serverstart()
  local success
  local cmd = { vim.loop.exepath(), "--embed", "--headless" }
  logger.info("Starting child process with command: " .. table.concat(cmd, " "))
  success, child_chan = pcall(async.fn.jobstart, cmd, {
    rpc = true,
    on_exit = function()
      logger.info("Child process exited")
      enabled = false
    end,
  })
  if not success then
    logger.error("Failed to start child process", child_chan)
    return
  end
  xpcall(function()
    local mode = async.fn.rpcrequest(child_chan, 'nvim_get_mode')
    if mode.blocking then
      logger.error('Child process is waiting for input at startup. Aborting.')
    end
    -- Trigger lazy loading of neotest
    async.fn.rpcrequest(child_chan, 'nvim_exec_lua', "return require('neotest') and 0", {})
    async.fn.rpcrequest(
      child_chan,
      'nvim_exec_lua',
      "return require('neotest.lib').subprocess._set_parent_address(...)",
      { parent_address }
    )
    enabled = true
    async.api.nvim_create_autocmd('VimLeavePre', { callback = cleanup })
  end, function(msg)
    logger.error('Failed to initialize child process', debug.traceback(msg, 2))
    cleanup()
    child_chan = nil
  end)
end

-- local m = vim.api.nvim_get_mode()
-- print(vim.inspect(m))

M.init()
