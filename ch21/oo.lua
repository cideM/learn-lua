-- Account = { balance = 0 }

-- function Account.withdraw (v)
--   Account.balance = Account.balance - v
-- end

-- a, Account = Account, nil
-- a.withdraw(100)

Account = { balance = 0 }

function Account.withdraw (self, v)
  self.balance = self.balance - v
end

function Account:deposit (v)
  self.balance = self.balance + v
end

function Account:foo (v)
  return self.balance
end

a = Account
a:withdraw(100)
a:deposit(200)
Account.balance = 500
print(a:foo())
