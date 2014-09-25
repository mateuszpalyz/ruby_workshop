require './exchange'

class Money
  include Comparable

  def <=>(other)
    @amount <=> other.exchange_to(@currency)
  end

  attr_reader :amount, :currency

  def initialize(amount, currency = Money.default_currency)
    raise ArgumentError.new("No currency given") unless currency

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
    attr_reader :default_currency

    ["usd", "eur", "gbp"].each do |currency|
      define_method "from_#{currency}" do |amount|
        Money.new(amount, currency.upcase)
      end
    end

    def using_default_currency(currency)
      previous_default_currency = @default_currency
      @default_currency = currency
      return_value = yield
      @default_currency = previous_default_currency
      return_value
    end

    def exchange
      Exchange.new
    end
  end

  def exchange_to(currency)
    Money.exchange.convert(self, currency)
  end

  def to_int
    @currency == "USD" ? @amount.to_int : exchange_to("USD").to_int
  end

  def method_missing(method, *arguments, &block)
    method.to_s =~ /^to_(.*)$/ && Exchange.currencies.include?($1.upcase) ? exchange_to($1.upcase) : super
  end

  def respond_to?(method)
    method.to_s =~ /^to_(.*)$/ && Exchange.currencies.include?($1.upcase) ? true : super
  end
end
