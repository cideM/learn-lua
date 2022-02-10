-- 15.1 Modify the code in listing 15.2 so that it indents tables

local function serialize(o, indent, depth)
	local indent = indent or "  "
	local depth = depth or 1
	local t = type(o)
	if t == "number" or t == "string" or t == "boolean" or t == "nil" then
		io.write(string.format("%q", o))
	elseif t == "table" then
		io.write("{\n")
		for k, v in pairs(o) do
			io.write(string.rep(indent, depth), k, " = ")
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
	bar = { 1, 2, c = { b = nested } },
})
