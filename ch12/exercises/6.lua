-- 12.6 Write a function that computes the number of complete months between two dates
function complete_months(d1, d2)
  local date1, date2 = os.date("*t", d1), os.date("*t", d2)
  local months_diff = date2.month - date1.month - 1
  return (date2.year - date1.year) * months_diff
end

print(complete_months(now, os.time(later)))
local d1 = { year = 2020, month = 1, day = 1 }
local d2 = { year = 2020, month = 1, day = 2 }
print(complete_months(os.time(d1), os.time(d2)))

d2 = { year = 2021, month = 2, day = 3 }
print(complete_months(os.time(d1), os.time(d2)))

d2 = { year = 2021, month = 3, day = 3 }
print(complete_months(os.time(d1), os.time(d2)))
