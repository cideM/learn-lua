-- 25.4 Write an improved version of debug.debug that runs the given commands as
--    if they were in the lexical scope of the calling function. (Hint: run the
--    commands in an empty environment and use the __index metamethod attached
--    to the function getvarvalue to do all accesses to variables.)
local foo = require("3")

local function debug1()
	local env = foo.getvarvalues(3)
	while true do
		io.write("debug> ")
		local line = io.read()
		if line == "cont" then
			break
		end
		assert(load(line, "debug_line", "t", env))()
	end
end

local function bar()
	local a = 5
	debug1()
end

bar()
