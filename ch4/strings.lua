print(string.format("%c",2)) -- c           The first byte of argument is printed.
                             -- this doesn't really seem to work, because I can't give
                             -- it a string. Maybe because of UTF-8?
print(string.format("%04.2s","hirule"))
--                      ^^-- precision for strings is number of bytes to print
print(string.format("%-10s %s","a","b"))
print(string.format("%-10s %s","foobar","b"))
                   -- ^ left align, pretty handy

s = "はつねみく"
-- Extract 2nd and 3rd code point
print(s:sub(utf8.offset(s,2),utf8.offset(s,4)-1))
-- This was not mentioned in the book even though I think it should have.
-- Unless I'm overlooking something.
-- string.sub works with bytes, it's not aware of UTF-8. If I omit the -1 and
-- use utf8.offset(s,3) it will read from the first byte of the 2nd code point
-- (or Unicode grapheme, glyph, whatever), to the **first byte** of the 3rd.
-- And because string.sub doesn't understand Unicode it won't extract the
-- string I think it would, because it will essentially index into a Unicode
-- thing using bytes, and break it.
-- By using the following Unicode thing and going back one byte we now read the
-- full bytes of the 3rd Unicode thing.

