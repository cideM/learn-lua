-- Remove "math" and the other file fails to run
env = { math = math, print = print }
fn, err = loadfile("env.lua", "t", env)
if err then
  print(err)
else
  fn()
end
