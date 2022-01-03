-- 10.4 Find a string that demonstrates the catastrophic backtracking of trim, then fix it.

-- function trim_slow (s)
--   s = string.gsub(s, "^%s*(.-)%s*$", "%1")
--   return s
-- end
-- trim_slow("a" .. string.rep(" ", 80000) .. "a")

--[[
This one was tricky and I needed to consult some websites that explain examples
of catastrophic backtracking. I'm obviously still only marginally more
knowledgeable than before, but at least I was able to find an example string
that makes the above "trim" function take forever even on small strings.

A typical setup for catastrophic backtracking is some greedy modifier, such as
"*" (not "-"), and a pattern that fails towards the end. Now the greedy
modifier will "give up" one of its matches, and try again. It's like a nested
loop. This example explains it much better:
https://javascript.info/regexp-catastrophic-backtracking

I thought converting the last "*" to a "-" would fix the issue, but it did not.
This got me thinking. What if it's actually the "-" that's causing the
backtracking? I don't know exactly how "-" and "*" behave here, but maybe the
"-" will match the letter, plus all spaces, because the pattern after it allows
zero matches. Once it reaches the end of the string, it's actually the "(.-)"
that gives up a character.

I think that's it, because changing the capture group to match non-whitespace
instead of everything seems to fix the issue.

The solution below is taken from http://lua-users.org/wiki/StringTrim and I
don't really understand why it works. "(.*%S)" should also backtrack. I mean imagine:

string.match("foo", ".*%S")

The ".*" will match the entire string but since "%S" is not optional it has to
backtrack, right? I think the difference is that "trim_slow" will backtrack
until it runs out of options, which for the case of lots of whitespace means
lots of backtracking. The fixed version on the other hand backtracks only until
it can match "%S".
--]]

function trim (s)
  return s:match'^%s*(.*%S)'
end

print(string.format("'%s'", trim(" a ")))
print(string.format("'%s'", trim("a ")))
print(string.format("'%s'", trim(" a")))
print(string.format("'%s'", trim(" a   b   ")))
trim("a" .. string.rep(" ", 80000) .. "a")
