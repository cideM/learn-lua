-- 12.5 Write a function that computes the number of complete days between two dates

-- This is the solution if you consider a day to be a 24h period. But when I read about the next exercise, which is the same thing but with months, I decided that day refers to a calendar day. Meaning if two dates are 30h apart there's no full day between them. See my revised solution below.
local seconds_day = 24 * 60 * 60
function complete_days(d1, d2)
  return os.difftime(d2, d1) // seconds_day
end

local now, later = os.time(), os.date("*t", os.time())
later.hour = later.hour + 23
print(complete_days(now, os.time(later)))

later.hour = later.hour + 1
print(complete_days(now, os.time(later)))

-- Revised
function isleap(year)
  if year % 100 == 0 then
    return year % 400 == 0
  else
    return year % 4 == 0
  end
end

print("2000", isleap(2000))
print("1900", isleap(1900))
print("2020", isleap(2020))

function complete_days_2(d1, d2)
  local date1, date2 = os.date("*t", d1), os.date("*t", d2)
  local days, i = 0, date1.year
  while i < date2.year do
    local either_leap = isleap(date1.year) or isleap(date2.year)
    days = days + (either_leap and 366 or 365)
    i = i + 1
  end

  return days + (date2.yday - date1.yday - 1)
end

print(complete_days_2(now, os.time(later)))
local d1 = { year = 2020, month = 1, day = 1 }
local d2 = { year = 2020, month = 1, day = 2 }
print(complete_days_2(os.time(d1), os.time(d2)))

d2 = { year = 2020, month = 1, day = 3 }
print(complete_days_2(os.time(d1), os.time(d2)))

d2 = { year = 2021, month = 1, day = 3 }
print(complete_days_2(os.time(d1), os.time(d2)))
