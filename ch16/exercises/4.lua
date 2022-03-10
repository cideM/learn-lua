-- Can you make pcall(pcall, f) return false as its first result?

-- https://stackoverflow.com/questions/39113323/how-do-i-find-an-f-that-makes-pcallpcall-f-return-false-in-lua
pcall(pcall,(function() end)())

-- So the anonymous function is run first and fails immediately but this
-- apparently returns nothing... not nil, just nothing. We then end up calling
-- pcall with argument nothing (?) and doing so protected (the other pcall).
-- This does not crash but it returns what the inner pcall then returns which is
-- false. Weird stuff. Not sure why this is relevant though. The SO post
-- mentions that pcall is written in C and can therefore make this distinction
-- but how this would translate to code written in Lua and what it means to me,
-- not sure.
