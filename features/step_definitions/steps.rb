require 'bank'

Given(/^I have deposited \$(\d+) in my account$/) do |amount|
    # Deposit money into an account
    account.deposit(amount.to_i)

    # RSpec assertion:
    # Check to see if the deposited amount == the amount in the account
    expect(account.balance).to eq(amount.to_i),
        "Expected account balance to be #{amount.to_i} but it was #{account.balance}"
end
  
When(/^I request \$(\d+)$/) do |amount|
    teller.withdraw_from(account, amount.to_i)
end
  
Then(/^\$(\d+) should be dispensed$/) do |amount|
    expect(cash_slot.contents).to eq(amount.to_i)
end

Then(/^the balance of my account should be \$(\d+)$/) do |amount|
    expect(account.balance).to eq(amount.to_i),
        "Expected account balance to be #{amount.to_i} but it was #{acount.balance}"
end