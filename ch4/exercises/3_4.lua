-- 4.3 and 4.4
function insert(old, i, new)
  -- If we want to insert at 1 we need to read 0 bytes of the string, because
  -- we insert at the very first byte and shift everything else right.
  -- But offset(old, 1) gives us the first byte, and sub is inclusive. That's
  -- why we decrement the start range. Same concept for the end range.
  local range_start, range_end = utf8.offset(old, 1), utf8.offset(old, i)
  local left = old:sub(range_start - 1, range_end - 1)
  local right = old:sub(range_end)
  return string.format("%s%s%s",left,new,right)
end

assert(insert("foo",1,"bar") == "barfoo",insert("foo",1,"bar"))
assert(insert("foo",3,"bar") == "fobaro",insert("foo",3,"bar"))
assert(insert("はつねみく",1,"bar") == "barはつねみく",insert("はつねみく",1,"bar"))
assert(insert("はつねみく",2,"bar") == "はbarつねみく",insert("はつねみく",2,"bar"))

