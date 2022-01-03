-- 10.6 Rewrite transliterate so it works with UTF-8 characters

function transliterate(s, t)
  local fn = function (c) return t[c] or "" end
  return s.gsub(s, utf8.charpattern, fn)
end

print((transliterate("作業", { ["作"] = "業", ["業"] = "lol" })))

