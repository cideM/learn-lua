-- 20.3 implement readOnly but using a function instead of a proxy table for
--    __index

local mt = {
  __newindex = function (_, _, _) error("read-only", 2) end,
  __index = function (t, k) return t[k] end
}

local ro = { a = 2 }
setmetatable(ro, mt)
print(ro["a"])
ro["b"] = 6
