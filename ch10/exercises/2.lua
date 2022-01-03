-- 10.2 %D and [^%d] are equivalent, what about [^%d%u] and [%D%U]?
-- 1) [^%d%u] = not %d and not %u
-- 2)  [%D%U] = not %d or not %u
-- These are not equivalent. "a" is not a digit and not uppercase, so it works
-- with 1) and 2). "A" works with 2), but not with 1).
print(string.find("A", "[^%d%u]"))
print(string.find("A", "[%D%U]"))

print(string.find("a", "[^%d%u]"))
print(string.find("a", "[%D%U]"))
