-- Write an "integral" higher order function
-- https://www.mathsisfun.com/calculus/integration-introduction.html
-- > We could calculate the function at a few points and add up slices of width
-- > Δx like this (but the answer won't be very accurate):

function integral(f, minx, maxx)
  -- https://brilliant.org/wiki/integral-approximation-simpsons-rule/
  local a = (maxx - minx) / 6
  local b = f(minx) + 4 * f((minx + maxx) / 2) + f(maxx)
  return a * b
end

fn = function (x) return x ^ 2 end
print(integral(fn, 1, 10))
