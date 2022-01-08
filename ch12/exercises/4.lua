-- 12.4 Write a function that takes a year and returns the day of its first Friday

function first_friday(year)
  local date = os.date("*t", os.time({ year = year, month = 1, day = 1 }))
  repeat
    date.day = date.day + 1
    date = os.date("*t", os.time(date))
  until date.wday == 6
  return date.yday
end

print(first_friday(2022))
