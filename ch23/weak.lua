t = {}
setmetatable(t, { __mode = "v" })

do
	local someothervar = {}
  -- v--- also collected because someothervar goes out of scope
	t["hello"] = someothervar
end

somevar = {}
t["bar"] = 2
t["bax"] = {} -- this is collected
t["boo"] = somevar -- this isn't
collectgarbage()

for k, v in pairs(t) do
	print(k, v)
end
