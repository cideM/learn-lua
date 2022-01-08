-- 12.3 Write a function that takes a date-time (coded as a number) and returns the number of seconds passed since the beginning of its respective day.

function seconds_passed_day(time)
  local date = os.date("*t", time)
  return date.hour * 60 * 60 + date.min * 60 + date.sec
end

local one_am = os.date("*t", time)
one_am.hour = 1
one_am.min = 0
one_am.sec = 0
print(seconds_passed_day(os.time(one_am)))
