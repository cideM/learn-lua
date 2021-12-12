-- 4.7 and 4.9; 4.8 should just be string.gsub to remove punctuation before comparison?
function reverse(s)
  local len = utf8.len(s)
  local new = {}
  for i = 1, len do
    local first = utf8.offset(s, i)
    if i == len then
      table.insert(new, 1, s:sub(first))
    else
      table.insert(new, 1, s:sub(first, utf8.offset(s, i + 1) - 1))
    end
  end
  return table.concat(new)
end

function ispalindrome(s)
  return s == reverse(s)
end

assert(ispalindrome("step on no pets"))
assert(ispalindrome("foo") == false)
assert(ispalindrome("つつ"))
