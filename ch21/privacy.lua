function newAccount (initial)
  local self = {balance = initial}
  local withdraw = function (v)
                    self.balance = self.balance - v
                  end
  local getBalance = function (v) return self.balance end
  return {
    withdraw = withdraw,
    getBalance = getBalance
  }
end

acc = newAccount(100.00)
acc.withdraw(40.00)
print(acc.getBalance())
acc:withdraw(20.00)
print(acc.getBalance())
