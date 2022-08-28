local Account = { balance = 0 }

function Account:new(o)
  local o = o or {}
  -- Without this line, calling this script results in:
  self.__index = self
  -- lua: ./ch21/inheritance.lua:20: attempt to call a nil value (method 'new')
  -- stack traceback:
  --         ./ch21/inheritance.lua:20: in main chunk
  --         [C]: in ?
  setmetatable(o, self)
  return o
end

function Account:deposit(v)
  self.balance = self.balance + v
end

function Account:getBalance()
  return self.balance or 0
end

SpecialAccount = Account:new()
s = SpecialAccount:new{limit=1000.00} -- This fails without the self.__index line

function SpecialAccount:withdraw (v)
  if v - self.balance >= self:getLimit() then
    error"insufficient funds"
  end
  self.balance = self.balance - v
end

function SpecialAccount:getLimit ()
  return self.limit or 0
end

print(s:getLimit())
s:withdraw(100)
print(s:getBalance())

acc1 = Account:new()
acc1:deposit(100)
acc2 = Account:new()
acc2:deposit(200)
print(acc1:getBalance(), acc2:getBalance())
