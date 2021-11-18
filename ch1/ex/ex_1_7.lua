-- (x and y and (not z)) or ((not y) and x)

print(1 and 2 and not false or not false and 2)

--[[
Look like the parentheses are not necessary. I would leave the ones around the
two expressions that "or" is comparing though, for readability.
--]]
