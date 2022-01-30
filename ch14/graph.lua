-- depth-first traversal
function findpath(current, target, path, visited)
  path = path or {}
  visited = visited or {}
  if visited[current] then return nil end

  visited[current] = true

  path[#path + 1] = current
  if current == target then return path end

  for node in pairs(current.adjacent) do
    local p = findpath(node, target, path, visited)
    if p then return p end
  end
  -- I don't think I've ever seen this in a DFS algorithm, it's quite
  -- interesting and even a bit clever. The alternative would be to add the
  -- current node to path only in the two success cases:
  -- - we found the target
  -- - recursive findpath found a path
  table.remove(path)
end

function printpath(p)
  for i = 1, #p do print(p[i].name) end
end

function name2node(graph, name)
  local node = graph[name]
  if not node then
    node = {name = name, adjacent = {}}
    graph[name] = node
  end
  return node
end

function readgraph()
  local graph = {}
  for line in io.lines() do
    local namefrom, nameto = string.match(line, "(%S+)%s+(%S+)")
    local from = name2node(graph, namefrom)
    local to = name2node(graph, nameto)
    from.adjacent[to] = true
  end
  return graph
end

g = readgraph()
a = name2node(g, "a")
b = name2node(g, "b")
c = name2node(g, "c")
d = name2node(g, "d")
p = findpath(a, d)
if p then printpath(p) end
