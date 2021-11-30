-- // rounds to minus infinity, floor division
print("3 // 2",3 // 2) -- 1
print("3 // -2",3 // -2) -- -2

-- % or modulo means x % K is always in the range [0,K-1] with K being an
-- absolute number
print("5 % 10",5 % 10)
print("9 % 10",9 % 10)
print("10 % 10",10 % 10)
print("0 % 10",0 % 10)
print("-10 % 10",-10 % 10)
print("12 % -10",12 % -10)
print("1 % -10",1 % -10)

-- https://betterexplained.com/articles/intuitive-guide-to-angles-degrees-and-radians/
-- if you don't know what radians is but wonder about it when the book mentions
-- it in passing.

-- Same goes for double precision floating point numbers
-- https://stackoverflow.com/questions/801117/whats-the-difference-between-a-single-precision-and-double-precision-floating-p

-- (Pseudo-)Random number takes a seed through math.randomseed. If the seed
-- isn't changed, the numbers aren't random at all. The below always prints 6
-- and 3 for me.
print(math.random(6))
print(math.random(6))

math.randomseed(os.time())
print(math.random(6)) -- This changes everytime

print("math.modf(3.532)", math.modf(3.532))

-- Converting to integer can be done with math.tointeger which returns nil if
-- the number doesn't have an exact integer representation, if it has a
-- fractional part.  You can also OR it with 0.
print(math.tointeger(1.1))
print(math.tointeger(1.0))
print(1.0 | 0)
