-- 23.3 Implement a function that memorizes string-to-string
cache = {}
-- without this no GC of cache["hi"]
setmetatable(cache, { __mode = "v" })
function s_to_s(s)
	local out = { string.upper(s) }
	setmetatable(out, {
		__tostring = function(t)
			return t[1]
		end,
	})
	cache[s] = out
	return out
end

s_to_s("hi")
s_to_s("hi")
s_to_s("hi")
-- prevents GC of cache["hi"]
-- v = s_to_s("hi")
collectgarbage()
for k, v in pairs(cache) do
	print(k, v)
end
