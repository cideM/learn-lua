-- 15.3 Use ["key"]=value syntax only when necessary

local function valid(s)
	if string.match(s, "^%d") then
		return false
	end

	if string.match(s, "^_[A-Z]+") then
		return false
	end

	if string.match(s, "^[%d_%a]+$") then
		return true
	end

	return false
end

local function serialize(o, indent, depth)
	local indent = indent or "  "
	local depth = depth or 1
	local t = type(o)
	if t == "number" or t == "string" or t == "boolean" or t == "nil" then
		io.write(string.format("%q", o))
	elseif t == "table" then
		io.write("{\n")
		for k, v in pairs(o) do
			io.write(string.rep(indent, depth))
			if type(k) == "string" and not valid(k) then
				io.write(string.format("[\"%s\"] = ", k))
      elseif type(k) == "number" then
				io.write(string.format("[%d] = ", k))
			else
				io.write(k, " = ")
			end
			serialize(v, indent, depth + 1)
			io.write(",\n")
		end
		io.write(string.rep(indent, depth - 1), "}")
	else
		error("cannot serialize a " .. type(o))
	end
end

local nested = { a = 1 }
serialize({
	foo = 5,
	bax = 'another "one"',
	bar = { 1, 2, c = { b = nested } },
})
