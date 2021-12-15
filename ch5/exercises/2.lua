a = {}; a.a = a
-- What would be the value of a.a.a.a? Is any a in that sequence somehow
-- different from the others?
-- The value should be the table a. It's recursive but other than that it's
-- just setting the field a on the table a. The first a is the table, the
-- others are the fields.
print(a.a.a.a)
a.a.a.a = 3
-- What would be the value of a.a.a.a now?
-- Well... if I'm getting this right the Jenga Tower of Recursive Doom should
-- now collapse. We're setting the field a on the table to 3, so we no longer
-- have the recursive data structure. We're now left with a = { a = 3 } so
-- a.a.a.a shouldn't even work.
