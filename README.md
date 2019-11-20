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

9. Create a 'world' AKA environment for our tests to run
``` ruby
module KnowsMyAccount
    def account
        @account ||= Account.new
    end
end
World(KnowsMyAccount)
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