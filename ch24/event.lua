local cmdQueue = {}

local lib = {}

function lib.readline(stream, callback)
	print("lib.readline")
	local nextCmd = function()
		print("run callback from readline")
		callback(stream:read())
	end
	print("insert readline callback into q")
	table.insert(cmdQueue, nextCmd)
end

function lib.writeline(stream, line, callback)
	local nextCmd = function()
		print("run callback from writeline")
		callback(stream:write(line))
	end
	print("insert writeline callback into q")
	table.insert(cmdQueue, nextCmd)
end

function lib.stop()
	print("lib.stop")
	table.insert(cmdQueue, "stop")
end

function lib.runloop()
	while true do
    print("lib.runloop->nextCmd")
		local nextCmd = table.remove(cmdQueue, 1)
		if nextCmd == "stop" then
			break
		else
			nextCmd()
		end
	end
end

return lib
