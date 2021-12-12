-- 4.5 and 4.6
function remove(old, i, len)
  local range_start, range_end = utf8.offset(old, i), utf8.offset(old, i + len)
  local left = old:sub(0, range_start - 1)
  local right = old:sub(range_end)
  return string.format("%s%s",left,right)
end

assert(
  remove("hello world", 7, 4) == "hello d",
  string.format("'hello d' but got %s", remove("hello world", 7, 4))
)
assert(
  remove("hello world", 1, 1) == "ello world",
  string.format("'ello world' but got %s", remove("hello world", 1, 1))
)
assert(
  remove("はつねみく", 1, 1) == "つねみく",
  string.format("'つねみく' but got %s", remove("はつねみく", 1, 1))
)
