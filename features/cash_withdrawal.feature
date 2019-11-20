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
        # Step 4:
        And the balance of my account should be $80