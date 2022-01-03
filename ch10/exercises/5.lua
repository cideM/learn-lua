-- 10.5 format a binary string as a literal
-- print(escape("\0\1hello\200"))
-- -> \x00\x01\x68\x65\x6c\x6c\x6F\xC8

function escape(s)
  s = string.gsub(s, "\\z%s*", "")
  s = string.gsub(s, "[%D\\]", function (c)
    local d = string.byte(c)
    return string.format("\\x%02x", d)
  end)
  s = string.gsub(s, "\\%d+", function (d)
    string.format("\\x%02x", d)
  end)
  return s
end

print(escape("\0\1hello\200"))
print(escape("\0\1hello\z         
\200"))
