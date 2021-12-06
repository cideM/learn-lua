print(math.mininteger, math.maxinteger)
print(math.maxinteger * math.maxinteger)
--[[
max + 1 wraps around to mininteger. Because maxinteger, as an absolute number,
is one smaller than mininteger, adding max to max means first we wrap around to
min and then we have one less than mininteger anyway so we're left with -2.
--]]

print(math.mininteger * 2)
--[[
Opposite direction. Adding 1 gets us to maxinteger and then we have, in
absolute numbers, the same amount left as maxinteger, so we end up at 0.
--]]

print(math.maxinteger * math.maxinteger) -- 1
print(math.mininteger * math.mininteger) -- 0

--[[
This makes my head hurt :( Obviously by adding more math.maxinteger we always
end up in the negative, and then the positive, back to negative, and so on.

Due to this back and forth the even numbers * -1 are the results:
math.maxinteger * 256 = -256
But math.maxinteger * math.maxinteger = -math.maxinteger?
For (math.maxinteger * (math.maxinteger - 1)) this still works.

There's a certain symmetry where at first the even number is really small and
close to 0 but the uneven number is super big and close to max. The more you
increase k in math.maxinteger * k the further left this pair moves until it
would reach math.mininteger and 0 but because math.maxinteger is one short we
end at 1.

With math.mininteger the final result is 0 since it's 1 bigger than
math.maxinteger. We're not moving we're just alternating between
math.mininteger and 0 all the time as we increase k in:
math.mininteger + (math.mininteger * k)
--]]
