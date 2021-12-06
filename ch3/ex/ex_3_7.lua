-- Using math.random, write a function to produce a pseudo-random number with a standard normal (Gaussian) distribution.
-- I don't know much about maths but the first thing I found it the Box-Muller transform.

function gaussian(mean, std_dev)
  local a = math.random()
  local b = math.random()
  local c = std_dev * math.sqrt(-2 * math.log(a))
  return math.floor(c * math.cos(2 * math.pi * b) + mean)
end

counts = {}
for _ = 1,1000 do
  local v = gaussian(100, 10)
  counts[v] = (counts[v] or 0) + 1
end

points = {}
for k,v in pairs(counts) do
  local key = string.format("%d,%d", k, v)
  table.insert(points, key)
end

-- You can paste these points into a <polyline> SVG element
print(table.concat(points, " "))
