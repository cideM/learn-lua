-- 8.5 Why does Lua have the restriction that goto cannot jump out of a function?
-- I don't know! Considering how similar this seems to recursive function calls...
--
-- Okay actually calling a function is different from jumping to a random
-- location in the code. What about the whole context of where that code was
-- running? A function can close over some scope but arbitrary code doesn't
-- save it's scope context anywhere I assume.