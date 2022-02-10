-- 15.4 Use constructor syntax for lists where possible

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

function list(o, indent, depth)
	local processed_list_keys = {}
	local i = 1
	local values = {}
	while o[i] do
		table.insert(values, o[i])
		processed_list_keys[i] = true
		i = i + 1
	end
	for _, v in ipairs(values) do
		io.write(string.rep(indent, depth))
		serialize(v, indent, depth + 1)
		io.write(",\n")
	end
	return processed_list_keys
end

function key(k)
	if type(k) == "string" and not valid(k) then
		io.write(string.format('["%s"] = ', k))
	elseif type(k) == "number" then
		io.write(string.format("[%d] = ", k))
	else
		io.write(k, " = ")
	end
end

function serialize(o, indent, depth)
	local indent = indent or "  "
	local depth = depth or 1
	local t = type(o)
	if t == "number" or t == "string" or t == "boolean" or t == "nil" then
		io.write(string.format("%q", o))
	elseif t == "table" then
		io.write("{\n")
		local processed_list_keys = list(o, indent, depth)
		for k, v in pairs(o) do
			if processed_list_keys[k] then goto done end
			io.write(string.rep(indent, depth))
      key(k)
			serialize(v, indent, depth + 1)
			io.write(",\n")
			::done::
		end
		io.write(string.rep(indent, depth - 1), "}")
	else
		error("cannot serialize a " .. type(o))
	end
end

local nested = { a = 1, "foo", "bar" }
serialize({
	foo = 5,
	bax = 'another "one"',
	bar = { 1, 2, { 1, 2, 3 }, c = { b = nested } },
})
