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
    def withdraw_from(account, amount)
    end
end

module KnowsMyAccount
    def account
        @account ||= Account.new
    end
end
World(KnowsMyAccount)

Given(/^I have deposited \$(\d+) in my account$/) do |amount|
    # Deposit money into an account
    account.deposit(amount.to_i)

    # RSpec assertion:
    # Check to see if the deposited amount == the amount in the account
    expect(account.balance).to eq(amount.to_i),
        "Expected account balance to be #{amount.to_i} but it was #{account.balance}"
end
  
When(/^I request \$(\d+)$/) do |amount|
    teller = Teller.new
    teller.withdraw_from(account, amount)
    # expect(@account.balance).to eq(newBalance),
    #     "Expected account balance to be #{newBalance} but it was #{@account.balance}"
end
  
Then("${int} should be dispensed") do |int|
    pending # Write code here that turns the phrase above into concrete actions
end