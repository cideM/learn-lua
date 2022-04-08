-- 20.4 and 5 Proxy a file so that t[i] returns the ith byte of the file and implement
--    pairs and length

local FileProxy = {}

function FileProxy.New(fname)
	local proxy = {}
	local h = assert(io.open(fname, "r+"))
	local mt = {
		__index = function(_, i)
			assert(h:seek("set", i))
			return h:read(1)
		end,
		__newindex = function(_, i, v)
			assert(h:seek("set", i))
			return h:write(v)
		end,
		__len = function(_)
			return assert(h:seek("end"))
		end,
		__pairs = function(_)
			local i = -1
			assert(h:seek("set"))
			return function()
				i = i + 1
				local c = h:read(1)
				if not c then
					return nil
				end
				return i, c
			end
		end,
	}
	setmetatable(proxy, mt)
	local close = function()
		h:close()
	end
	return proxy, close
end

local fp, close = FileProxy.New("ch20/exercises/test.txt")
print(fp[2])
fp[2] = "a"
print(fp[2])
print(#fp)

for i, b in pairs(fp) do
	print(i, b)
end
close()
