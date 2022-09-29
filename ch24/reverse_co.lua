local lib = require("event")

local function run(code)
	local co = coroutine.wrap(function()
		print("run->wrap->code()")
		code()
		print("run->wrap->stop()")
		lib.stop()
	end)
	print("run->co()")
	co()
	print("run->runloop()")
	lib.runloop()
end

local function putline(stream, line)
	local co = coroutine.running()
	local callback = function()
		print("putline->callback->resume")
		coroutine.resume(co)
	end
	print("putline->lib.writeline")
	lib.writeline(stream, line, callback)
	print("putline->coroutine.yield")
	coroutine.yield()
end

local count = 0

local function getline(stream)
	count = count + 1
	-- The running coroutine here should be the one from "run"
	local co = coroutine.running()
	local callback = function(l)
		count = count + 1
		print("getline->callback->resume", count, l)
		-- "run" calls the code block which contains getline so when we yield we
		-- pause the "run" coroutine and this just resumes it which should acutally
		-- resume inside getline?
		coroutine.resume(co, l)
	end
  oldcount = count
	print("getline->lib.readline", oldcount)
	lib.readline(stream, callback)
	print("getline->coroutine.yield", oldcount)
	local line2 = coroutine.yield()
	print("getline->after coroutine.yield", oldcount, line2)
	return line2
end

run(function()
	local t = {}
	local inp = io.input()
	local out = io.output()

	while true do
		print("while true do->getline()")
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
