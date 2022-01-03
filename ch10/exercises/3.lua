-- 10.3 Write transliterate. The function replaces characters according to a
--    replacement table. If the table has the value "false" for a key, then
--    remove that character.

function transliterate(s, t)
  local fn = function (c) return t[c] or "" end
  return s.gsub(s, ".", fn)
end

print((transliterate("foobar", { f = "f", o = "o", b = false, a = "a", r = false })))
