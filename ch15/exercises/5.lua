-- 15.5 Handle cycles and shared tables without avoiding constructor syntax all
-- the time.

-- I solved the problem in the way I find aesthetically pleasing. Not sure if
-- that's what the book author had in mind. This code isn't very clean though
-- because I don't have the motivation to make it super pretty.

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

function list(o, indent, depth, seen, path)
	local processed_list_keys, i, values = {}, 1, {}
	while o[i] do
		table.insert(values, o[i])
		processed_list_keys[i] = true
		i = i + 1
	end
	for i, v in ipairs(values) do
		io.write(string.rep(indent, depth))
		local pathcopy = table.move(path, 1, #path, 1, {})
		table.insert(pathcopy, string.format("[%q]", i))
		serialize(v, indent, depth + 1, seen, pathcopy)
		io.write(",\n")
	end
	return processed_list_keys
end

function key(k)
	if type(k) == "string" and not valid(k) then
		return string.format("[%q]", k)
	elseif type(k) == "number" then
		return string.format("[%q]", k)
	else
		return string.format("%q", k)
	end
end

function serialize(o, indent, depth, seen, path)
	-- The actual table we're serializing needs to have a variable name so we can
	-- refer to it in the case of cycles. That variable name is taken from the
	-- root path.
	if depth == 1 then
		if #path == 0 then
			error("path can't be empty")
		end
		io.write(path[1], " = ")
	end

	local t = type(o)
	if t == "number" or t == "string" or t == "boolean" or t == "nil" then
		io.write(string.format("%q", o))
	elseif t == "table" then
		-- We keep track of every table we encounter so we can handle shared
		-- subtables and cycles by displaying a reference instead of a literal
		-- table. Whenever we come across a table we use the table itself as the key
		-- whereas the value is the list of paths where it was encountered. Whenever
		-- that list is > 2 we know we need to display a reference. We can then just
		-- use the first path as the original value. Technically this isn't 100%
		-- correct since we might loop over a key that was originally a reference
		-- before we get to the key where the table constructor is called. But for
		-- our purposes it doesn't matter.
		-- test = { b = { 1 } }
		-- test.a = test.b
		-- might be printed as:
		-- test = {
		--   "a" = {
		--     1,
		--   },
		--   "b" = test["a"],
		-- }
		-- but that's good enough for me.
		if not seen[o] then
			seen[o] = {}
		end
		table.insert(seen[o], path)
		if #seen[o] > 1 then
			io.write(table.concat(seen[o][1]))
			return
		end

		io.write("{\n")
		local processed_list_keys = list(o, indent, depth, seen, path)
		for k, v in pairs(o) do
			if processed_list_keys[k] then
				goto done
			end
			io.write(string.rep(indent, depth))
			local ks = key(k)
			io.write(ks, " = ")
			local pathcopy = table.move(path, 1, #path, 1, {})
			table.insert(pathcopy, string.format("[%q]", k))
			serialize(v, indent, depth + 1, seen, pathcopy)
			io.write(",\n")
			::done::
		end
		io.write(string.rep(indent, depth - 1), "}")
	else
		error("cannot serialize a " .. type(o))
	end
end

local nested = { a = 1, "foo", "bar" }
local test = {
	foo = 5,
	bax = 'another "one"',
	bar = { 1, 2, { 1, 2, 3 }, c = { b = nested } },
}
test.z = test
test.y = nested
test.bar[4] = test.bar
serialize(test, "  ", 1, {}, { "test" })
