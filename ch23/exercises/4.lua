-- 23.4 Explain output of program below
local count = 0
local mt = {
	__gc = function()
		count = count - 1
	end,
}
local a = {}

for i = 1, 10000 do
	count = count + 1
	a[i] = setmetatable({}, mt)
end

collectgarbage()
print(collectgarbage("count") * 1024, count)
a = nil
collectgarbage()
print(collectgarbage("count") * 1024, count)
collectgarbage()
print(collectgarbage("count") * 1024, count)
-- My interpretation is that this simply shows the incremental GC. First we run
-- all finalizers but we don't immediately clean all objects. I should be able
-- to skip the second print by forcing a full GC.
-- So that's not what happens. I re-read the paragraph on finalizers. The first
-- call runs the finalizers, the next call cleans up the actual objects. I still
-- don't understand why memory is decreasing then, though.
-- I guess it's because when the finalizer functions run they themselves can be
-- cleaned up?
-- 844296.0	10000
-- 582168.0	0
-- 22168.0	0
