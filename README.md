# Cucumber
Cucumber examples with Ruby from The Cucumber Book

## Cash Withdrawal
1. Make a feature for testing

features/cash_withdrawal.feature
``` ruby
# Feature - A specific functionality of our application
    # Description - What is the context behind the test?
Feature: Cash Withdrawal

    Customer walks to ATM to get cash from their account.

    # Scenario - What are we testing?
    Scenario: Successful withdrawal from an account in credit
        # Step 1:
        Given I have deposited $100 in my account
        # Step 2:
        When I request $20
        # Step 3:
        Then $20 should be dispensed
```

2. Generate function templates for steps

features/step_definitions/steps.rb
``` ruby
$ *cucumber*

Given("I have deposited ${int} in my account") do |int|
    pending # Write code here that turns the phrase above into concrete actions
end
  
When("I request ${int}") do |int|
    pending # Write code here that turns the phrase above into concrete actions
end
  
Then("${int} should be dispensed") do |int|
    pending # Write code here that turns the phrase above into concrete actions
end
```

3. Run cucumber again and note steps are in a pending state

4. Implement a basic class to handle functionality
``` ruby
class Account
    def initialize(amount)
    end
end
```

5. Use Regex to parse out important components of the step
``` ruby
Given(/^I have deposited \$(\d+) in my account$/) do |amount|
    Account.new(amount.to_i)
end
```

6. Run cucumber - notice one of the steps is now passing

7. Implement an RSpec assertion to check if operation was valid
``` ruby
# RSpec assertion:
# Check to see if the deposited amount == the amount in the account
expect(account.balance).to eq(amount.to_i),
    "Expected account balance to be #{amount} but it was #{account.balance}"
```

8. Make the class actually do something
``` ruby
class Account
    def initialize()
    end

    def deposit(amount)
        @balance = amount
    end

    def balance()
        @balance
    end
end

Given(/^I have deposited \$(\d+) in my account$/) do |amount|
    # Deposit money into an account
    account = Account.new
    account.deposit(amount.to_i)

    # RSpec assertion:
    # Check to see if the deposited amount == the amount in the account
    expect(account.balance).to eq(amount.to_i),
        "Expected account balance to be #{amount} but it was #{account.balance}"
end
```

9. Create a 'world' AKA environment for our tests to run that defines global objects used by steps
``` ruby
module Bank
    def account
        @account ||= Account.new
    end
end
World(Bank)
```

10. Implement When
``` ruby
class Teller
    def withdraw_from(account, amount)
    end
end

When(/^I request \$(\d+)$/) do |amount|
    teller = Teller.new
    teller.withdraw_from(account, amount)
    # expect(@account.balance).to eq(newBalance),
    #     "Expected account balance to be #{newBalance} but it was #{@account.balance}"
end
```
11. Emulate an ATM and add it to the world
``` ruby
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
```
12. Change When and Then to reflect new world changes - Everything passes but there's a bug in When that doesn't subtract money from account.
``` ruby
When(/^I request \$(\d+)$/) do |amount|
    teller.withdraw_from(account, amount)
    # expect(@account.balance).to eq(newBalance),
    #     "Expected account balance to be #{newBalance} but it was #{@account.balance}"
end
  
Then(/^\$(\d+) should be dispensed$/) do |amount|
    expect(cash_slot.contents).to eq(amount)
end
```

13. Move implementation and tests into different files

features/support/env.rb
``` ruby
require 'bank'
```

lib/bank.rb
``` ruby
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
```

features/cash_withdrawal.feature
``` ruby
# Feature - A specific functionality of our application
    # Description - What is the context behind the test?
Feature: Cash Withdrawal

    Customer walks to ATM to get cash from their account.

    # Scenario - What are we testing?
    Scenario: Successful withdrawal from an account in credit
        # Step 1:
        Given I have deposited $100 in my account
        # Step 2:
        When I request $20
        # Step 3:
        Then $20 should be dispensed
```
14. Fix the withdrawal bug by adding another then step

bank.rb
``` ruby
class Account
    def initialize()
    end

    def deposit(amount)
        @balance = amount
    end

    def balance
        @balance
    end

    def withdraw(amount)
        @balance -= amount
    end
end

class Teller
    def initialize(cash_slot)
        @cash_slot = cash_slot
    end
    def withdraw_from(account, amount)
        account.withdraw(amount)
        @cash_slot.dispense(amount)
    end
end
```

steps.rb
``` ruby
Then(/^the balance of my account should be \$(\d+)$/) do |amount|
    expect(account.balance).to eq(amount.to_i),
        "Expected account balance to be #{amount.to_i} but it was #{account.balance}"
end
```

15. Reword the step

steps.rb
``` ruby
And(/^the balance of my account should be \$(\d+)$/) do |amount|
    expect(account.balance).to eq(amount.to_i),
        "Expected account balance to be #{amount.to_i} but it was #{account.balance}"
end
```

cash_withdrawal.feature
``` ruby
# Step 4:
And the balance of my account should be $80
```