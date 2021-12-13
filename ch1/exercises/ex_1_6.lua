-- How can you check whether a value is a Boolean without using the function "type"?
value = true

-- We just compare it to the only two booleans in the language.
print(value == false or value == true)
