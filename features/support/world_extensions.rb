module Bank2
    class UserInterface
        include Capybara::DSL

        def withdraw_from(account, amount)
            Sinatra::Application.account = account
            visit '/'
            fill_in 'Amount', :with => amount
            click_button 'Withdraw'
        end
    end

    def account
        @account ||= Account.new
    end

    def cash_slot
        Sinatra::Application.cash_slot
    end

    def teller
        @teller ||= UserInterface.new
    end
end

# World(Bank2)