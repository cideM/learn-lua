local ok, msg, msg2 = pcall(function()
	error({ code = 1 })
	-- return 1, 2
end)
-- differentiate between single return value for error and multiple return
-- values for no error
if ok then
  print(msg, msg2)
else
  print(msg.code)
end

local function foo()
  -- this just prints bye
  -- error("bye", 2)
  -- this prints it with a filename
  error("bye")
end

local ok, msg = pcall(foo)
print(msg)

-- xpcall gives me a stack trace when used with traceback and that stack trace
-- doesn't seem to be changed by the error level
local ok, msg = xpcall(function () error("xpcall") end, debug.traceback)
print(msg)
