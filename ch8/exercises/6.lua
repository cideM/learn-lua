-- 8.6 Explain what this would do if jumping out of functions was allowed
-- In this case I don't really see the problem as the function "getlabel"
-- always returns 0. I mean of course, jumping out of the anonymous function
-- would need to restore the context where getlabel() was called which was
-- already discarded by the time we get to "x()"

function getlabel()
  return function () return 0 end
end

-- function getlabel()
--   return function () goto L1 end
--   ::L1::
--   return 0
-- end

function f(n)
  if n == 0 then return getlabel()
  else
    local res = f(n-1)
    print(n)
    return res
  end
end

x = f(10)
x()
