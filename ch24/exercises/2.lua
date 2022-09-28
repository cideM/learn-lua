-- 24.2 Transform into generator for combinations

-- I spent over an hour debugging this. I quickly got to a point where I removed
-- one level of nested {} from the m == 0 branch, but somehow I didn't see that
-- I needed to do the same for the n < m branch.
-- It's hard for me to see "get it". Like, in the future, how would I know that
-- transforming it from list to yield requires one less level of nesting here.
-- Okay now that I think about it, it's clear. When you return a list from a
-- recursive call to then loop over it, an empty {} means no looping. But if you
-- yield {}, that's very much an element that will be processed by the caller.
function combinations(n, m, a)
	return coroutine.wrap(function()
		local copy = table.move(a, 1, #a, 1, {})

		if n < m then
			coroutine.yield()
			return
		end
		if m == 0 then
			coroutine.yield({})
			return
		end

		local first = table.remove(copy, 1)

		for combo in combinations(n - 1, m - 1, copy) do
			table.insert(combo, 1, first)
			coroutine.yield(combo)
		end
		for combo in combinations(n - 1, m, copy) do
			coroutine.yield(combo)
		end
	end)
end

combos = combinations(3, 2, { 0, 1, 2, 3, 4 })
for v in combos do
	print(table.unpack(v))
end
