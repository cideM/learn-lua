-- 20.1 Define a metamethod __sub for sets that returns the difference of two
--    sets (elements from a that are not in b)

-- 20.2 Define a metamethod __len for sets

local Set = {}
local mt = {}

function Set.New(a)
	local s = {}
	for _, v in ipairs(a) do
		s[v] = true
	end
	setmetatable(s, mt)
	return s
end

function Set.Difference(a, b)
	local out = {}
	for k in pairs(a) do
		if not b[k] then
			table.insert(out, k)
		end
	end
	return Set.New(out)
end

function Set.Length(a)
	local len = 0
	for _ in pairs(a) do
    len = len + 1
	end
	return len
end


function Set.tostring(a)
  local xs = {}
  for k in pairs(a) do
    table.insert(xs, k)
  end
  return "{" .. table.concat(xs, ",") .. "}"
end

mt.__sub = Set.Difference
mt.__tostring = Set.tostring
mt.__len = Set.Length

local a, b = Set.New{ 1, 2 }, Set.New{ 1, 4 }
print(a - b)
print(#a)

