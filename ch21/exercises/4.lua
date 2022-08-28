-- Exercise 21.4 A variation of the dual representation is to implement objects
-- using proxies (Section 20.4). Each object is represented by an empty proxy
-- table. An internal table maps proxies to tables that carry the object state.
-- This internal table is not accessible from the outside, but methods use it to
-- translate their self parameters to the real tables where they operate.
-- Implement the Account example using this approach and discuss its pros and
-- cons.

local Account = {}
local accounts = {}

function Account:new(o)
  local state = { balance = 0 }
  local o = o or {}
  for k, v in pairs(o) do
    state[k] = v
  end

  local proxy = {}
  accounts[proxy] = state

  self.__index = self
  setmetatable(o, self)
  o.__index = o
  setmetatable(proxy, o)
  return proxy
end

function Account:getBalance()
  return accounts[self].balance or 0
end

function Account:deposit(v)
  accounts[self].balance = accounts[self].balance + v
end

local acc1 = Account:new()
local acc2 = Account:new()
print(acc1:getBalance())
print(acc2:getBalance())
acc1:deposit(100)
acc2:deposit(200)
print(acc1:getBalance())
print(acc2:getBalance())

SpecialAccount = Account:new()
s = SpecialAccount:new{limit=1000.00}

function SpecialAccount:withdraw (v)
  if v - self:getBalance() >= self:getLimit() then
    error"insufficient funds"
  end
  accounts[self].balance = accounts[self].balance - v
end

function SpecialAccount:getLimit ()
  return self.limit or 0
end

print(s:getLimit())
s:withdraw(100)
print(s:getBalance())
