class Account
    def initialize()
    end

    def deposit(amount)
        @balance = amount
    end

    def balance()
        return @balance
    end
end

class Teller
    def initialize(cash_slot)
        @cash_slot = cash_slot
    end
    def withdraw_from(account, amount)
        @cash_slot.dispense(amount)
    end
end

class CashSlot
    def contents
        @contents or raise("I'm empty")
    end

    def dispense(amount)
        @contents = amount
    end
end

module Bank
    def account
        @account ||= Account.new
    end

    def cash_slot
        @cash_slot ||= CashSlot.new
    end

    def teller
        @teller ||= Teller.new(cash_slot)
    end
end
World(Bank)

Given(/^I have deposited \$(\d+) in my account$/) do |amount|
    # Deposit money into an account
    account.deposit(amount.to_i)

    # RSpec assertion:
    # Check to see if the deposited amount == the amount in the account
    expect(account.balance).to eq(amount.to_i),
        "Expected account balance to be #{amount.to_i} but it was #{account.balance}"
end
  
When(/^I request \$(\d+)$/) do |amount|
    teller.withdraw_from(account, amount)
    # expect(@account.balance).to eq(newBalance),
    #     "Expected account balance to be #{newBalance} but it was #{@account.balance}"
end
  
Then(/^\$(\d+) should be dispensed$/) do |amount|
    expect(cash_slot.contents).to eq(amount)
end