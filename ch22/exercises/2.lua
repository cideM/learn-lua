-- 22.2: Explain in detail what happens in the following program and what it
--    will print.

local foo
do
	local _ENV = _ENV
	function foo()
		print(X)
	end
end
X = 13
_ENV = nil
foo()
X = 0

--[[
The local _ENV stores the initial _ENV, but I think local _ENV won't be used for
X The last X = 0 is weird... we're done printing so this won't do anything. X
should be either 13 or nil and I think it'll be nil.

Okay so it prints 13. I don't know why. The last assignment fails because _ENV
is nil, that one makes sense.

The compiler translates any free name to _ENV.var_name so: print(_ENV.X)

There's no magic here if I use _bax instead of _ENV it still works the same. My
theory is now that when X = 13 runs the local _ENV maintains a reference to that
object somewhere in memory and reassigning _ENV later on doesn't change that.
--]]
