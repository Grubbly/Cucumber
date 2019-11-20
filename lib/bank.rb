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