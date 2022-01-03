-- 10.7 Write a function to reverse a UTF-8 string

-- I don't know how to do this with regular expressions so I guess that's not
-- the point of this exercise.

function reverse(s)
  local new = {}
  for _, c in utf8.codes(s) do
    table.insert(new, 1, string.char(c))
  end
  return table.concat(new)
end

print(reverse("foo"))
