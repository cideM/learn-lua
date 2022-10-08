-- 24.3 "getline" and "putline" create a closure each time they are called,
--    memorize this.
-- 24.4 write a line iterator so you can read the file with a for loop
-- 24.5 Can you use the coroutine-based library to run multiple threads
--    concurrently?
--    Errrrmm... given how hard it is for me to develop an intuitive
--    understanding of the control flow and data flow here, this seems like a
--    tall order. What would it even mean to run this concurrently? Since
--    everything runs on a single thread, any blocking operation will prevent us
--    from switching to a different task. So, first of all, we need some
--    non-blocking OS calls. Since we're interested in the order of things for
--    reading and reversing the file, it gets a bit more complicated. Let's say
--    we wanted to read lines concurrently but keeping the order. We can
--    increment the lines counter before starting a non-blocking OS call. When
--    that call returns, we know where to insert it, but the subsequent calls
--    for the next lines also need where to put their data.
--    This means, when you insert commands into the queue you should probably
--    store the line number with the command. The "runloop" function would then
--    have to loop through all tasks and see which one it can run. In the end
--    you always end up with some sort of "select" call from Go.
--    Coming back to this explanation after a week or so, I think I forgot that
--    "thread" here probably just means coroutine? Ultimately the problem is the
--    same though. We want to switch between different threads so they'd need
--    suspension points where they yield but ultimately you'd need a dispatcher.
local cmdQueue = {}

local lib = {}

function lib.readline(stream, callback)
	local nextCmd = function()
		callback(stream:read())
	end
	table.insert(cmdQueue, nextCmd)
end

function lib.writeline(stream, line, callback)
	local nextCmd = function()
		callback(stream:write(line))
	end
	table.insert(cmdQueue, nextCmd)
end

function lib.stop()
	table.insert(cmdQueue, "stop")
end

function lib.runloop()
	while true do
		local nextCmd = table.remove(cmdQueue, 1)
		if nextCmd == "stop" then
			break
		else
			nextCmd()
		end
	end
end

local function run(code)
	local co = coroutine.wrap(function()
		code()
		lib.stop()
	end)
	co()
	lib.runloop()
end

local putline_cache = {}
setmetatable(putline_cache, { __mode = "kv" })

local function putline(stream, line)
	local co = coroutine.running()
	local callback = putline_cache[co]
	if not callback then
		print("cache miss putline")
		putline_cache[co] = function()
			coroutine.resume(co)
		end
		callback = putline_cache[co]
	end
	lib.writeline(stream, line, callback)
	coroutine.yield()
end

local getline_cache = {}
setmetatable(getline_cache, { __mode = "kv" })

local function getline(stream)
	local co = coroutine.running()
	local callback = getline_cache[co]
	if not callback then
		print("cache miss getline")
		getline_cache[co] = function(l)
			coroutine.resume(co, l)
		end
		callback = getline_cache[co]
	end
	lib.readline(stream, callback)
	local line2 = coroutine.yield()
	return line2
end

-- This is SO not intuitive at all :(
function getline_iter(stream)
	return function(stream)
		return getline(stream)
	end, stream, nil
end

run(function()
	local t = {}
	local inp = io.input()
	local out = io.output()

	for line in getline_iter(inp) do
		if not line then
			break
		end
		t[#t + 1] = line
	end

	for i = #t, 1, -1 do
		putline(out, t[i] .. "\n")
	end
end)
