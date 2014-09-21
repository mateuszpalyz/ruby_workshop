require './rate'
require './object'

class Exchange
  @@currencies = ["USD", "EUR", "GBP", "CHF", "JPY", "PLN"]

  def convert(money, currency)
    raise InvalidCurrency, currency       unless @@currencies.include? currency
    raise InvalidCurrency, money.currency unless @@currencies.include? money.currency

    rate = Rate(money.currency, currency)
    calculate(money.amount, rate)
  end

  def calculate(amount, rate)
    amount * rate
  end

  def self.currencies
    @@currencies
  end

  class InvalidCurrency < StandardError
    def message
      "Invalid currency: " + super
    end
  end
end
