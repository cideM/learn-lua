local lib = require("event")

local function run(code)
	local co = coroutine.wrap(function()
    print("wrapped co in run")
		code()
    print("stop now")
		lib.stop()
	end)
	co()
  print("runloop now")
	lib.runloop()
end

local function putline(stream, line)
	local co = coroutine.running()
	local callback = function()
		coroutine.resume(co)
	end
	lib.writeline(stream, line, callback)
	coroutine.yield()
end

local function getline(stream)
  -- The running coroutine here should be the one from "run"
	local co = coroutine.running()
	local callback = function(l)
    print("getline callback line: ", l)
    -- "run" calls the code block which contains getline so when we yield we
    -- pause the "run" coroutine and this just resumes it which should acutally
    -- resume inside getline?
		coroutine.resume(co, l)
	end
  print("call lib.readline from getline")
	lib.readline(stream, callback)
  print("yield now from getline")
	local line2 = coroutine.yield()
	print("getline line2", line2)
	return line2
end

run(function()
	local t = {}
	local inp = io.input()
	local out = io.output()

	while true do
		local line = getline(inp)
		if not line then
			break
		end
		t[#t + 1] = line
	end

	for i = #t, 1, -1 do
		putline(out, t[i] .. "\n")
	end
end)
