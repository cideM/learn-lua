-- 12.1 Write a function that returns the date-time exactly one month after a given date-time. (Assume the numeric coding of date-time).

function one_month_after(d)
  local t = os.date("*t", d)
  t.month = t.month + 1
  return os.time(t)
end

local now = os.time()
print(os.date("%c", now))
print(os.date("%c", one_month_after()))
print(os.date("%c", one_month_after(one_month_after())))
