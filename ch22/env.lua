local print, sin = print, math.sin
-- With this uncommented the file fails to load. But I want to play around with
-- supplying a custom env and using "loadfile" in load_env.lua
-- _ENV = nil
print(13)
print(sin(13))
print(math.cos(13))
