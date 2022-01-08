-- 12.8 Write a function that produces the system's time zone.
function tz()
  return os.date("%z", os.time())
end

-- compare with date +"%z"
print(tz())
