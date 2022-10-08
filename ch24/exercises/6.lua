-- 24.6 Implement a transfer function in Lua. It suspends the running coroutine
--    and resumes any other coroutine. Hint: use a kind of dispatch to control
--    your coroutines.

-- I looked at GitHub code through code search for "transfer coroutine
-- language:lua" because I really wasn't sure what was being asked of me :(
-- In the end it really was as simple as calling coroutine.yield in transfer,
-- but the twist is that you somehow need to pass the next coroutine through
-- yield.

function transfer(co)
  coroutine.yield(co)
end

function dispatch(co)
  local success, next = true, co
  while true do
    success, next = coroutine.resume(next)
    if not success or not next then
      return
    end
  end
end

co1 = coroutine.create(function ()
  print("hi 1")
  transfer(co2)
  print("hi 1")
  transfer(co2)
  print("hi 1")
  transfer(co2)
end)

co2 = coroutine.create(function ()
  print("hi 2")
  transfer(co1)
  print("hi 2")
  transfer(co1)
  print("hi 2")
  transfer(co1)
end)

dispatch(co1)
