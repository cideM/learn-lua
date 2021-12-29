-- 9.2 What is the output of the following chunk?

function F(x)
  return {
    set = function (y) x = y end,
    get = function () return x end,
  }
end

o1 = F(10)
o2 = F(20)
print(o1.get(), o2.get())
o2.set(100)
o1.set(300)
print(o1.get(), o2.get())

-- I did not expect this. Apparently I can redefine function arguments at any
-- point in time
