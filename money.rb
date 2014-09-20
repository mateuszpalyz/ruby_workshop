class Money
  def initialize(amount, currency)
    @amount = amount
    @currency = currency
  end

  def to_s
    "#{format('%.2f', @amount)} #{@currency}"
  end

  def inspect
    "#<Money #{to_s}>"
  end

  class << self
    ["usd", "eur", "gbp"].each do |currency|
      define_method "from_#{currency}" do |amount|
        Money.new(amount, currency.upcase)
      end
    end
  end
end
