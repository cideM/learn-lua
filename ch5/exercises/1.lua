-- What will the following script print?
sunday = "monday"; monday = "sunday"
t = { sunday = "monday", [sunday] = monday }
print(t.sunday, t[sunday], t[t.sunday])

-- It will print "monday", "sunday", "sunday" The first is just normal field
-- access. The second uses the content of the variable sunday to access a field
-- on the table. The third does the same but takes the content of the field
-- sunday for the table access.
