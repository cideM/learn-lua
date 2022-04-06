-- 19.1 Generalize the Markov-chain algorithm so that it can use any size for
--    the sequence of previous words used in the choice of the next work.

-- It might have been easier to just generate a program and eval it. The
-- approach I've taken here is to create an iterator wrapping another iterator.
-- As a result, the final iterator gives you a sliding window over the
-- underlying iterator. It's not as clean as I would want though, because it
-- started with the first N words of the text, rather than the placeholder
-- values. So I added the concept of placeholders to the window iterator, so it
-- starts with a full window, except it's full of placeholders at the start.
-- Some thing when we're getting closer to the end of the input stream, when we
-- add a few trailing placeholders. There's a few + 1 and - 1 here and there
-- too. If you want a prefix of size 3 then the window iterator needs to give
-- you 4 values so you can take the first 3 as the prefix and the 4th as the
-- nextword. But it seems to work and it allowed me to refresh my iterator
-- knowledge, since I took an unfortunate break from the book for a few weeks.

local MAXGEN = 200
local NOWORD = "\n"
local PREFIX_SIZE = 3

local function allwords ()
  local line = io.read()
  local pos = 1

  return function ()
    while line do
      local w, e = string.match(line, "(%w+[,;.:]?)()", pos)
      if w then
        pos = e
        return w
      else
        line = io.read()
        pos = 1
      end
    end
    return nil
  end
end

local function window (size, placeholder)
  return function (origiter, origstate, origcontrol)
    local values = {}
    for _ = 1, size do
      table.insert(values, placeholder)
    end

    local state, control = origstate, origcontrol
    local trailing_placeholders_left = size - 1

    local iter = function (_, _)
      control = origiter(state, control)

      if control == nil then
        if trailing_placeholders_left > 0 then
          table.remove(values, 1)
          table.insert(values, placeholder)
          trailing_placeholders_left = trailing_placeholders_left - 1
          return values
        else
          return nil
        end
      end

      if #values == size then table.remove(values, 1) end
      table.insert(values, control)

      return values
    end

    return iter, nil, values
  end
end

local function prefix (t)
  return table.concat(t, " ")
end

local state = {}

local function insert (prefixstr, value)
  local list = state[prefixstr]
  if list == nil then
    state[prefixstr] = { value }
  else
    list[#list + 1] = value
  end
end

local window3 = window(PREFIX_SIZE + 1, NOWORD)

for words in window3(allwords()) do
  local newprefix = prefix(table.pack(table.unpack(words, 1, #words - 1)))
  insert(newprefix, words[#words])
end

local current = {}
for _ = 1, PREFIX_SIZE do table.insert(current, NOWORD) end

for _ = 1, MAXGEN do
  local list = state[prefix(current)]
  local r = math.random(#list)
  local nextword = list[r]
  if nextword == NOWORD then return end
  io.write(nextword, " ")
  table.remove(current, 1)
  table.insert(current, nextword)
end
