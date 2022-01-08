-- 12.2 Write a function that returns the day of the week (coded as an integer, one is Sunday) of a given date

function day_of_week(d)
  return os.date("*t", d).wday
end

print(day_of_week(os.time()))
