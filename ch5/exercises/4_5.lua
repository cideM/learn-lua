-- We can represent a polynomial An * x^n + An-1 * x^n-1 ... A1 * x^1 + A0 in
-- Lua as a list of its coefficients, such as [a0,a1,...,an].
-- Write a function that takes a polynomial (represented as a table) and a
-- value for x and returns the polynomial value.
-- https://www.mathsisfun.com/algebra/polynomials.html
function polynomial(list, x)
  local sum = 0
  for i, c in ipairs(list) do
    sum = sum + c * x ^ (i - 1)
  end
  return sum
end
print(polynomial({1,2}, 2))

-- Exercise 5.5: Can you write the function from the previous item so
-- that it uses at most n additions and n multiplications (and no
-- exponentiations)?
-- I don't know. Maybe? The chapter is called Tables, not Maths. I'm always
-- happy to broaden my horizon a bit but that's just too much for my tastes
-- right now.
