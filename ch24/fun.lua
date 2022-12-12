-- Let's try to write a function that's a co-routine which is recursive.
local function sum_if_divisible_by_two(n)
	local _, v = coroutine.resume(coroutine.create(sum_if_divisible_by_two), n - 1)
	coroutine.yield(n == 0 and 0 or v + (n % 2 == 0 and n or 0))
end

local iter = function(n)
	return coroutine.wrap(function()
		sum_if_divisible_by_two(n)
	end)
end

for v in iter(10) do
	print(v)
end
