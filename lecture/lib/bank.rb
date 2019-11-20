# BACKEND
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

# WEB FRONTEND
require 'sinatra'
get '/' do
    %{
        <html>
            <body>
                <form action="/withdraw" method="post">
                    <label for="amount">Amount</label>
                    <input type="text" id="amount" name="amount">
                    <button type="submit">Withdraw</button>
                </form>
            </body>
        </html>
    }
end

post '/withdraw' do
    fail "Withdraw is not implemented yet :D"
end

set :cash_slot, CashSlot.new
set :account do
    fail 'Account not set'
end
post '/withdraw' do
    teller = Teller.new(settings.cash_slot)
    fail "Withdraw is not implemented yet :D"
end