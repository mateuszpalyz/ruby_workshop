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
end
