-- 22.1 The function getfield that we defined in the beginning of this chapter
--    is too forgiving, as it accepts "fields" like math?sin or string!!!gsub.
--    Rewrite it so that it accepts only single dots as name separators.
local function getfield(s)
  local cur, v = {}, _G
  for w in string.gmatch(s, ".") do
    if w == "." then
      v = v[table.concat(cur)]
      cur = {}
    else
      table.insert(cur, w)
    end
  end
  v = v[table.concat(cur)]
  return v
end

print(getfield("a.b.c"))
