require './rate'
require './object'

class Exchange
  @@currencies = ["USD", "EUR", "GBP", "CHF", "JPY", "PLN"]

  def convert(money, currency)
    raise InvalidCurrency, currency       unless @@currencies.include? currency
    raise InvalidCurrency, money.currency unless @@currencies.include? money.currency

    @multiplier = Rate(money.currency, currency).get_multiplier
    calculate(money.amount, @multiplier)
  end

  def calculate(amount, rate)
    amount * rate
  end

  class InvalidCurrency < StandardError
    def message
      "Invalid currency: " + super
    end
  end
end
