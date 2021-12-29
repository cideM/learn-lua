function polynomial(list)
  return function(x)
    local sum = 0
    for i, c in ipairs(list) do
      sum = sum + c * x ^ (i - 1)
    end
    return sum
  end
end
print(polynomial({1,2})(2))

