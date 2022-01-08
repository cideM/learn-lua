-- Unsurprisingly, date stuff confuses me. I am UTC+1, so I would have thought
-- that adding the exclamation mark would mean that the current time is
-- interpreted as UTC. But it still gives me UTC+1. The actual time is then
-- shown correctly. I guess "!" has no effect on %z.
print(os.date("%c %z"))
print(os.date("!%c %z"))

for k,v in pairs(os.date("*t", os.time())) do
  print(k, v)
end
