-- 14.3 and 14.4
-- Adapt the function readgraph to read two node names plus a label from each
-- line in the input file. (Assume that the label is a number). Implement
-- Dijkstra's algorithm.

function findpath(graph, current, target)
  -- dist is key -> number
  -- prev is node -> node
  -- Q is a list of keys
  local dist, prev, Q, Qlen = {}, {}, {}, 0

  for k,v in pairs(graph) do
    dist[k] = math.maxinteger
    table.insert(Q, k)
    Qlen = Qlen + 1
  end
  dist[current.name] = 0

  -- This should be a min heap but I'm just demonstrating the algorithm here. I
  -- have a faster implementation in my advent of code repository.
  local min
  min = function()
    local mindist, mink, mini = math.maxinteger, nil, nil
    for i,k in ipairs(Q) do
      local kdist = dist[k] or math.maxinteger
      if kdist < mindist then
        mindist = kdist
        mink = k
        mini = i
      end
    end
    table.remove(Q, mini)
    Qlen = Qlen - 1
    return mink
  end

  while Qlen > 0 do
    local k = min()
    local n = graph[k]

    for other_node, cost in pairs(n.adjacent) do
      local otherk = other_node.name
      local new_dist = dist[k] + cost
      if new_dist < dist[otherk] then
        dist[otherk] = new_dist
        prev[otherk] = k
      end
    end
  end

  local path, n = {}, target.name
  if prev[n] or n == current.name then
    while n do
      table.insert(path, 1, n)
      n = prev[n]
    end
  end

  return table.concat(path, ",")
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
    local namefrom, nameto, cost = string.match(line, "(%S+)%s+(%S+)%s+(%d+)")
    local from = name2node(graph, namefrom)
    local to = name2node(graph, nameto)
    from.adjacent[to] = cost
  end
  return graph
end

g = readgraph()
p = findpath(g, g["a"], g["d"])
print(p)
