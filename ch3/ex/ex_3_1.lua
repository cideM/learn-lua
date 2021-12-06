print(.0e12) -- Is a valid number, .0 is the same as 0.0 and e12 just means 0.0 * 10^12, so 0.0
-- print(.e12) -- I guess the same as above? Nope, this one isn't valid
-- print(0.0e) -- I doubt this is valid unless the exponent defaults to something
print(0x12) -- Should be valid since 1 and 2 or valid hexadecimal numbers. This is 2 * 1 + 1 * 16 = 18
-- print(0xABFG) -- Invalid because of G
print(0xA) -- 10
-- print(FFFF) -- Nope, this prints nil because FFFF is implicitly a global variable
print(0xFFFFFFFF) -- Yup
-- print(0x) -- Errr... no?
print(0x1P10) -- Yes, floating-point hexadecimal constant. I forgot how this works.
print(0.1e1) -- Yes, this is 0.1 * 10^1
print(0x0.1p1) -- Ehmmm... no? Looks weird, mixing hex and floating point without making it a floating-point hexadecimal constant. But it works! No idea.

--[[
So about those weird floating-point hexadecimal constants...
0x0.1p1
| | | |
+-|-|-|--- 0x because hex
  +-|-|--- hex digit
    +-|--- hex digit; because it's the first position from the right this is 1/16
      +--- signed exponent, power of two

We're going the reverse direction with 1 16 256 etc.
(0 + 1/16) * 2^1
--]]

print(0x0.12p1)

--[[
(0 + 1/16 + 2/256) * 2^1
--]]
